import 'package:flutter_claude/core/viewmodel/base_view_model.dart';
import 'package:flutter_claude/feature/post_create/action/post_create_action.dart';
import 'package:flutter_claude/feature/post_create/effect/post_create_effect.dart';
import 'package:flutter_claude/feature/post_create/reducer/post_create_reducer.dart';
import 'package:flutter_claude/feature/post_create/state/post_create_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_create_view_model.g.dart';

@riverpod
class PostCreateViewModel extends _$PostCreateViewModel
    with BaseViewModel<PostCreateState, PostCreateAction> {
  late final _effect = PostCreateEffect(ref, dispatch);

  @override
  PostCreateState build() => buildInitialState();

  @override
  PostCreateState buildInitialState() => const PostCreateState();

  @override
  PostCreateState reduce(PostCreateState state, PostCreateAction action) =>
      postCreateReducer(state, action);

  @override
  Future<void> handleEffect(PostCreateAction action) =>
      _effect.handleEffect(action);

  void submit() {
    dispatch(PostCreateAction.createPostStarted(
      title: state.titleInput,
      body: state.bodyInput,
    ));
  }
}
