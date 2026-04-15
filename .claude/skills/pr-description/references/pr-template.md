# PR Template

이 프로젝트 PR body 섹션 구조 · 작성 기준 · 레이어별 예시.

---

## 기본 템플릿

```markdown
## What changed

- 

## Why

- 

## How to test

- [ ] 
```

Breaking change가 있는 경우 Why 섹션에 추가:

```markdown
## Why

- 

> ⚠️ BREAKING CHANGE: <변경된 인터페이스 또는 필드 설명>
```

---

## 섹션별 작성 기준

### ## What changed

**목적**: 리뷰어가 무엇이 바뀌었는지 빠르게 파악하도록 돕는다.

| 기준 | 내용 |
|---|---|
| 단위 | 레이어 / 파일 역할 단위 (파일 경로 나열 금지) |
| 내용 | 기술적 사실만 서술. 이유·배경은 포함하지 않는다 |
| 개수 | 3~7개 bullet 권장 |
| 순서 | 의존 방향 순서: domain → data → core → app → feature |

**레이어별 서술 패턴:**

```markdown
- `domain/[domain]`: [추가/변경된 Entity, UseCase, Repository 인터페이스]
- `data/[domain]`: [추가/변경된 DTO, DataSource, Repository 구현체, Mapper]
- `core/network`: [변경된 Service, Interceptor, Exception]
- `core/storage`: [변경된 Service, Model, Exception]
- `app/di`: `[domain]Di` — [등록/변경된 Provider 목록]
- `app/router`: [추가/변경된 라우트]
- `feature/[feature]`: [추가/변경된 UI 컴포넌트, ViewModel, State, Action]
- `test/[path]`: [추가된 테스트 파일 및 커버리지 범위]
```

### ## Why

**목적**: 왜 이 변경이 필요했는지 배경과 의도를 설명한다.

| 기준 | 내용 |
|---|---|
| 출처 | 커밋 body 내용을 우선 활용 |
| 내용 | 비즈니스 요구사항, 아키텍처 결정, 기술적 이유 |
| 포함 | 트레이드오프나 대안 검토 내용이 있으면 추가 |
| Breaking change | `> ⚠️ BREAKING CHANGE:` 블록으로 명시 |

### ## How to test

**목적**: 리뷰어가 변경 사항을 직접 검증할 수 있도록 안내한다.

| 기준 | 내용 |
|---|---|
| 형식 | `- [ ]` 체크리스트 |
| 순서 | 실행 방법 → 확인 포인트 → 엣지 케이스 |
| 자동화 | 테스트 커맨드가 있으면 포함 |
| 구체성 | 리뷰어가 직접 따라할 수 있는 수준으로 작성 |

---

## 전체 작성 예시

### 예시 1 — 신규 기능 (전 레이어)

```markdown
## What changed

- `domain/post`: `PostEntity` 정의, `PostRepository` 인터페이스 추가, `GetPostListUseCase` 구현
- `data/post`: `PostResponseDto` 정의, `PostRemoteDataSource` API 연동, `PostMapper` 추가, `PostRepositoryImpl` 구현
- `app/di`: `postDi` — DataSource, Repository, UseCase Provider 등록
- `feature/feed`: 피드 화면 State / Action / Reducer / Effect / ViewModel / View 구현

## Why

- 앱 진입 시 피드 목록을 표시하기 위한 신규 기능
- Remote First 전략에 따라 캐시 없이 매번 API에서 조회

## How to test

- [ ] 앱 실행 후 피드 탭 진입
- [ ] 게시물 목록이 정상 표시되는지 확인
- [ ] 네트워크 오류 시 에러 메시지가 표시되는지 확인
- [ ] 목록이 비어 있을 때 빈 상태 UI가 표시되는지 확인
- [ ] `flutter test test/domain/post/usecase/get_post_list_usecase_test.dart`
- [ ] `flutter test test/feature/feed/reducer/feed_reducer_test.dart`
```

### 예시 2 — 버그 수정

```markdown
## What changed

- `data/user`: `ExceptionMapper` — `401 Unauthorized` 누락 케이스에 `UnauthorizedAppException` 추가
- `feature/auth`: `authReducer` — `fetchFailed` 시 `UnauthorizedAppException` 케이스 처리 추가

## Why

- 토큰 만료 시 앱이 에러 메시지 없이 로딩 상태에 멈추는 버그 수정
- `ExceptionMapper`에 401 케이스가 없어 `AppFailure`가 발생하지 않았음

## How to test

- [ ] 토큰을 강제 만료 상태로 설정 후 앱 재실행
- [ ] 인증이 필요한 화면 진입 시 로그인 화면으로 이동하는지 확인
- [ ] `flutter test test/data/user/repository/user_repository_impl_test.dart`
```

### 예시 3 — 리팩토링

```markdown
## What changed

- `feature/home`: `homeReducer` — `maybeWhen` → `when` 교체 (전체 Action 케이스 명시)
- `feature/home`: `HomeEffect._fetch()` — 중복 실행 guard flag 추가

## Why

- `maybeWhen` 사용으로 Action 케이스 누락 시 컴파일 타임에 감지 불가능한 상태였음
- Effect 중복 실행 방어 누락으로 빠른 연속 탭 시 API가 중복 호출되는 문제 해결

## How to test

- [ ] `flutter test test/feature/home/reducer/home_reducer_test.dart`
- [ ] 홈 화면에서 새로고침 버튼을 빠르게 연속으로 탭하여 API 중복 호출이 없는지 확인
```

### 예시 4 — Breaking change 포함

```markdown
## What changed

- `domain/user`: `UserEntity.userName` → `UserEntity.displayName` 필드 변경
- `data/user`: `UserMapper` — `userName` → `displayName` 매핑 업데이트
- `feature/profile`: 프로필 화면 `displayName` 필드 참조로 업데이트

## Why

- 디자인 시스템 기준 용어 통일 (`userName` → `displayName`)
- 백엔드 API 응답 필드명 변경에 맞춰 전 레이어 동기화

> ⚠️ BREAKING CHANGE: `UserEntity.userName`이 `UserEntity.displayName`으로 변경됨.
> `UserEntity`를 직접 참조하는 feature가 있다면 필드명 업데이트 필요.

## How to test

- [ ] 프로필 화면에서 표시 이름이 정상 출력되는지 확인
- [ ] `flutter analyze` 오류 없음 확인
- [ ] `flutter test` 전체 통과 확인
```

