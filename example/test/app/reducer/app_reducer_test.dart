import 'package:flutter/material.dart';
import 'package:flutter_claude/app/action/app_action.dart';
import 'package:flutter_claude/app/reducer/app_reducer.dart';
import 'package:flutter_claude/app/state/app_state.dart';
import 'package:flutter_claude/app/state/app_toast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const initial = AppState();

  group('appReducer', () {
    group('initialized', () {
      test('상태 변경 없음', () {
        final result = appReducer(initial, const AppAction.initialized());
        expect(result, initial);
      });
    });

    group('initializedSucceeded', () {
      test('isInitialized를 true로 변경', () {
        final result =
            appReducer(initial, const AppAction.initializedSucceeded());
        expect(result.isInitialized, true);
      });
    });

    group('showToast', () {
      test('toast 필드를 지정한 메시지와 타입으로 설정', () {
        final result = appReducer(
          initial,
          const AppAction.showToast('저장 완료', AppToastType.success),
        );
        expect(result.toast?.message, '저장 완료');
        expect(result.toast?.type, AppToastType.success);
      });

      test('타입 미지정 시 기본값 info', () {
        final result = appReducer(
          initial,
          const AppAction.showToast('안내', AppToastType.info),
        );
        expect(result.toast?.type, AppToastType.info);
      });
    });

    group('toastDismissed', () {
      test('toast를 null로 초기화', () {
        final withToast = initial.copyWith(
          toast: const AppToast(message: '메시지', type: AppToastType.error),
        );
        final result = appReducer(withToast, const AppAction.toastDismissed());
        expect(result.toast, isNull);
      });
    });

    group('themeModeChanged', () {
      test('themeMode를 변경', () {
        final result = appReducer(
          initial,
          const AppAction.themeModeChanged(ThemeMode.dark),
        );
        expect(result.themeMode, ThemeMode.dark);
      });

      test('system으로 복원 가능', () {
        final dark =
            initial.copyWith(themeMode: ThemeMode.dark);
        final result = appReducer(
          dark,
          const AppAction.themeModeChanged(ThemeMode.system),
        );
        expect(result.themeMode, ThemeMode.system);
      });
    });
  });
}
