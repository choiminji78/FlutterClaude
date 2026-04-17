import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_entity.freezed.dart';

@freezed
class ContactEntity with _$ContactEntity {
  const factory ContactEntity({
    required int id,
    required String name,
    required String phone,
  }) = _ContactEntity;
}
