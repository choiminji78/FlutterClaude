import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/post/entity/post_entity.dart';

abstract class PostRepository {
  Future<AppResult<PostEntity>> createPost({
    required int userId,
    required String title,
    required String body,
  });
}
