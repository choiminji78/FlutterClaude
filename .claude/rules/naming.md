# Naming

> 전체 네이밍 표: 스킬 호출 시 `.claude/docs/naming-detail.md` 로드됨

## 핵심 패턴

- 파일: `snake_case`, `[대상]_[역할].dart` (예: `user_repository_impl.dart`)
- 클래스: `PascalCase`, `[Domain][Role]` (예: `UserRepositoryImpl`)
- 디렉토리: `snake_case`

## Action 네이밍

- 비동기: `[동사][명사]Started` / `Succeeded` / `Failed`
- 단순 UI: `[동사][명사]` (예: `tabChanged`, `searchQueryChanged`)

## Provider 네이밍

- Riverpod Generator 자동 생성: 클래스명 기반 camelCase + `Provider`
- 예: `UserViewModel` -> `userViewModelProvider`

## DI 파일

- 도메인: `[domain]_di.dart` / 스토리지: `storage_di.dart` / 네트워크: `network_di.dart` / 진입점: `di.dart`
