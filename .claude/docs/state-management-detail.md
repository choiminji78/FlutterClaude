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
mixin BaseViewModel<S, A> on AutoDisposeNotifier<S> {
  late final StreamController<A> _actionQueue;
  late StreamSubscription<A> _subscription;

  S buildInitialState();
  S reduce(S state, A action);
  Future<void> handleEffect(A action) async {}

  @override
  S build() {
    _actionQueue = StreamController<A>();
    _subscription = _actionQueue.stream.listen(_process);
    ref.onDispose(_dispose);
    return buildInitialState();
  }

  void dispatch(A action) {
    if (_actionQueue.isClosed) return;
    _actionQueue.add(action);
  }

  void _process(A action) {
    state = reduce(state, action);
    unawaited(handleEffect(action));
  }

  void _dispose() {
    _subscription.cancel();
    _actionQueue.close();
  }
}

// AppViewModel용 (keepAlive)
mixin BaseKeepAliveViewModel<S, A> on Notifier<S> {
  // BaseViewModel과 동일한 구조, AutoDisposeNotifier 대신 Notifier 상속
}
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
| Effect 독립 실행 | Effect는 완료를 기다리지 않고 다음 Action을 즉시 처리한다 |
| 재귀 호출 방지 | Effect 내부에서 dispatch해도 큐에 적재되어 현재 처리 완료 후 실행 |
| dispose 후 방어 | `_actionQueue.isClosed` 체크로 화면 이탈 후 콜백 dispatch를 조용히 무시 |
| Effect 중복 제어 | 중복 실행 방어는 Effect 내부 guard가 담당한다 |

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
