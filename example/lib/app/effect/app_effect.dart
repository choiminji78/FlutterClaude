import 'package:flutter_claude/app/action/app_action.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppEffect {
  AppEffect(this._ref, this._dispatch);

  // ignore: unused_field
  final Ref _ref;
  final void Function(AppAction) _dispatch;

  Future<void> handleEffect(AppAction action) async {
    await action.when(
      initialized: () => _initialize(),
      initializedSucceeded: () => null,
      showToast: (message, type) => null,
      toastDismissed: () => null,
      themeModeChanged: (_) => null,
    );
  }

  Future<void> _initialize() async {
    // 앱 초기화 로직 (토큰 복원, 캐시 워밍 등)을 여기서 수행한다.
    _dispatch(const AppAction.initializedSucceeded());
  }
}
