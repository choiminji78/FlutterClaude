import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:flutter_claude/domain/post/entity/post_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_create_action.freezed.dart';

@freezed
sealed class PostCreateAction with _$PostCreateAction {
  const factory PostCreateAction.titleChanged(String title) = TitleChanged;
  const factory PostCreateAction.bodyChanged(String body) = BodyChanged;
  const factory PostCreateAction.createPostStarted({
    required String title,
    required String body,
  }) = CreatePostStarted;
  const factory PostCreateAction.createPostSucceeded(PostEntity post) =
      CreatePostSucceeded;
  const factory PostCreateAction.createPostFailed(AppException error) =
      CreatePostFailed;
}
