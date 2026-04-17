import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
sealed class AppException with _$AppException {
  const factory AppException.network(String message) = AppNetwork;
  const factory AppException.server(int statusCode, String message) = AppServer;
  const factory AppException.unauthorized(String message) = AppUnauthorized;
  const factory AppException.forbidden(String message) = AppForbidden;
  const factory AppException.notFound(String message) = AppNotFound;
  const factory AppException.timeout(String message) = AppTimeout;
  const factory AppException.unknown(String message) = AppUnknown;
}
