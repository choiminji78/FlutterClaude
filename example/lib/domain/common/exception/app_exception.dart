import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
sealed class AppException with _$AppException {
  const factory AppException.notFound(String message) = AppNotFound;
  const factory AppException.unknown(String message) = AppUnknown;
}
