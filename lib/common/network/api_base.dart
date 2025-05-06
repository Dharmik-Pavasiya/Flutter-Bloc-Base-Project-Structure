import 'package:dio/dio.dart';
import 'package:flutter_bloc_base_structure/common/network/dio_exception.dart';

import '../../core/api_config.dart';
import 'dio_interceptor.dart';

/// A singleton class to manage API requests using Dio.
abstract class ApiBaseService {
  static final Map<String, ApiBaseService> _instances =
      {}; // Holds singleton instances per baseUrl

  ApiBaseService({String baseUrl = ApiConfig.baseUrl}) {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: ApiConfig.connectionTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      headers: {"Content-Type": "application/json"},
    );
    _dio.interceptors.add(DioInterceptor(_dio));
  } // Private constructor to prevent instantiation

  final Dio _dio = Dio();
  CancelToken _cancelToken = CancelToken();

  /// Sets authentication token for API requests.
  ///
  /// This method adds the provided [token] to the request headers as a Bearer token.
  void setAuthToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  /// Cancels ongoing API requests and resets the cancel token.
  ///
  /// Useful for avoiding memory leaks or stopping unwanted requests.
  ///
  /// [reason] - Optional reason for cancellation.
  void cancelRequests({String cancelReason = "Request cancelled"}) {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel(cancelReason);
    }
    _cancelToken = CancelToken();
  }

  /// A generic method to handle API requests, including regular requests and file downloads.
  ///
  /// This method supports multiple HTTP methods (`GET`, `POST`, `PUT`, `DELETE`, `DOWNLOAD`)
  /// and includes error handling for API failures.
  ///
  /// [method] - The HTTP method to be used (`GET`, `POST`, `PUT`, `DELETE`, `DOWNLOAD`).
  /// [endpoint] - The API endpoint or URL.
  /// [data] - (Optional) The request body data for `POST`, `PUT`, or `DELETE` methods.
  /// [queryParams] - (Optional) Query parameters to append to the URL.
  /// [options] - (Optional) Additional Dio request options.
  /// [cancelToken] - (Optional) A `CancelToken` to cancel the request if needed.
  /// [savePath] - (Optional) The file path where the downloaded file should be saved (used only for `DOWNLOAD`).
  /// [onProgress] - (Optional) A callback function to track download progress (used only for `DOWNLOAD`).
  ///
  /// Returns a [Future] containing the API response. If the request is a file download,
  /// the response contains the file save path.
  ///
  /// Throws an exception if the request fails.
  Future<Response> _request({
    required String method,
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
    CancelToken? cancelToken,
    String? savePath,
    bool shouldCancel = false,
    String? cancelReason,
    void Function(int, int)? onProgress,
  }) async {
    // try {
      if (shouldCancel) {
        // Validate reason if cancellation is requested
        if (cancelReason == null || cancelReason.isEmpty) {
          throw ArgumentError(
            "Cancellation reason must be provided when shouldCancel is true.",
          );
        }
        cancelRequests(cancelReason: cancelReason);
      }

      // Handle file download requests separately
      if (method == "DOWNLOAD" && savePath != null) {
        await _dio.download(
          endpoint,
          savePath,
          onReceiveProgress: onProgress,
          cancelToken: cancelToken,
        );
        return Response(
          requestOptions: RequestOptions(path: endpoint),
          statusCode: 200, // Indicating successful file download
          data: savePath, // Returning the file save path
        );
      }

      // Handle standard API requests
      return await _dio.request(
        endpoint,
        data: data,
        queryParameters: queryParams,
        options: options?.copyWith(method: method) ?? Options(method: method),
        cancelToken: cancelToken,
      );
    // } on DioException catch (error) {
    //   throw DioExceptions.handleHttpException(
    //     error,
    //   ); // Pass the error to be handled by the calling function
    // }
  }

  /// Performs a GET request.
  ///
  /// [endpoint] - API endpoint.
  /// [queryParams] - Optional query parameters.
  ///
  /// Returns a [Future] containing the API response.
  Future<Response> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) => _request(method: "GET", endpoint: endpoint, queryParams: queryParams);

  /// Performs a POST request.
  ///
  /// [endpoint] - API endpoint.
  /// [data] - Request body.
  ///
  /// Returns a [Future] containing the API response.
  Future<Response> postRequest({required String endpoint, dynamic data}) =>
      _request(
        method: "POST",
        endpoint: endpoint,
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

  /// Performs a PUT request.
  ///
  /// [endpoint] - API endpoint.
  /// [data] - Request body.
  ///
  /// Returns a [Future] containing the API response.
  Future<Response> putRequest({required String endpoint, dynamic data}) =>
      _request(method: "PUT", endpoint: endpoint, data: data);

  /// Performs a DELETE request.
  ///
  /// [endpoint] - API endpoint.
  /// [queryParams] - Optional query parameters.
  ///
  /// Returns a [Future] containing the API response.
  Future<Response> deleteRequest({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) =>
      _request(method: "DELETE", endpoint: endpoint, queryParams: queryParams);

  /// Uploads a file to the specified endpoint.
  ///
  /// [endpoint] - API endpoint.
  /// [filePath] - Path to the file being uploaded.
  /// [data] - Optional additional form data.
  ///
  /// Returns a [Future] containing the API response.
  Future<Response> uploadFile({
    required String endpoint,
    required String filePath,
    Map<String, dynamic>? data,
  }) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath),
      ...?data,
    });

    return _request(
      method: "POST",
      endpoint: endpoint,
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
  }

  /// Downloads a file from the specified URL and saves it to the given local path.
  ///
  /// This method uses the `_request` function with the `"DOWNLOAD"` method to handle file downloads.
  /// It also supports an optional progress callback and cancellation.
  ///
  /// [downloadUrl] - The direct URL of the file to be downloaded.
  /// [savePath] - The local file path where the downloaded file should be saved.
  /// [onProgress] - (Optional) A callback function that provides real-time progress updates.
  ///   - It receives two parameters: `(receivedBytes, totalBytes)`.
  ///   - Example: `(received, total) => print("$received / $total bytes downloaded")`.
  /// [cancelToken] - (Optional) A `CancelToken` to allow cancellation of the download request.
  ///
  /// Returns a [Future] containing the local file path where the file was successfully saved.
  ///
  /// Throws an exception if the download fails.
  Future<String> downloadFile({
    required String downloadUrl,
    required String savePath,
    void Function(int, int)? onProgress,
    CancelToken? cancelToken,
  }) async {
    final response = await _request(
      method: "DOWNLOAD",
      endpoint: downloadUrl,
      savePath: savePath,
      onProgress: onProgress,
      cancelToken: cancelToken,
    );

    return response.data as String; // Returning the saved file path
  }
}
