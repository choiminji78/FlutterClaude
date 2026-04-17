import 'package:flutter_claude/core/network/exception/network_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success(T data) = ApiSuccess<T>;
  const factory ApiResponse.failure(NetworkException exception) =
      ApiFailure<T>;
}
