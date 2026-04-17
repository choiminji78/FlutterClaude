import 'package:flutter_claude/core/network/exception/network_exception.dart';
import 'package:flutter_claude/domain/common/exception/app_exception.dart';

class ExceptionMapper {
  const ExceptionMapper();

  AppException map(NetworkException exception) {
    return exception.when(
      network: (message) => AppException.network(message),
      server: (statusCode, message) => AppException.server(statusCode, message),
      unauthorized: (message) => AppException.unauthorized(message),
      forbidden: (message) => AppException.forbidden(message),
      notFound: (message) => AppException.notFound(message),
      timeout: (message) => AppException.timeout(message),
      unknown: (message) => AppException.unknown(message),
    );
  }
}
