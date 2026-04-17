import 'package:flutter_claude/feature/post_create/action/post_create_action.dart';
import 'package:flutter_claude/feature/post_create/state/post_create_state.dart';

PostCreateState postCreateReducer(
  PostCreateState state,
  PostCreateAction action,
) {
  return action.when(
    titleChanged: (title) => state.copyWith(titleInput: title),
    bodyChanged: (body) => state.copyWith(bodyInput: body),
    createPostStarted: (title, body) =>
        state.copyWith(isLoading: true, error: null, createdPost: null),
    createPostSucceeded: (post) =>
        state.copyWith(isLoading: false, createdPost: post),
    createPostFailed: (error) =>
        state.copyWith(isLoading: false, error: error),
  );
}
