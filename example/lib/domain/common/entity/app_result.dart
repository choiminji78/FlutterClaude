import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_result.freezed.dart';

@freezed
sealed class AppResult<T> with _$AppResult<T> {
  const factory AppResult.success(T data) = AppSuccess<T>;
  const factory AppResult.failure(AppException exception) = AppFailure<T>;
}
