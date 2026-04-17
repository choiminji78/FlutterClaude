import 'package:dio/dio.dart';

abstract class BaseClient {
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });
  Future<Response<dynamic>> post(String path, {dynamic data});
  Future<Response<dynamic>> put(String path, {dynamic data});
  Future<Response<dynamic>> patch(String path, {dynamic data});
  Future<Response<dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
}
