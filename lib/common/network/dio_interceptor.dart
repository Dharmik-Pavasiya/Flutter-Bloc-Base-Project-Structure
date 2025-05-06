import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_base_structure/core/app_extension.dart';

import 'dio_exception.dart';

/// A Dio interceptor to handle request logging, response logging,
/// error handling, and automatic request retries.
class DioInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries = 3; // Maximum retry attempts
  static const _retryCountKey = 'retry_count';
  static const _startTimeKey = 'start_time';

  DioInterceptor(this.dio);

  /// Logs the request details before it is sent.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final headers = Map<String, dynamic>.from(options.headers);
    // Redact sensitive headers if needed
    if (headers.containsKey('Authorization')) {
      headers['Authorization'] = '***REDACTED***';
    }

    "==================== 🚀 REQUEST 🚀 ====================".printSuccess;
    "[METHOD]  => ${options.method}".printSuccess;
    "[URL]     => ${options.uri}".printSuccess;
    "[HEADERS] => $headers".printSuccess;
    "[BODY]    => ${options.data}".printSuccess;
    "[TIMEOUT] => ${options.sendTimeout}ms (send), ${options.connectTimeout}ms (connect), ${options.receiveTimeout}ms (receive)"
        .printSuccess;
    "==================== 🚀 REQUEST 🚀 ====================\n".printSuccess;

    // Initialize retry count and start time if not present
    options.extra[_retryCountKey] = options.extra[_retryCountKey] ?? 0;
    options.extra[_startTimeKey] = DateTime.now().millisecondsSinceEpoch;

    super.onRequest(options, handler);
  }

  /// Logs the response details when a response is received.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final startTime = response.requestOptions.extra[_startTimeKey] as int?;
    final duration =
        startTime != null
            ? DateTime.now().millisecondsSinceEpoch - startTime
            : 0;

    "==================== 📤 RESPONSE 📤 ====================".printSuccess;
    "[STATUS]  => ${response.statusCode} ${response.statusMessage}"
        .printSuccess;
    "[URL]     => ${response.requestOptions.uri}".printSuccess;
    "[TIME]    => ${duration}ms".printSuccess;
    "[HEADERS] => ${response.headers}".printSuccess;
    "[DATA]    => ${_truncateData(response.data)}".printSuccess;
    "==================== 📤 RESPONSE 📤 ====================\n".printSuccess;

    super.onResponse(response, handler);
  }

  /// Handles errors and retries the request if applicable.
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _retryRequest(err, handler);
  }

  /// Determines whether the request should be retried based on the error type.
  bool _shouldRetry(DioException error) {
    return [
      DioExceptionType.connectionTimeout,
      DioExceptionType.receiveTimeout,
      DioExceptionType.sendTimeout,
      DioExceptionType.connectionError,
    ].contains(error.type);
  }

  /// Retries the failed request with exponential backoff.
  Future<void> _retryRequest(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final retryCount = error.requestOptions.extra[_retryCountKey] as int? ?? 0;

    // Log detailed error information on first attempt
    if (retryCount == 0) {
      _logDetailedError(error);
    }

    if (_shouldRetry(error) && retryCount < maxRetries) {
      final newRetryCount = retryCount + 1;
      error.requestOptions.extra[_retryCountKey] = newRetryCount;

      final delay = Duration(seconds: 1 << retryCount);
      "🔄 [RETRYING] Attempt $newRetryCount/$maxRetries in ${delay.inSeconds}s for ${error.requestOptions.uri}"
          .printError;

      await Future.delayed(delay);

      try {
        final response = await dio.fetch(error.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        // Let it propagate (will re-enter onError)
      }
    }

    // Final failure after all retries
    if (retryCount >= maxRetries) {
      "🚨 [FINAL FAILURE] After $maxRetries attempts for ${error.requestOptions.uri}"
          .printError;
      _logDetailedError(error);
    }

    handler.reject(DioExceptions.getDioException(error));
  }

  /// Logs detailed error information
  void _logDetailedError(DioException error) {
    final startTime = error.requestOptions.extra[_startTimeKey] as int?;
    final duration =
        startTime != null
            ? DateTime.now().millisecondsSinceEpoch - startTime
            : 0;

    """==================== ❌ ERROR DETAILS ❌ ====================
          [TYPE]        => ${error.type}
          [URL]         => ${error.requestOptions.uri}
          [METHOD]      => ${error.requestOptions.method}
          [TIME]        => ${duration}ms
          [STATUS CODE] => ${error.response?.statusCode}
          [STATUS MSG]  => ${error.response?.statusMessage}
          ${error.response?.headers.map.entries.map((e) {
      return "${[e.key.toCapital]} => ${e.value}";
    })}
          [RESPONSE DATA] => ${_truncateData(error.response?.data)}
          [REQUEST DATA] => ${_truncateData(error.requestOptions.data)}
       ==================== ❌ ERROR DETAILS ❌ ====================""".printError;
  }

  /// Truncates large data for logging purposes
  dynamic _truncateData(dynamic data) {
    if (data == null) return null;

    if (data is String && data.length > 500) {
      return '${data.substring(0, 500)}... [TRUNCATED ${data.length - 500} chars]';
    } else if (data is Map && data.toString().length > 500) {
      final truncated = Map.from(data);
      truncated['_truncated'] =
          '... [TRUNCATED ${data.toString().length - 500} chars]';
      return truncated;
    } else if (data is List && data.toString().length > 500) {
      return '[List with ${data.length} items, first item: ${_truncateData(data.isNotEmpty ? data.first : null)}...]';
    }
    return data;
  }
}
