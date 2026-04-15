# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Development Commands

```bash
# 의존성 설치
flutter pub get

# 코드 생성 (Freezed, Riverpod Generator, Hive, Drift 등)
dart run build_runner build --delete-conflicting-outputs

# 코드 생성 (watch 모드)
dart run build_runner watch --delete-conflicting-outputs

# 앱 실행
flutter run

# 테스트 전체 실행
flutter test

# 단일 테스트 파일 실행
flutter test test/feature/home/reducer/home_reducer_test.dart

# 분석 (린트)
flutter analyze
```

코드 생성 대상: `*.freezed.dart`, `*.g.dart`. 소스 파일과 생성 파일은 항상 같은 커밋에 포함한다.

## Architecture Overview

5-레이어 단방향 의존 구조. **역방향 참조 절대 금지.**

```
feature -> domain, app, core
data    -> domain, core
app     -> domain, data, core
domain  -> (없음, 순수 Dart)
core    -> (없음)
```

- **core**: 공통 기술 인프라 (network, storage, navigation, viewmodel base, logging)
- **data**: DTO, DataSource(remote/local), Repository 구현체, Mapper
- **domain**: Entity, Repository 인터페이스, UseCase — Riverpod 참조 금지, 순수 Dart만
- **feature**: View, ViewModel, State, Action, Reducer, Effect — feature 간 직접 참조 금지
- **app**: 진입점, DI 조합(`app/di`), 라우팅, AppViewModel

상태 관리: **Riverpod + TCA 패턴**. `UI -> dispatch(Action) -> Queue(FIFO) -> Reducer(동기) -> Effect(비동기)`.

상세 규칙과 코드 템플릿은 `.claude/rules/`와 `.claude/docs/`에 정의되어 있다.

## Key Constraints

- Freezed sealed class(`Action`, `AppResult`, `ApiResponse`, `StorageResponse`, `AppException`)는 반드시 `when()` 사용. **`maybeWhen()` 전체 금지.**
- Reducer는 순수 함수. 비동기/사이드 이펙트 금지.
- Effect는 State 직접 변경 금지. 반드시 `dispatch(Action) -> Reducer` 경로.
- Repository는 항상 `AppResult<Entity>` 반환. 래퍼 변환(`ApiResponse`/`StorageResponse` -> `AppResult`)은 Repository가 담당.
- ViewModel은 `AppFailure`만 수신. `NetworkException`/`StorageException` 직접 참조 금지.
- Navigation은 feature ViewModel에서 GoRouter 직접 참조 금지 — AppViewModel 편의 메서드 사용.
- DI는 모든 것을 `app/di`에서 정의. 등록 순서: DataSource -> Repository -> UseCase.

## Commit Convention

`<type>(<scope>): <subject>` — 한국어, 명령형, 50자 이내. 상세 규칙은 `/code-commit` 스킬 참조.
