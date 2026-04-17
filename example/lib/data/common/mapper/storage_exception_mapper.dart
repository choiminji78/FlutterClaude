import 'package:flutter_claude/core/storage/common/exception/storage_exception.dart';
import 'package:flutter_claude/domain/common/exception/app_exception.dart';

class StorageExceptionMapper {
  const StorageExceptionMapper();

  AppException map(StorageException exception) {
    return exception.when(
      notFound: (message) => AppException.notFound(message),
      general: (message) => AppException.unknown(message),
    );
  }
}
