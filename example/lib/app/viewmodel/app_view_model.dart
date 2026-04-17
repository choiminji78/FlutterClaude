import 'package:flutter/material.dart';
import 'package:flutter_claude/app/action/app_action.dart';
import 'package:flutter_claude/app/effect/app_effect.dart';
import 'package:flutter_claude/app/reducer/app_reducer.dart';
import 'package:flutter_claude/app/router/app_router.dart';
import 'package:flutter_claude/app/state/app_state.dart';
import 'package:flutter_claude/app/state/app_toast.dart';
import 'package:flutter_claude/core/viewmodel/base_keep_alive_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_view_model.g.dart';

@Riverpod(keepAlive: true)
class AppViewModel extends _$AppViewModel
    with BaseKeepAliveViewModel<AppState, AppAction> {
  late final _effect = AppEffect(ref, dispatch);

  @override
  AppState build() => buildInitialState();

  @override
  AppState buildInitialState() => const AppState();

  @override
  AppState reduce(AppState state, AppAction action) =>
      appReducer(state, action);

  @override
  Future<void> handleEffect(AppAction action) =>
      _effect.handleEffect(action);

  // ── Navigation ──

  void go(String path) => ref.read(appRouterProvider).go(path);
  void push(String path) => ref.read(appRouterProvider).push(path);
  void pop() => ref.read(appRouterProvider).pop();

  // ── Toast ──

  void showToast(String message, {AppToastType type = AppToastType.info}) =>
      dispatch(AppAction.showToast(message, type));

  void showError(String message) =>
      dispatch(AppAction.showToast(message, AppToastType.error));

  // ── Theme ──

  void changeThemeMode(ThemeMode mode) =>
      dispatch(AppAction.themeModeChanged(mode));
}
