import 'package:flutter_claude/core/storage/common/exception/storage_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_response.freezed.dart';

@freezed
sealed class StorageResponse<T> with _$StorageResponse<T> {
  const factory StorageResponse.success(T data) = StorageSuccess<T>;
  const factory StorageResponse.failure(StorageException exception) =
      StorageFailure<T>;
}
