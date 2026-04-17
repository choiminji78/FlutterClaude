# Architecture

> 코드 예시·디렉토리 구조: 스킬 호출 시 `.claude/docs/architecture-detail.md`, `.claude/docs/directory-structure.md` 로드됨

## 레이어 및 의존 방향 (역방향 절대 금지)

| 레이어 | 역할 |
|---|---|
| `core` | 공통 기술 — network, storage, logging, navigation, viewmodel 베이스 |
| `data` | 도메인 기반 데이터 — DTO, DataSource, Repository 구현체, Mapper |
| `domain` | 도메인 기반 비즈니스 — Entity, Repository 인터페이스, UseCase |
| `feature` | 화면(UI) — View, ViewModel, State, Action, Reducer, Effect |
| `app` | 앱 진입점 — 전역 상태, 라우팅, DI 조합 |

```
feature -> domain, app, core
data    -> domain, core
app     -> domain, data, core
domain  -> (없음)
core    -> (없음)
```

- `feature -> feature` 직접 참조는 절대 금지. 공유 데이터는 각자 UseCase를 호출한다.

## 모델 배치

- **DTO**: `data` 레이어에만. 서버 통신용.
- **Entity**: `domain` 레이어에만. 비즈니스 기준.
- **Persistence Model**: `core/storage`에만. 로컬 저장용.
- Mapper는 Repository 구현체에서만 호출. Entity 변환은 반드시 `data` Repository에서.

## 래퍼 모델

- `ApiResponse<T>` (`core/network`) / `StorageResponse<T>` (`core/storage`) / `AppResult<T>` (`domain/common`) — 세 래퍼는 예외 타입과 레이어가 다르므로 분리 유지.
- **Repository는 항상 `AppResult<Entity>`를 반환한다.**
- 모든 변환(`ApiResponse/StorageResponse -> AppResult`)은 Repository 구현체가 담당.

## 에러 전파 (단방향)

- `NetworkException -> ExceptionMapper -> AppException` (Repository에서 변환)
- `StorageException -> StorageExceptionMapper -> AppException` (Repository에서 변환)
- ViewModel은 `AppFailure`만 수신. `NetworkException`/`StorageException`을 직접 참조하지 않는다.

## 데이터 레이어

- DataSource: remote(API)와 local(저장소)로 분리.
- remote -> `ApiResponse<DTO>`, local -> `StorageResponse<PersistenceModel>`.
- Repository는 **Remote First**. local 저장은 명시적 Action이 있을 때만.

## UseCase vs 직접 Repository (Effect 경로)

- **경로 A** `Effect -> UseCase -> Repository`: 기본.
- **경로 B** `Effect -> Repository (직접)`: Repository 1개만 사용 + 비즈니스 로직 없음 (가공/분기 없음) 둘 다 만족 시에만.
- UseCase 필요 기준: Repository 2개 이상 조합 / 비즈니스 규칙 포함 / 여러 Feature 재사용.

## DI

- 모든 DI는 `app/di`에서 정의. 등록 순서: DataSource -> Repository -> UseCase.
- `keepAlive: true` Provider에서는 `ref.read` 사용. `ref.watch`는 화면 스코프에서만.
- domain 레이어는 Riverpod 참조 금지, 순수 Dart만.

## Navigation

- feature ViewModel은 GoRouter 직접 참조 금지 -> AppViewModel 편의 메서드만 사용.
- Navigation은 AppAction에 포함하지 않고 ViewModel 편의 메서드로 직접 처리.

## UI

- View는 `ConsumerWidget` 기본, 생명주기 필요 시에만 `ConsumerStatefulWidget`.
- View에서 비즈니스 로직 금지. `dispatch()`로만 Action 전달.
- `ref.watch`(빌드), `ref.listen`(부수효과), `ref.read`(이벤트 콜백).

## 저장소 선택

- SharedPreferences: 비민감 키-값 설정
- flutter_secure_storage: 토큰, 인증 등 민감 정보
- Drift: 구조화된 객체, SQL 쿼리, 조인, 대용량 데이터
- 저장소 접근은 반드시 DataSource를 통해서만.

## 테스트

- Reducer: 100% 필수. UseCase: 80%+ 필수. Repository: 70%+ 권장. ViewModel: 주요 흐름.
- domain 레이어는 순수 Dart 환경에서 테스트.
