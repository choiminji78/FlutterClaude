---
name: add-feature
description: This skill should be used when the user asks to "피처 추가", "화면 추가", "feature 만들어줘", "뷰모델 추가", "add-feature", or requests to create a new feature screen with State, Action, Reducer, Effect, ViewModel, and Page in the feature layer.
argument-hint: "[feature 이름 (예: home, profile, settings)]"
---

# Add Feature

`feature/[feature]/`에 TCA 패턴 전체 구조(State, Action, Reducer, Effect, ViewModel, Page)를 생성하고 라우트를 등록한다.

> 레이어 의존 규칙 → `.claude/docs/architecture-detail.md`
> TCA 코드 템플릿·큐 동작 → `.claude/docs/state-management-detail.md`
> 파일명·클래스명 패턴 → `.claude/docs/naming-detail.md`
> 테스트 패턴 → `.claude/docs/testing-detail.md`

---

## 단계 0: 기반 파일 사전 확인

Glob으로 아래 파일의 존재 여부를 확인한다.

```
lib/core/viewmodel/base_view_model.dart
lib/domain/common/entity/app_result.dart
lib/domain/common/exception/app_exception.dart
```

| 파일 | 없을 때 대응 |
|---|---|
| `base_view_model.dart` | "BaseViewModel이 없습니다. `/init-project`로 프로젝트 기반 구조를 먼저 생성해 주세요." 안내 후 중단 |
| `app_result.dart` / `app_exception.dart` | "AppResult/AppException이 없습니다. `/init-project`로 프로젝트 기반 구조를 먼저 생성해 주세요." 안내 후 중단 |

모두 존재하면 단계 1로 이동.

---

## 단계 1: Feature 이름 결정

패턴: `[feature]_page.dart` → 클래스 `[Feature]Page`, 위치 `feature/[feature]/`

**`$ARGUMENTS` 있는 경우** — feature 이름으로 해석.

**`$ARGUMENTS` 없는 경우** — 화면 이름·역할을 질문.

Glob으로 `lib/feature/[feature]/` 존재 여부 확인.

| 상태 | 대응 |
|---|---|
| 이미 존재 | "동일한 feature가 있습니다. 덮어쓸까요?" 확인 후 진행 |
| 없음 | 다음 단계로 |

---

## 단계 2: 요구사항 파악

아래를 **한 번에** 질문한다.

**1. Action 목록** — 이 화면에서 발생하는 동작

- 비동기 작업 (API 호출, 저장 등) → **Started / Succeeded / Failed** 세트로 자동 생성
- 단순 UI 변경 (탭 전환, 입력값 변경 등) → 단일 Action
- 예: `데이터 로드`, `탭 전환`, `폼 제출`

**2. State 필드** — 화면에 필요한 데이터와 타입

- `isLoading: bool`, `error: AppException?`는 항상 포함 (생략 가능)
- 예: `UserEntity? user`, `List<ProductEntity> products`, `int selectedTab`

**3. Effect에서 호출할 UseCase** (비동기 Action이 있을 때)

- 예: `getUserUseCaseProvider`, `fetchProductsUseCaseProvider`
- 없으면 Effect는 모든 케이스에서 `null` 반환

**4. 라우트 경로**

- 예: `/profile`, `/home/settings`
- `app/router/app_routes.dart` 미존재 시 건너뜀

---

## 단계 2.5: UseCase DI 검증 (비동기 Action이 있을 때만)

사용자가 UseCase Provider 이름을 제공한 경우, Grep으로 존재 여부를 확인한다.

```
Grep 패턴: [verb][Domain]UseCaseProvider
경로: lib/app/di/
```

| 상태 | 대응 |
|---|---|
| 검색됨 | 다음 단계로 |
| 없음 | "해당 UseCase가 DI에 등록되어 있지 않습니다. `/add-usecase`로 먼저 생성해 주세요." 안내 후 중단. 또는 UseCase 없이 Effect를 빈 상태로 생성하고 나중에 연결할 것인지 사용자에게 확인 |

---

## 단계 3: 파일 목록 제시

생성할 파일 목록을 제시하고 사용자 확인 후 작성한다.

```
lib/feature/[feature]/state/[feature]_state.dart
lib/feature/[feature]/action/[feature]_action.dart
lib/feature/[feature]/reducer/[feature]_reducer.dart
lib/feature/[feature]/effect/[feature]_effect.dart
lib/feature/[feature]/viewmodel/[feature]_view_model.dart
lib/feature/[feature]/view/[feature]_page.dart
lib/app/router/app_routes.dart                               ← GoRoute 추가 (기존 파일 수정)
test/feature/[feature]/reducer/[feature]_reducer_test.dart
test/feature/[feature]/viewmodel/[feature]_view_model_test.dart  ← 비동기 Action이 있을 때만
```

---

## 단계 4: 코드 생성

### State

```dart
import 'package:flutter_claude/domain/common/exception/app_exception.dart';
// 필요한 Entity import 추가
import 'package:freezed_annotation/freezed_annotation.dart';

part '[feature]_state.freezed.dart';

@freezed
class [Feature]State with _$[Feature]State {
  const factory [Feature]State({
    @Default(false) bool isLoading,
    @Default(null) AppException? error,
    // 사용자가 지정한 필드 추가
    // @Default(null) [Domain]Entity? [domain],
    // @Default([]) List<[Domain]Entity> [domains],
  }) = _[Feature]State;
}
```

### Action

```dart
import 'package:flutter_claude/domain/common/exception/app_exception.dart';
// 필요한 Entity import 추가
import 'package:freezed_annotation/freezed_annotation.dart';

part '[feature]_action.freezed.dart';

@freezed
sealed class [Feature]Action with _$[Feature]Action {
  // 비동기 세트 (Started/Succeeded/Failed):
  const factory [Feature]Action.fetchStarted() = FetchStarted;
  const factory [Feature]Action.fetchSucceeded([ReturnType] data) = FetchSucceeded;
  const factory [Feature]Action.fetchFailed(AppException error) = FetchFailed;

  // 단순 UI Action 예시:
  // const factory [Feature]Action.tabChanged(int index) = TabChanged;
}
```

> `when()`으로만 처리. **`maybeWhen()` 전체 금지.**

### Reducer

```dart
import 'package:flutter_claude/feature/[feature]/action/[feature]_action.dart';
import 'package:flutter_claude/feature/[feature]/state/[feature]_state.dart';

[Feature]State [feature]Reducer([Feature]State state, [Feature]Action action) {
  return action.when(
    fetchStarted: () => state.copyWith(isLoading: true, error: null),
    fetchSucceeded: (data) => state.copyWith(isLoading: false, [field]: data),
    fetchFailed: (error) => state.copyWith(isLoading: false, error: error),
    // tabChanged: (index) => state.copyWith(selectedTab: index),
  );
}
```

> 순수 함수 — 비동기/사이드 이펙트 절대 금지.

### Effect

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_claude/feature/[feature]/action/[feature]_action.dart';
// import UseCase Provider (비동기 Action이 있을 때)
// import 'package:flutter_claude/app/di/[domain]_di.dart';

class [Feature]Effect {
  [Feature]Effect(this._ref, this._dispatch);

  final Ref _ref;
  final void Function([Feature]Action) _dispatch;

  // 비동기 Action이 있을 때만 guard flag 추가
  bool _isFetching = false;

  Future<void> handleEffect([Feature]Action action) async {
    await action.when(
      fetchStarted: () => _fetch(),
      fetchSucceeded: (_) => null,
      fetchFailed: (_) => null,
      // tabChanged: (_) => null,
    );
  }

  Future<void> _fetch() async {
    if (_isFetching) return;
    _isFetching = true;
    try {
      final result = await _ref.read([verb][Domain]UseCaseProvider).call();
      result.when(
        success: (data) => _dispatch([Feature]Action.fetchSucceeded(data)),
        failure: (e) => _dispatch([Feature]Action.fetchFailed(e)),
      );
    } finally {
      _isFetching = false;
    }
  }
}
```

> **State 직접 변경 금지** — 반드시 `_dispatch(Action) -> Reducer` 경로.
> UseCase 없으면 guard flag와 private 메서드 제거, `handleEffect`의 모든 케이스에서 `null` 반환.

### ViewModel

```dart
import 'dart:async';

import 'package:flutter_claude/core/viewmodel/base_view_model.dart';
import 'package:flutter_claude/feature/[feature]/action/[feature]_action.dart';
import 'package:flutter_claude/feature/[feature]/effect/[feature]_effect.dart';
import 'package:flutter_claude/feature/[feature]/reducer/[feature]_reducer.dart';
import 'package:flutter_claude/feature/[feature]/state/[feature]_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '[feature]_view_model.g.dart';

@riverpod
class [Feature]ViewModel extends _$[Feature]ViewModel
    with BaseViewModel<[Feature]State, [Feature]Action> {

  late final _effect = [Feature]Effect(ref, dispatch);

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

> `@riverpod` (AutoDispose) — DI 수동 등록 불필요. Provider 이름: `[feature]ViewModelProvider`.

### Page (빈 scaffold)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_claude/app/viewmodel/app_view_model.dart';
import 'package:flutter_claude/feature/[feature]/viewmodel/[feature]_view_model.dart';

class [Feature]Page extends ConsumerWidget {
  const [Feature]Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch([feature]ViewModelProvider);

    ref.listen([feature]ViewModelProvider, (prev, next) {
      if (next.error != null && prev?.error != next.error) {
        ref.read(appViewModelProvider.notifier).showError(
          next.error!.when(/* 에러 메시지 변환 */),
        );
      }
    });

    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return const Scaffold(
      body: Center(child: Text('TODO: 화면 구현')),
    );
  }
}
```

> `ref.watch`: State 구독 (빌드). `ref.listen`: 부수 효과 — 에러는 `ScaffoldMessenger` 직접 호출 금지, 반드시 `appViewModelProvider.notifier.showError()` 위임. `ref.read`: 이벤트 콜백 내 dispatch.

### 라우트 등록

`lib/app/router/app_routes.dart`를 **Read** 한 뒤 GoRoute를 추가한다.

```dart
GoRoute(
  path: '[route_path]',
  builder: (context, state) => const [Feature]Page(),
),
```

> 기존 파일 구조를 Read로 파악한 뒤 적절한 위치에 삽입. 사용자 확인 없이 수정 금지.

### 테스트 작성

> `.claude/docs/testing-detail.md` **Reducer 테스트** / **ViewModel 테스트** 섹션 참조.

**Reducer 테스트** (`test/feature/[feature]/reducer/[feature]_reducer_test.dart`): 모든 Action 케이스를 망라해 작성한다.

**ViewModel 테스트** (`test/feature/[feature]/viewmodel/[feature]_view_model_test.dart`): 비동기 Action이 있을 때만 생성. 성공·실패 흐름, guard flag 중복 실행 방어를 검증한다.

---

## 단계 5: build_runner

```bash
dart run build_runner build --delete-conflicting-outputs
```

변경 파일에 아래가 포함됐는지 확인한다.

- `[feature]_state.freezed.dart`
- `[feature]_action.freezed.dart`
- `[feature]_view_model.g.dart`

---

## 단계 6: 검증

```bash
flutter analyze
```

- feature 내부에서 다른 feature 직접 import 없음
- ViewModel에 `GoRouter` 직접 참조 없음
- Reducer 함수에 `async` / `await` 없음
- Effect 내부에 `state =` 직접 할당 없음
- `maybeWhen()` 없음

---

## 금지

- `maybeWhen()` 사용
- ViewModel / Reducer / State에 `GoRouter` 직접 참조
- Reducer에 비동기·사이드 이펙트
- Effect에서 State 직접 변경 (`state = ...`)
- feature 간 직접 import — 공유 데이터는 각자 UseCase 호출
- 사용자 확인 없이 기존 파일 수정 (특히 `app_routes.dart`)
