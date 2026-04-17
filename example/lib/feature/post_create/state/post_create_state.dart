import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:flutter_claude/domain/post/entity/post_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_create_state.freezed.dart';

@freezed
class PostCreateState with _$PostCreateState {
  const factory PostCreateState({
    @Default('') String titleInput,
    @Default('') String bodyInput,
    @Default(false) bool isLoading,
    @Default(null) AppException? error,
    @Default(null) PostEntity? createdPost,
  }) = _PostCreateState;
}
