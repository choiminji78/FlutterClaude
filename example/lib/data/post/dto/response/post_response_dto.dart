import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_response_dto.freezed.dart';
part 'post_response_dto.g.dart';

@freezed
class PostResponseDto with _$PostResponseDto {
  const factory PostResponseDto({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _PostResponseDto;

  factory PostResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PostResponseDtoFromJson(json);
}
