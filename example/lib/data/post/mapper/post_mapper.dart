import 'package:flutter_claude/data/post/dto/response/post_response_dto.dart';
import 'package:flutter_claude/domain/post/entity/post_entity.dart';

class PostMapper {
  const PostMapper();

  PostEntity toDomain(PostResponseDto dto) {
    return PostEntity(
      id: dto.id,
      userId: dto.userId,
      title: dto.title,
      body: dto.body,
    );
  }
}
