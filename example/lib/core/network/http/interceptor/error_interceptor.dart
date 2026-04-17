import 'package:dio/dio.dart';
import 'package:flutter_claude/core/network/exception/network_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: _toNetworkException(err),
      ),
    );
  }

  NetworkException _toNetworkException(DioException err) {
    final message = err.message ?? '';
    return switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout =>
        NetworkException.timeout(message),
      DioExceptionType.connectionError => NetworkException.network(message),
      DioExceptionType.badResponse => _fromStatusCode(
          err.response?.statusCode ?? 0,
          message,
        ),
      _ => NetworkException.unknown(message),
    };
  }

  NetworkException _fromStatusCode(int code, String message) {
    return switch (code) {
      401 => NetworkException.unauthorized(message),
      403 => NetworkException.forbidden(message),
      404 => NetworkException.notFound(message),
      >= 500 => NetworkException.server(code, message),
      _ => NetworkException.unknown(message),
    };
  }
}
