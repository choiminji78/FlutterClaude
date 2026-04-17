# Architecture Detail

## 래퍼 모델 규칙

### ApiResponse\<T\>
- `core/network/http/dto`에 정의한다.
- `core/network/http/service`에서만 반환한다.
- `ApiSuccess<T>`, `ApiFailure<T>` 두 가지 상태만 가진다.

### StorageResponse\<T\>
- `core/storage/common/dto`에 정의한다.
- `core/storage/service`에서만 반환한다.
- `StorageSuccess<T>`, `StorageFailure<T>` 두 가지 상태만 가진다.

### AppResult\<T\>
- `domain/common/entity`에 정의한다.
- ViewModel이 소비하는 모델이다.
- `AppSuccess<T>`, `AppFailure<T>` 두 가지 상태만 가진다.
- 로딩 상태는 `AppResult`로 표현하지 않으며, State의 `isLoading` 필드로 관리한다.

### 분리 이유
세 래퍼는 구조가 유사하지만 분리를 유지한다.
- 예외 타입이 다르다. (`NetworkException` / `StorageException` / `AppException`)
- 존재하는 레이어가 다르다.
- 변환 책임의 경계를 명확히 하기 위함이다.

### 변환 책임
- **Repository는 항상 `AppResult<Entity>`를 반환한다.**
- `ApiResponse -> AppResult`, `StorageResponse -> AppResult` 변환은 모두 Repository 구현체가 담당한다.
- UseCase가 있는 경우(경로 A): UseCase는 Repository의 `AppResult<Entity>`를 받아 조합/가공만 한다. 추가 변환 책임은 없다.
- UseCase가 없는 경우(경로 B): Repository가 `AppResult<Entity>`를 Effect에 직접 반환한다.

---

## 에러 처리

### 전파 방향 (단방향)

```
[네트워크 오류]
API 오류 -> NetworkException -> ApiFailure -> Repository(ExceptionMapper) -> AppException -> AppFailure -> ViewModel -> UI

[스토리지 오류]
Storage 오류 -> StorageException -> StorageFailure -> Repository(StorageExceptionMapper) -> AppException -> AppFailure -> ViewModel -> UI
```

- `NetworkException`은 `core/network/exception`에서 발생하며 (http/ws 공통), Service 레이어에서 `ApiFailure`로 감싼다.
- `StorageException`은 `core/storage/exception`에서 발생하며, Service 레이어에서 `StorageFailure`로 감싼다.
- `ApiFailure -> AppFailure` 변환 시 `ExceptionMapper`를 통해 `NetworkException -> AppException`으로 변환한다.
- `StorageFailure -> AppFailure` 변환 시 `StorageExceptionMapper`를 통해 `StorageException -> AppException`으로 변환한다.
- **변환 책임은 항상 Repository 구현체가 담당한다.** UseCase는 `AppFailure`만 전달받으며 변환에 관여하지 않는다.
- ViewModel은 `AppFailure`만 수신하며, `NetworkException` / `StorageException`을 직접 참조하지 않는다.

### 예외 위치

| 타입 | 위치 | 설명 |
|---|---|---|
| `NetworkException` | `core/network/exception` | 네트워크 기술 예외 (http/ws 공통) |
| `StorageException` | `core/storage/common/exception` | 스토리지 기술 예외 |
| `AppException` | `domain/common/exception` | 비즈니스 예외 |
| `ExceptionMapper` | `data/common/mapper` | `NetworkException -> AppException` 변환 |
| `StorageExceptionMapper` | `data/common/mapper` | `StorageException -> AppException` 변환 |

---

## DataSource 조합 기준

- remote DataSource는 API 호출만 전담한다.
- local DataSource는 명시적 저장 Action이 있을 때만 호출한다.
- DataSource 반환 타입:
  - remote DataSource -> `ApiResponse<DTO>`
  - local DataSource -> `StorageResponse<PersistenceModel>`
- Repository는 별도의 캐시 전략을 두지 않으며 기본적으로 **Remote First**를 따른다.
  - remote 호출 -> 반환
  - local 저장은 명시적 Action이 있을 때만 수행

---

## Effect 경로

| 경로 | 구성 | 사용 조건 |
|---|---|---|
| 경로 A | `Effect -> UseCase -> Repository` | UseCase가 있는 경우 |
| 경로 B | `Effect -> Repository (직접)` | 단순 CRUD, 아래 조건 전부 충족 시 |

**경로 B 허용 조건** (두 가지 모두 만족해야 한다):
1. Repository 1개만 사용
2. 비즈니스 로직 없음 -- 서버 응답 가공 없음, 조건 분기 없음

**경로 B 허용/금지 예시**:

| 구분 | 예시 |
|---|---|
| 허용 | 단순 캐시 무효화, 로컬 설정값 읽기/쓰기, 단순 목록 조회(필터/가공 없음) |
| 금지 | 서버 응답 필드를 가공하거나 조건 분기가 1개라도 있는 경우, 두 개 이상의 Repository를 참조하는 경우 |

> 조건을 충족하더라도 추후 재사용이 필요해지면 UseCase로 추출한다.

**UseCase를 만드는 기준**:
- 두 개 이상의 Repository를 조합할 때
- 비즈니스 규칙/유효성 검사가 포함될 때
- 여러 Feature에서 재사용될 때

---

## DI 규칙

- 모든 DI는 `app/di`에서 정의한다. (DataSource, Repository, UseCase, 인프라 서비스 전부)
- 도메인 단위 파일은 `[domain]_di.dart` 네이밍을 따른다.
- `storage_di.dart` -- 스토리지 인프라 서비스 Provider (`DriftDatabaseService`, `PreferencesService`, `SecureStorageService`)
- `network_di.dart` -- 네트워크 인프라 서비스 Provider (`ApiService`)
- `di.dart`는 모든 DI 파일을 export하는 진입점이다.
- domain 레이어는 Riverpod를 참조하지 않으며 순수 Dart 클래스만 허용한다.
- DI 등록 순서: DataSource -> Repository -> UseCase
- **DI Provider에서 `ref.read` vs `ref.watch`:** `keepAlive: true` Provider는 생성 시 1회만 실행되며 이후 재실행되지 않는다. 의존 Provider가 바뀌어도 재생성이 불필요하므로 `ref.read`를 사용한다. `ref.watch`는 상태 변화를 구독해 재빌드가 필요한 경우(즉, `@riverpod` 화면 스코프)에만 사용한다.

---

## Navigation 규칙

- `NavigationService` 추상 인터페이스는 `core/navigation`에 정의한다.
- `GoRouterNavigationService` 구현체는 `app/router`에 위치한다.
- `feature` ViewModel은 GoRouter를 직접 참조하지 않고 AppViewModel 편의 메서드만 사용한다.
- Navigation은 상태 변경이 없으므로 AppAction에 포함하지 않고 ViewModel 편의 메서드로 직접 처리한다.
- GoRouter 인스턴스는 1회만 생성되며 `ref.onDispose(router.dispose)`로 생명주기를 관리한다.
- GoRouter Provider는 `@Riverpod(keepAlive: true)`로 선언한다.
- NavigationService 주입은 `app.dart`에서 GoRouter 생성 후 처리한다. (순환 의존 방지)

### AppNavigationEffect

- `app/effect/app_navigation_effect.dart`에 위치하며, AppViewModel이 소유한다.
- NavigationService를 통해 push, pop, replace 등 라우팅 작업을 수행한다.
- feature ViewModel은 AppViewModel의 편의 메서드(예: `navigateTo`, `goBack`)를 호출하며, AppNavigationEffect를 직접 참조하지 않는다.

---

## Feature UI 레이어 규칙

- View는 `ConsumerWidget` 또는 `ConsumerStatefulWidget`을 사용한다.
- `ConsumerStatefulWidget`은 `initState`, `dispose`, `AnimationController` 등 위젯 생명주기가 필요한 경우에만 사용한다. 그 외에는 `ConsumerWidget`을 사용한다.
- View는 ViewModel의 `dispatch()`를 통해서만 Action을 전달한다. 직접 상태를 변경하지 않는다.
- View는 State를 구독하는 것 외에 비즈니스 로직을 포함하지 않는다.

### ref 사용 기준

| 메서드 | 사용 시점 |
|---|---|
| `ref.watch` | State 변화에 따라 UI를 리빌드해야 할 때 (build 메서드 내) |
| `ref.listen` | State 변화에 따라 부수 효과(다이얼로그, 스낵바 등)를 실행해야 할 때 (build 메서드 내) |
| `ref.read` | 이벤트 콜백에서 dispatch를 호출할 때 (빌드 외부) |

---

## 로컬 저장소 선택 기준

| 저장소 | 사용 조건 |
|---|---|
| `SharedPreferences` | 단순 키-값 설정값 -- 로케일, 테마, 온보딩 완료 여부 등 비민감 데이터 |
| `flutter_secure_storage` | 민감 정보 -- 토큰, 인증 정보 등 플랫폼 보안 저장소에 자동 암호화 저장 |
| `Drift` | 구조화된 객체 목록, SQL 쿼리, 조인, 인덱싱, 대용량 로컬 데이터 |

- 로컬 저장소 접근은 반드시 DataSource를 통해서만 수행한다. ViewModel이나 UseCase에서 직접 참조하지 않는다.
- 하나의 도메인에서 여러 저장소를 혼용할 경우 local DataSource에서 통합한다.

---

## 전체 데이터 흐름

```
[정상 흐름]
UI -> dispatch(Action) -> 큐(FIFO) -> Reducer(동기) -> Effect(비동기 독립 실행) -> UseCase -> Repository -> DataSource -> Service -> API
API -> DTO -> ApiResponse<DTO> -> Repository(ExceptionMapper/Mapper) -> AppResult<Entity> -> dispatch(Action) -> 큐

[네트워크 에러 흐름]
API 오류 -> NetworkException -> ApiFailure -> Repository(ExceptionMapper) -> AppException -> AppFailure -> Effect -> dispatch(Action) -> 큐 -> Reducer -> State -> UI

[스토리지 에러 흐름]
Storage 오류 -> StorageException -> StorageFailure -> Repository(StorageExceptionMapper) -> AppException -> AppFailure -> Effect -> dispatch(Action) -> 큐 -> Reducer -> State -> UI

[Navigation 흐름]
UI -> ViewModel 편의 메서드 -> AppNavigationEffect -> NavigationService -> GoRouter
```

---

## 테스트 전략

| 레이어 | 테스트 방식 | 커버리지 |
|---|---|---|
| Reducer | 순수 함수, 외부 의존성 없음, mock 불필요 | 100% (필수) |
| UseCase | Repository mock으로 단위 테스트, 비즈니스 규칙/유효성 검사 집중 | 80% 이상 (필수) |
| Repository | DataSource mock으로 단위 테스트, ApiResponse/StorageResponse -> AppResult 변환 및 Mapper 검증 포함 | 70% 이상 (권장) |
| ViewModel | Effect mock으로 통합 테스트, Action -> State 변화 흐름 검증 | 주요 흐름 위주 (권장) |

- Reducer는 모든 Action 케이스에 대한 테스트를 작성한다.
- domain 레이어는 Riverpod를 참조하지 않으므로 순수 Dart 환경에서 테스트한다.
