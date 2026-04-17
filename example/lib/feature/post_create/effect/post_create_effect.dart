import 'package:flutter_claude/app/di/post_di.dart';
import 'package:flutter_claude/feature/post_create/action/post_create_action.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostCreateEffect {
  PostCreateEffect(this._ref, this._dispatch);

  final Ref _ref;
  final void Function(PostCreateAction) _dispatch;

  bool _isCreating = false;

  Future<void> handleEffect(PostCreateAction action) async {
    await action.when(
      titleChanged: (_) => null,
      bodyChanged: (_) => null,
      createPostStarted: (title, body) => _createPost(title, body),
      createPostSucceeded: (_) => null,
      createPostFailed: (_) => null,
    );
  }

  Future<void> _createPost(String title, String body) async {
    if (_isCreating) return;
    _isCreating = true;
    try {
      final repo = _ref.read(postRepositoryProvider);
      final result = await repo.createPost(userId: 1, title: title, body: body);
      result.when(
        success: (post) =>
            _dispatch(PostCreateAction.createPostSucceeded(post)),
        failure: (e) => _dispatch(PostCreateAction.createPostFailed(e)),
      );
    } finally {
      _isCreating = false;
    }
  }
}
