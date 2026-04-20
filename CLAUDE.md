# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Development Commands

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs
flutter run
flutter test
flutter test test/feature/home/reducer/home_reducer_test.dart
flutter analyze
```

`*.freezed.dart`, `*.g.dart` — 소스 파일과 생성 파일은 같은 커밋에 포함.

아키텍처·상태관리·네이밍 규칙은 `.claude/rules/`에 정의.

## Commit Convention

`<type>(<scope>): <subject>` — 한국어, 명령형, 50자 이내. 상세 규칙은 `/code-commit` 스킬 참조.
