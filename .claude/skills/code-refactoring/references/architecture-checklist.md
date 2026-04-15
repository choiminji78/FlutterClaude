# Architecture Refactoring Checklist

올바른 패턴과 코드 템플릿은 `.claude/rules/`와 `.claude/docs/` 참조.

## High Priority

### 레이어 의존성
- `feature → feature` 직접 참조
- `domain`에서 Riverpod/Flutter import
- `core`, `domain`이 상위 레이어(`feature`, `data`, `app`) 참조
- DTO가 `domain`/`feature`에 위치 → `data/[domain]/dto/`로 이동
- Entity가 `data`/`feature`에 위치 → `domain/[domain]/entity/`로 이동
- Persistence Model이 `data`/`feature`에 위치 → `core/storage/database/`로 이동
- Mapper가 Repository 외부(UseCase, ViewModel)에서 호출
- Storage Service가 Entity 반환 (Persistence Model만 허용)
- UseCase가 `ApiResponse`/`StorageResponse` 직접 처리

### 래퍼 모델
- ViewModel이 `NetworkException`/`StorageException` 직접 참조 (`AppFailure`만 허용)
- Repository가 `AppResult<Entity>` 외 타입 반환
- `AppResult`에 로딩 케이스 추가 (State `isLoading` 필드로 관리)
- 에러 변환(`ApiFailure → AppFailure`, `StorageFailure → AppFailure`)이 Repository 외부에서 발생

### TCA 패턴
- Reducer에 `async`/`await` 또는 사이드 이펙트(`DateTime.now()`, `Uuid()`) 포함
- `maybeWhen()` 사용
- Effect가 `state` 직접 변경
- Effect가 `AppResult` failure를 Action으로 변환하지 않음
- Effect 비동기 메서드에 guard flag 없음
- 비동기 Action에 Started/Succeeded/Failed 세트 불완전
- Side effect 값을 Reducer에서 생성 (Action 페이로드로 주입해야 함)
- ViewModel이 `BaseViewModel<S, A>` 미사용
- Effect를 별도 Provider로 등록
- `dispatch()` 없이 `state = ...` 직접 변경

## Medium Priority

### Riverpod
- `build()` 밖에서 `ref.watch`
- 이벤트 콜백에서 `ref.watch` (`ref.read` 사용)
- `app/di` Provider가 AutoDispose (`keepAlive: true` 필요)
- Feature ViewModel이 `keepAlive: true` (AutoDispose 필요)
- Action이 `data class` (sealed class 필요)
- State가 `sealed class` (data class 필요)

### 네이밍
- 파일: `snake_case`, `[대상]_[역할].dart` 미준수
- 클래스: `PascalCase`, `[Domain][Role]` 미준수
- 비동기 Action: Started/Succeeded/Failed 패턴 미준수
- 단순 UI Action: `동사 + 명사` 패턴 미준수

### DI
- DI 등록이 `app/di` 외부에 존재
- 등록 순서: DataSource → Repository → UseCase 미준수
- `di.dart`에 export 누락

### Navigation
- Feature ViewModel이 GoRouter 직접 참조
- Navigation이 AppAction으로 처리됨 (편의 메서드 사용)

### 로컬 저장소
- ViewModel/UseCase에서 저장소 서비스 직접 참조 (DataSource 경유 필요)
- 여러 저장소 혼용 시 local DataSource에서 미통합

## Low Priority

### 코드 레벨
- 중첩 조건문 3단계 이상 → early return
- 매직 넘버/문자열 → 상수 추출
- 동일 로직 2회 이상 중복 → 메서드 추출
- 50줄 초과 메서드 → 분리 검토
- 불필요한 `!` 남용 → 타입 안전성 개선
- `async` 함수에서 `await` 없음 → `async` 제거

### 테스트
- `test/` 구조가 `lib/` 미러링 미준수
- 파일명 `[원본]_test.dart` 미준수
- Reducer 테스트에서 Action 케이스 미커버
- domain 테스트에서 Riverpod 참조
