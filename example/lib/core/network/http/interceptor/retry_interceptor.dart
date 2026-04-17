import 'package:dio/dio.dart';
import 'package:flutter_claude/core/network/http/utils/network_constants.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor({required this.dio});
  final Dio dio;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = (err.requestOptions.extra['retryCount'] as int?) ?? 0;

    final shouldRetry = retryCount < NetworkConstants.maxRetryAttempts &&
        (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.connectionTimeout);

    if (!shouldRetry) {
      return handler.next(err);
    }

    err.requestOptions.extra['retryCount'] = retryCount + 1;
    try {
      final response = await dio.fetch(err.requestOptions);
      handler.resolve(response);
    } catch (_) {
      handler.next(err);
    }
  }
}
