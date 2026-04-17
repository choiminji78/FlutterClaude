import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_entity.freezed.dart';

@freezed
class PostEntity with _$PostEntity {
  const factory PostEntity({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _PostEntity;
}
