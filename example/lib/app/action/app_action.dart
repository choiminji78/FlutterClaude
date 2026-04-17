import 'package:flutter/material.dart';
import 'package:flutter_claude/app/state/app_toast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_action.freezed.dart';

@freezed
sealed class AppAction with _$AppAction {
  const factory AppAction.initialized() = AppInitialized;
  const factory AppAction.initializedSucceeded() = AppInitializedSucceeded;
  const factory AppAction.showToast(String message, AppToastType type) =
      AppShowToast;
  const factory AppAction.toastDismissed() = AppToastDismissed;
  const factory AppAction.themeModeChanged(ThemeMode mode) =
      AppThemeModeChanged;
}
