import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_request_dto.freezed.dart';
part 'post_request_dto.g.dart';

@freezed
class PostRequestDto with _$PostRequestDto {
  const factory PostRequestDto({
    required int userId,
    required String title,
    required String body,
  }) = _PostRequestDto;

  factory PostRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PostRequestDtoFromJson(json);
}
