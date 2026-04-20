import 'package:dio/dio.dart';
import 'package:flutter_claude/core/network/exception/network_exception.dart';
import 'package:flutter_claude/core/network/http/client/base_client.dart';
import 'package:flutter_claude/core/network/http/dto/api_response.dart';

class ApiService {
  const ApiService({required this.client});
  final BaseClient client;

  Future<ApiResponse<T>> get<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await client.get(path, queryParameters: queryParameters);
      return ApiResponse.success(fromJson(res.data as Map<String, dynamic>));
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<List<T>>> getList<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
    String? listKey,
  }) async {
    try {
      final res = await client.get(path, queryParameters: queryParameters);
      final raw = listKey != null
          ? (res.data as Map<String, dynamic>)[listKey] as List<dynamic>
          : res.data as List<dynamic>;
      return ApiResponse.success(
        raw.map((e) => fromJson(e as Map<String, dynamic>)).toList(),
      );
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<T>> post<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await client.post(path, data: body);
      return ApiResponse.success(fromJson(res.data as Map<String, dynamic>));
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<void>> postVoid(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      await client.post(path, data: body);
      return const ApiResponse.success(null);
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<T>> put<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await client.put(path, data: body);
      return ApiResponse.success(fromJson(res.data as Map<String, dynamic>));
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<void>> putVoid(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      await client.put(path, data: body);
      return const ApiResponse.success(null);
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<void>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await client.delete(path, queryParameters: queryParameters);
      return const ApiResponse.success(null);
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  NetworkException _extractException(DioException e) {
    return e.error is NetworkException
        ? e.error as NetworkException
        : NetworkException.unknown(e.message ?? '');
  }
}
