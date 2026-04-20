# State Management

## 패턴

- Riverpod + TCA. 단방향 흐름: `UI → dispatch(Action) → 큐(FIFO) → Reducer → State / Effect`.

## Freezed 규칙

- `Action`, `AppResult`, `ApiResponse`, `StorageResponse`, `AppException`: **sealed class** + 반드시 `when()` 사용.
- `State`: **data class** + `copyWith`.
- **`maybeWhen()` 전체 금지.**

## State

- Freezed data class. `@Default`로 초기값 명시. 로딩은 `isLoading` 필드로 관리.

## Action

- sealed class. 비동기 작업은 **Started / Succeeded / Failed** 세트.
- `DateTime`, `Uuid` 등 side effect 값은 Action 페이로드로 주입 (Reducer에서 생성 금지).

## Reducer

- **순수 함수**. 상태 변경만. 비동기/사이드 이펙트 금지.
- 모든 Action 케이스를 `when()`으로 처리. 누락 불허.

## Effect

- 비동기 작업 처리. **State 직접 변경 금지** — 반드시 `dispatch(Action) → Reducer` 경로.
- `AppResult`의 모든 케이스를 Action으로 변환하여 dispatch.
- 관심 없는 Action은 `when()`에서 `null` 반환.
- **중복 실행 방어는 Effect 내부 guard flag로.** UI `isLoading` 방어는 보조 수단.

## ViewModel

- `BaseViewModel<S, A>` mixin + `@riverpod`. Reducer와 Effect를 orchestration.
- Effect는 ViewModel이 직접 생성·소유. 별도 Provider 등록 금지.
- feature ViewModel: `@riverpod` (AutoDispose). AppViewModel: `@Riverpod(keepAlive: true)`.

## AppState 범위

- **포함**: 앱 전체 생명주기, 2개+ feature가 동시 참조 (로케일, 테마, 토스트, 네트워크 상태).
- **미포함**: 특정 화면 전용, 화면 이동 시 초기화 가능 (필터값, 폼 입력, 페이지네이션).
