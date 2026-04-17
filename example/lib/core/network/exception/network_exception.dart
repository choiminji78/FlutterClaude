import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception.freezed.dart';

@freezed
sealed class NetworkException with _$NetworkException {
  const factory NetworkException.network(String message) =
      NetworkExceptionNetwork;
  const factory NetworkException.server(int statusCode, String message) =
      NetworkExceptionServer;
  const factory NetworkException.unauthorized(String message) =
      NetworkExceptionUnauthorized;
  const factory NetworkException.forbidden(String message) =
      NetworkExceptionForbidden;
  const factory NetworkException.notFound(String message) =
      NetworkExceptionNotFound;
  const factory NetworkException.timeout(String message) =
      NetworkExceptionTimeout;
  const factory NetworkException.unknown(String message) =
      NetworkExceptionUnknown;
}
