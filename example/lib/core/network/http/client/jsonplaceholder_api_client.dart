import 'package:dio/dio.dart';
import 'package:flutter_claude/core/network/http/client/base_client.dart';
import 'package:flutter_claude/core/network/http/interceptor/error_interceptor.dart';
import 'package:flutter_claude/core/network/http/interceptor/logging_interceptor.dart';
import 'package:flutter_claude/core/network/http/interceptor/retry_interceptor.dart';
import 'package:flutter_claude/core/network/http/utils/network_constants.dart';

class JsonplaceholderApiClient implements BaseClient {
  JsonplaceholderApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: NetworkConstants.jsonplaceholderBaseUrl,
        connectTimeout: NetworkConstants.connectTimeout,
        receiveTimeout: NetworkConstants.receiveTimeout,
      ),
    );
    _dio.interceptors.addAll([
      LoggingInterceptor(),
      RetryInterceptor(dio: _dio),
      ErrorInterceptor(),
    ]);
  }

  late final Dio _dio;

  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) =>
      _dio.get(
        path,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );

  @override
  Future<Response<dynamic>> post(String path, {dynamic data}) =>
      _dio.post(path, data: data);

  @override
  Future<Response<dynamic>> put(String path, {dynamic data}) =>
      _dio.put(path, data: data);

  @override
  Future<Response<dynamic>> patch(String path, {dynamic data}) =>
      _dio.patch(path, data: data);

  @override
  Future<Response<dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) =>
      _dio.delete(path, queryParameters: queryParameters);
}
