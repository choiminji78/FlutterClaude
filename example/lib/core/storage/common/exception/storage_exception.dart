import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_exception.freezed.dart';

@freezed
sealed class StorageException with _$StorageException {
  const factory StorageException.notFound(String message) = StorageNotFound;
  const factory StorageException.general(String message) = StorageGeneral;
}
