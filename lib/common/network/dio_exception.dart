import 'package:dio/dio.dart';
import 'package:flutter_bloc_base_structure/core/app_string.dart';

class DioExceptions extends DioException {
  /// The human-readable error message.
  final String errorMessage;

  /// Constructor for creating custom exceptions.
  DioExceptions({
    required this.errorMessage,
    required super.requestOptions,
    super.response,
    DioExceptionType? type,
    super.error,
    StackTrace? stackTrace,
  }) : super(
    type: type ?? DioExceptionType.unknown,
    stackTrace: stackTrace ?? StackTrace.current,
  );

  /// Converts the exception to a readable string format.
  @override
  String toString() {
    return "[${type.name}] $errorMessage";
  }

  /// Creates a copy of the exception with optional modified properties.
  @override
  DioException copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return DioExceptions(
      errorMessage: message ?? errorMessage,
      requestOptions: requestOptions ?? this.requestOptions,
      response: response ?? this.response,
      type: type ?? this.type,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  /// Returns the error message.
  @override
  String? get message => errorMessage;

  static DioExceptions getDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ConnectionTimeoutException(dioException.requestOptions);
      case DioExceptionType.receiveTimeout:
        return ReceiveTimeoutException(dioException.requestOptions);
      case DioExceptionType.sendTimeout:
        return RequestTimeoutException(dioException.requestOptions);
      case DioExceptionType.badCertificate:
        return BadCertificateException(dioException.requestOptions);
      case DioExceptionType.connectionError:
        return ConnectionErrorException(dioException.requestOptions);
      case DioExceptionType.badResponse:
        return DioExceptions.handleHttpException(dioException);
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        return FetchDataException(dioException.requestOptions);
    }
  }

  static DioExceptions handleHttpException(DioException error) {
    final statusCode = error.response?.statusCode ?? 0;
    final responseData = error.response?.data;

    // Try to extract error message from response
    String errorMessage = AppString.unknownError;

    if (responseData != null) {
      try {
        // Try to parse as JSON
        if (responseData is Map) {
          errorMessage = responseData['message'] ??
              responseData['error']?['details'] ??
              error.message ??
              AppString.unknownError;
        } else if (responseData is String) {
          errorMessage = responseData;
        }
      } catch (e) {
        errorMessage = error.message ?? AppString.unknownError;
      }
    } else {
      errorMessage = error.message ?? AppString.unknownError;
    }

    return switch (statusCode) {
      400 => BadRequestException(error.requestOptions, message: errorMessage),
      401 => UnAuthorizedException(error.requestOptions, message: errorMessage),
      403 => ForbiddenException(error.requestOptions, message: errorMessage),
      404 => NotFoundException(error.requestOptions, message: errorMessage),
      500 => InternalServerException(error.requestOptions, message: errorMessage),
      503 => ServiceUnavailableException(error.requestOptions, message: errorMessage),
      _ => FetchDataException(error.requestOptions, message: errorMessage),
    };
  }
}

/// Exception for no internet connection errors.
class NoInternetException extends DioExceptions {
  NoInternetException(RequestOptions requestOptions)
      : super(
    errorMessage: AppString.noInternetConnection,
    requestOptions: requestOptions,
    type: DioExceptionType.connectionError,
  );
}

/// Exception for unauthorized access (HTTP 401).
class UnAuthorizedException extends DioExceptions {
  UnAuthorizedException(RequestOptions requestOptions, {String? message})
      : super(
    errorMessage: message ?? AppString.unauthorized,
    requestOptions: requestOptions,
    type: DioExceptionType.badResponse,
  );
}

/// Exception for request timeout errors.
class RequestTimeoutException extends DioExceptions {
  RequestTimeoutException(RequestOptions requestOptions)
      : super(
    errorMessage: AppString.requestTimeOut,
    requestOptions: requestOptions,
    type: DioExceptionType.sendTimeout,
  );
}

/// Exception for connection timeout errors.
class ConnectionTimeoutException extends DioExceptions {
  ConnectionTimeoutException(RequestOptions requestOptions)
      : super(
    errorMessage: AppString.connectionTimeOut,
    requestOptions: requestOptions,
    type: DioExceptionType.connectionTimeout,
  );
}

/// Exception for receiving timeout errors.
class ReceiveTimeoutException extends DioExceptions {
  ReceiveTimeoutException(RequestOptions requestOptions)
      : super(
    errorMessage: AppString.receiveTimeOut,
    requestOptions: requestOptions,
    type: DioExceptionType.receiveTimeout,
  );
}

/// Exception for general network connection errors.
class ConnectionErrorException extends DioExceptions {
  ConnectionErrorException(RequestOptions requestOptions)
      : super(
    errorMessage: AppString.connectionError,
    requestOptions: requestOptions,
    type: DioExceptionType.connectionError,
  );
}

/// Exception for invalid SSL certificate errors.
class BadCertificateException extends DioExceptions {
  BadCertificateException(RequestOptions requestOptions)
      : super(
    errorMessage: AppString.badCertificate,
    requestOptions: requestOptions,
    type: DioExceptionType.badCertificate,
  );
}

/// Exception for bad requests (HTTP 400).
class BadRequestException extends DioExceptions {
  BadRequestException(RequestOptions requestOptions, {String? message})
      : super(
    errorMessage: message ?? AppString.badRequest,
    requestOptions: requestOptions,
    type: DioExceptionType.badResponse,
  );
}

/// Exception for forbidden access (HTTP 403).
class ForbiddenException extends DioExceptions {
  ForbiddenException(RequestOptions requestOptions, {String? message})
      : super(
    errorMessage: message ?? AppString.forbidden,
    requestOptions: requestOptions,
    type: DioExceptionType.badResponse,
  );
}

/// Exception for resource not found errors (HTTP 404).
class NotFoundException extends DioExceptions {
  NotFoundException(RequestOptions requestOptions, {String? message})
      : super(
    errorMessage: message ?? AppString.notFoundResource,
    requestOptions: requestOptions,
    type: DioExceptionType.badResponse,
  );
}

/// Exception for internal server errors (HTTP 500).
class InternalServerException extends DioExceptions {
  InternalServerException(RequestOptions requestOptions, {String? message})
      : super(
    errorMessage: message ?? AppString.internalServerError,
    requestOptions: requestOptions,
    type: DioExceptionType.badResponse,
  );
}

/// Exception for service unavailable errors (HTTP 503).
class ServiceUnavailableException extends DioExceptions {
  ServiceUnavailableException(RequestOptions requestOptions, {String? message})
      : super(
    errorMessage: message ?? AppString.serviceUnavailable,
    requestOptions: requestOptions,
    type: DioExceptionType.badResponse,
  );
}

/// Generic exception for unknown errors.
class FetchDataException extends DioExceptions {
  FetchDataException(RequestOptions requestOptions, {String? message})
      : super(
    errorMessage: message ?? AppString.unknownError,
    requestOptions: requestOptions,
  );
}