import 'package:flutter_claude/app/action/app_action.dart';
import 'package:flutter_claude/app/state/app_state.dart';
import 'package:flutter_claude/app/state/app_toast.dart';

AppState appReducer(AppState state, AppAction action) {
  return action.when(
    initialized: () => state,
    initializedSucceeded: () => state.copyWith(isInitialized: true),
    showToast: (message, type) =>
        state.copyWith(toast: AppToast(message: message, type: type)),
    toastDismissed: () => state.copyWith(toast: null),
    themeModeChanged: (mode) => state.copyWith(themeMode: mode),
  );
}
