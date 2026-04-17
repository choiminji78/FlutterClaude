# State Management Detail

## Freezed 사용 기준

| 대상 | Freezed 방식 | 이유 |
|---|---|---|
| `Action` | sealed class | Reducer에서 케이스 누락을 컴파일 타임에 방지 |
| `AppResult` | sealed class | ViewModel에서 모든 상태 처리 강제 |
| `ApiResponse` | sealed class | 변환 경계에서 누락 방지 |
| `StorageResponse` | sealed class | 변환 경계에서 누락 방지 |
| `AppException` | sealed class | 예외 타입별 처리 강제 |
| `State` | data class | 값 보유 목적, copyWith 활용 |

---

## 코드 템플릿

### State

```dart
@freezed
class [Feature]State with _$[Feature]State {
  const factory [Feature]State({
    @Default(false) bool isLoading,
    @Default(null) [Domain]Entity? [domain],
    @Default(null) AppException? error,
  }) = _[Feature]State;
}
```

### Action

```dart
@freezed
sealed class [Feature]Action with _$[Feature]Action {
  const factory [Feature]Action.fetchStarted()                           = FetchStarted;
  const factory [Feature]Action.fetchSucceeded([Domain]Entity [domain])  = FetchSucceeded;
  const factory [Feature]Action.fetchFailed(AppException error)          = FetchFailed;
  const factory [Feature]Action.tabChanged(int index)                    = TabChanged;
}
```

### Reducer

```dart
[Feature]State [feature]Reducer([Feature]State state, [Feature]Action action) {
  return action.when(
    fetchStarted:   ()         => state.copyWith(isLoading: true, error: null),
    fetchSucceeded: ([domain]) => state.copyWith(isLoading: false, [domain]: [domain]),
    fetchFailed:    (error)    => state.copyWith(isLoading: false, error: error),
    tabChanged:     (index)    => state.copyWith(selectedTab: index),
  );
}
```

### Effect (with guard flag)

```dart
@override
Future<void> handleEffect([Feature]Action action) async {
  await action.when(
    fetchStarted:   ()  => _fetch(),
    fetchSucceeded: (_) => null,
    fetchFailed:    (_) => null,
    tabChanged:     (_) => null,
  );
}

bool _isFetching = false;

Future<void> _fetch() async {
  if (_isFetching) return;
  _isFetching = true;
  try {
    final result = await ref.read(get[Domain]UseCaseProvider)(id);
    result.when(
      success: (entity) => dispatch([Feature]Action.fetchSucceeded(entity)),
      failure: (e)      => dispatch([Feature]Action.fetchFailed(e)),
    );
  } finally {
    _isFetching = false;
  }
}
```

### ViewModel

```dart
@riverpod
class [Feature]ViewModel extends _$[Feature]ViewModel
    with BaseViewModel<[Feature]State, [Feature]Action> {

  late final _effect = [Feature]Effect(ref, dispatch);

  // Riverpod Generator가 build()를 abstract로 생성하므로 명시적 override 필수.
  // BaseViewModel.build()가 buildInitialState()를 위임하는 경로를 확정한다.
  @override
  [Feature]State build() => buildInitialState();

  @override
  [Feature]State buildInitialState() => const [Feature]State();

  @override
  [Feature]State reduce([Feature]State state, [Feature]Action action) =>
      [feature]Reducer(state, action);

  @override
  Future<void> handleEffect([Feature]Action action) =>
      _effect.handleEffect(action);
}
```

### BaseViewModel

```dart
// feature ViewModel용
import 'dart:async';
import 'dart:collection';

mixin BaseViewModel<S, A> on AutoDisposeNotifier<S> {
  final Queue<A> _queue = Queue<A>();
  bool _isProcessing = false;

  S buildInitialState();
  S reduce(S state, A action);
  Future<void> handleEffect(A action) async {}

  @override
  S build() => buildInitialState();

  void dispatch(A action) {
    _queue.add(action);
    unawaited(_drain());
  }

  Future<void> _drain() async {
    if (_isProcessing) return;
    _isProcessing = true;
    while (_queue.isNotEmpty) {
      final action = _queue.removeFirst();
      state = reduce(state, action);
      try {
        await handleEffect(action);
      } catch (_) {
        // Effect 예외가 다음 액션 처리를 막지 않도록 격리
      }
    }
    _isProcessing = false;
  }
}

// AppViewModel용 (keepAlive)
// AutoDisposeNotifier 대신 Notifier<S>를 상속하는 BaseKeepAliveViewModel을
// lib/core/viewmodel/base_keep_alive_view_model.dart 에 동일 구조로 추가한다.
```

### View (ref 사용 기준)

```dart
class [Feature]Page extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch([feature]ViewModelProvider);           // 리빌드

    ref.listen([feature]ViewModelProvider, (prev, next) {          // 부수효과
      if (next.error != null) { /* 스낵바 등 */ }
    });

    return Scaffold(
      onPressed: () => ref.read([feature]ViewModelProvider.notifier) // 이벤트
          .dispatch([Feature]Action.fetchStarted()),
    );
  }
}
```

---

## 큐 동작 보장

| 보장 항목 | 설명 |
|---|---|
| Reducer 실행 순서 보장 | Reducer는 동기 실행이므로 dispatch 순서대로 State가 변경된다 |
| Effect 순차 처리 | `_drain()`이 Effect를 `await`하므로 한 Effect가 완료된 후 다음 Action을 처리한다 |
| dispatch 즉시 반환 | `dispatch()`는 `unawaited(_drain())`으로 호출 — 호출부를 블로킹하지 않는다 |
| 재귀 호출 방지 | `_isProcessing` 플래그로 중첩 `_drain()` 진입을 막는다. Effect 내 dispatch는 큐에 적재되어 현재 Effect 완료 후 순서대로 실행된다 |
| Effect 예외 격리 | Effect에서 예외가 발생해도 try/catch로 격리 — 다음 Action 처리에 영향 없음 |
| Effect 중복 제어 | 중복 실행 방어는 Effect 내부 guard flag가 담당한다 |

---

## Provider 스코프 규칙

| 위치 | 대상 | 스코프 |
|---|---|---|
| `app/di` | DataSource / Repository / UseCase | `@Riverpod(keepAlive: true)` |
| `app/viewmodel` | AppViewModel | `@Riverpod(keepAlive: true)` |
| `app/router` | GoRouter | `@Riverpod(keepAlive: true)` |
| `feature/viewmodel` | FeatureViewModel | `@riverpod` (화면 스코프) |

---

## AppState 범위 기준

**AppState에 포함:** 앱 전체 생명주기 유지 상태, 두 개 이상 feature가 동시 참조하는 상태 (로케일, 테마, 토스트, 네트워크 상태)

**AppState에 미포함:** 특정 화면 전용 상태, 화면 이동 시 초기화 가능한 상태 (필터값, 폼 입력값, 페이지네이션)

### 기본 AppState 필드

`isInitialized` 하나만 기본 포함. 나머지는 앱 요구사항에 따라 추가한다.

```dart
@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(false) bool isInitialized,  // 스플래시 게이트
  }) = _AppState;
}
```

### 선택적 전역 상태 예시

2개 이상 feature가 동시 참조하거나 앱 전체 생명주기가 필요한 경우에만 AppState에 추가한다.

| 필드 | 타입 | 용도 |
|---|---|---|
| `themeMode` | `ThemeMode` | 다크/라이트 테마 |
| `toast` | `AppToast?` | 전역 토스트 알림 |
| `locale` | `Locale?` | 다국어 |

### 전역 Toast 패턴 (toast 필드 추가 시)

feature에서 에러/성공 알림이 필요할 때 직접 ScaffoldMessenger를 호출하지 않고 AppViewModel 편의 메서드를 사용한다.

```dart
// feature View — ref.listen에서 AppViewModel로 위임
ref.listen(featureViewModelProvider, (prev, next) {
  if (next.error != null && prev?.error != next.error) {
    ref.read(appViewModelProvider.notifier).showError(
      next.error!.when(/* 메시지 변환 */),
    );
  }
});
```

```dart
// AppViewModel 편의 메서드
void showToast(String message, {AppToastType type = AppToastType.info}) =>
    dispatch(AppAction.showToast(message, type));
void showError(String message) =>
    dispatch(AppAction.showToast(message, AppToastType.error));
```

```dart
// app.dart — scaffoldMessengerKey로 한 곳에서 처리
ref.listen(
  appViewModelProvider.select((s) => s.toast),
  (_, toast) {
    if (toast == null) return;
    _messengerKey.currentState
      ?..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(toast.message)));
    ref.read(appViewModelProvider.notifier).dispatch(const AppAction.toastDismissed());
  },
);
```
