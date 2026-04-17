import 'package:flutter/material.dart';
import 'package:flutter_claude/app/state/app_toast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(false) bool isInitialized,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(null) AppToast? toast,
  }) = _AppState;
}
