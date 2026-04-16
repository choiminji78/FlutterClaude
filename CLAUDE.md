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

아키텍처·상태관리·네이밍 규칙은 `.claude/rules/`에 정의되어 있으며 대화 시작 시 자동 로드된다.

## Commit Convention

`<type>(<scope>): <subject>` — 한국어, 명령형, 50자 이내. 상세 규칙은 `/code-commit` 스킬 참조.
