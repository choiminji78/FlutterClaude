# Self-Review Checklist

10년차 시니어 관점 체크리스트. 레이어별로 분류하고 심각도를 태그로 표시한다.
`🔴 C` = Critical / `🟡 M` = Major / `🟢 m` = Minor

체크 방향: **위반이면 체크 (✅ = 문제 있음)**

---

## 모든 레이어 공통

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🔴 C` | import 경로가 레이어 역방향 의존을 위반한다 | `feature`에서 다른 `feature` import |
| `🔴 C` | 민감 정보(토큰, API 키, 비밀번호)가 하드코딩되어 있다 | `const apiKey = "sk-..."` |
| `🔴 C` | 민감 정보가 로그에 출력된다 | `AppLogger.d(token)` |
| `🟢 m` | 파일명이 `snake_case` 또는 `[대상]_[역할].dart` 패턴을 따르지 않는다 | `UserRepo.dart` |
| `🟢 m` | 클래스명이 `PascalCase` 또는 역할별 네이밍 패턴을 따르지 않는다 | `userRepository` |
| `🟢 m` | 사용하지 않는 import가 있다 | IDE analyzer 경고 확인 |
| `🟢 m` | 사용하지 않는 변수·파라미터가 있다 | |

---

## feature / app 레이어

### Reducer

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🔴 C` | Reducer가 `async`/`await`를 포함한다 | `fetchStarted: () async => ...` |
| `🔴 C` | Reducer에서 사이드 이펙트(`DateTime.now()`, `Uuid()`)를 생성한다 | `copyWith(id: Uuid().v4())` |
| `🔴 C` | `maybeWhen()`을 사용한다 | `action.maybeWhen(orElse: ...)` |
| `🔴 C` | sealed class를 `when()` 대신 `is` 분기로 처리한다 | `if (action is FetchStarted) { ... }` — exhaustive 보장 불가 |
| `🟡 M` | 비동기 Action에 Started·Succeeded·Failed 케이스 중 누락이 있다 | `fetchSucceeded`, `fetchFailed`만 있고 `fetchStarted` 없음 |

```dart
// ❌ Reducer 위반 — 비동기·사이드 이펙트 포함
FeatureState featureReducer(FeatureState state, FeatureAction action) {
  return action.when(
    createStarted: () async {                      // ❌ async 금지
      final id = Uuid().v4();                      // ❌ 사이드 이펙트 금지
      return state.copyWith(isLoading: true, id: id);
    },
    ...
  );
}

// ✅ 올바른 방식 — Effect에서 생성 후 Action 페이로드로 전달
// Effect:
final id = Uuid().v4();
dispatch(FeatureAction.createStarted(id: id));

// Reducer:
createStarted: (id) => state.copyWith(isLoading: true, id: id),
```

### Effect

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🔴 C` | Effect가 `state`를 직접 변경한다 | `state = state.copyWith(isLoading: true)` |
| `🔴 C` | `AppResult`의 failure 케이스를 무시한다 | `failure: (_) => null` without dispatch |
| `🔴 C` | 비동기 메서드에 guard flag가 없다 | `_isFetching` 없이 API 호출 |
| `🟡 M` | `handleEffect`에서 관심 없는 Action 케이스에 `null`을 반환하지 않는다 | |

```dart
// ❌ Effect 위반 — state 직접 변경 + failure 무시 + guard 없음
Future<void> _fetch() async {
  state = state.copyWith(isLoading: true);          // ❌ 직접 변경
  final result = await ref.read(useCaseProvider)();
  result.when(
    success: (data) => dispatch(Action.fetchSucceeded(data)),
    failure: (_) => null,                           // ❌ failure 무시
  );
}

// ✅ 올바른 방식
bool _isFetching = false;

Future<void> _fetch() async {
  if (_isFetching) return;                          // ✅ guard
  _isFetching = true;
  try {
    final result = await ref.read(useCaseProvider)();
    result.when(
      success: (data) => dispatch(Action.fetchSucceeded(data)),
      failure: (e)    => dispatch(Action.fetchFailed(e)),   // ✅ failure도 dispatch
    );
  } finally {
    _isFetching = false;
  }
}
```

### ViewModel

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🔴 C` | `dispatch()` 없이 `state = ...`로 직접 상태를 변경한다 | ViewModel에서 `state = state.copyWith(...)` |
| `🟡 M` | ViewModel이 `BaseViewModel<S, A>`를 `implements`하지 않는다 | |
| `🟡 M` | AppViewModel이 `BaseKeepAliveViewModel<S, A>`를 `implements`하지 않는다 | |
| `🟡 M` | Effect를 별도 Provider로 등록했다 | `@riverpod FeatureEffect featureEffect(...)` |
| `🟡 M` | Feature ViewModel이 GoRouter를 직접 참조한다 | `context.go(...)` 또는 `GoRouter.of(...)` |

### Riverpod (View 포함)

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🔴 C` | `build()` 밖에서 `ref.watch`를 사용한다 | 이벤트 콜백 `onPressed: () { ref.watch(p) }`, 비동기 블록 안 등 |
| `🟡 M` | `keepAlive: true` Provider(DI 포함)에서 `ref.watch`를 사용한다 | `ref.watch(userRepositoryProvider)` — `ref.read` 사용해야 함 |
| `🟡 M` | `app/di` 하위 Provider가 AutoDispose로 선언됐다 | `@riverpod` (keepAlive 누락) |
| `🟡 M` | Feature ViewModel이 `@Riverpod(keepAlive: true)`로 선언됐다 | 화면마다 새 인스턴스 생성이 안 됨 |
| `🟡 M` | `ConsumerStatefulWidget`을 사용하는데 생명주기 필요성이 불분명하다 | `initState`·`dispose`·`AnimationController` 없음 |

### State

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🟡 M` | State에 로딩 케이스가 없고 `isLoading` 필드도 없다 | `AppResult`로 로딩을 표현 |
| `🟡 M` | State가 `sealed class`로 정의됐다 | State는 `data class`여야 함 |
| `🟢 m` | `@Default` 없이 초기값을 `build()` 시점에 지정한다 | |

### 리소스

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🔴 C` | StreamController가 `ref.onDispose` 또는 `dispose()`에서 닫히지 않는다 | |
| `🔴 C` | AnimationController·Timer·Subscription이 dispose되지 않는다 | |
| `🔴 C` | 비동기 콜백에서 dispose 이후 상태를 변경하려 한다 | `_actionQueue.isClosed` 체크 없음 |

---

## data 레이어

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🔴 C` | Repository가 `AppResult<Entity>` 외의 타입을 반환한다 | `Future<UserDto>` 반환 |
| `🔴 C` | `NetworkException → AppException` 변환을 Repository 외부에서 한다 | UseCase에서 `ExceptionMapper` 호출 |
| `🔴 C` | `StorageException → AppException` 변환을 Repository 외부에서 한다 | |
| `🟡 M` | Mapper 호출이 Repository 외부(UseCase, ViewModel 등)에서 발생한다 | |
| `🟡 M` | remote DataSource가 `ApiResponse<DTO>` 외의 타입을 반환한다 | `Future<UserEntity>` 반환 |
| `🟡 M` | local DataSource가 `StorageResponse<PersistenceModel>` 외의 타입을 반환한다 | |
| `🟡 M` | Repository가 기본 캐시 전략(Remote First) 외에 복잡한 캐시 로직을 포함한다 | 명시적 Action 없이 자동 저장 |
| `🟢 m` | DataSource가 여러 저장소를 혼용하는데 local DataSource에서 통합하지 않았다 | |

```dart
// ❌ Repository 위반 — ExceptionMapper 미사용, Entity 대신 DTO 반환
Future<UserDto> getUser(String id) async {  // ❌ 반환 타입
  final response = await _remoteDataSource.getUser(id);
  return response.when(
    success: (dto) => dto,                  // ❌ Mapper 미사용
    failure: (e) => throw e.exception,     // ❌ AppException 미변환
  );
}

// ✅ 올바른 방식
Future<AppResult<UserEntity>> getUser(String id) async {
  final response = await _remoteDataSource.getUser(id);
  return response.when(
    success: (dto) => AppSuccess(UserMapper.toEntity(dto)),
    failure: (e)   => AppFailure(ExceptionMapper.toAppException(e.exception)),
  );
}
```

---

## domain 레이어

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🔴 C` | domain 레이어 파일에 Riverpod import가 있다 | `import 'package:riverpod_annotation/...` |
| `🔴 C` | domain 레이어 파일에 Flutter import가 있다 | `import 'package:flutter/...` |
| `🟡 M` | UseCase가 `ApiResponse`·`StorageResponse`를 직접 처리한다 | Repository가 `AppResult`로 변환 안 함 |
| `🟡 M` | UseCase가 경로 B 조건(Repository 1개·비즈니스 로직 없음)을 충족하지 않는데 UseCase가 없다 | |
| `🟡 M` | 두 개 이상의 Repository를 조합하는 로직이 Repository 구현체에 있다 | UseCase로 이동 필요 |

```dart
// ❌ domain 위반 — Riverpod 참조
import 'package:riverpod_annotation/riverpod_annotation.dart'; // ❌

class GetUserUseCase {
  @riverpod  // ❌ domain은 순수 Dart만 허용
  GetUserUseCase ...
}
```

---

## app/di 레이어

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🟡 M` | DI 등록 순서가 DataSource → Repository → UseCase가 아니다 | UseCase를 먼저 등록 |
| `🟡 M` | 모든 Provider가 `@Riverpod(keepAlive: true)`가 아니다 | `@riverpod` (AutoDispose) |
| `🟡 M` | 신규 `[domain]_di.dart`가 `di.dart`에 export되지 않았다 | |
| `🟡 M` | DI 등록 위치가 `app/di` 외부에 있다 | feature 내부에 Provider 정의 |

---

## core 레이어

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🔴 C` | `core`가 상위 레이어(`feature`, `data`, `app`, `domain`)를 참조한다 | |
| `🔴 C` | Storage Service가 Entity를 반환한다 | Persistence Model만 허용 |
| `🟡 M` | `ApiService`가 `NetworkException` 외의 예외를 그대로 던진다 | |

---

## 버그·로직 (레이어 무관)

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🔴 C` | `!` 연산자를 null 체크 없이 사용한다 | `user!.name` (user가 null일 수 있음) |
| `🔴 C` | 조건 분기가 모든 케이스를 처리하지 않는다 | else 누락, 잘못된 경계값 |
| `🔴 C` | `isLoading`이 실패 경로에서 `false`로 복원되지 않는다 | failure Action에서 `copyWith(isLoading: true)` 유지 |
| `🔴 C` | `try/catch`에서 예외를 소비하고 상위로 전파하지 않는다 | `catch (_) {}` |
| `🔴 C` | 순환 참조·무한 루프 가능성이 있다 | |
| `🟡 M` | 빈 목록 상태를 UI에서 처리하지 않는다 | `ListView` 빌드 시 빈 화면 |
| `🟡 M` | 동시 요청(빠른 이중 탭) 상황에서 상태 불일치가 발생할 수 있다 | |

---

## 코드 품질 (레이어 무관)

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🟡 M` | 메서드가 50줄을 초과한다 (역할별 분리 검토) | |
| `🟡 M` | 조건 분기 깊이가 3단계를 초과한다 | early return으로 단순화 가능 |
| `🟡 M` | 한 메서드가 두 가지 이상의 역할을 수행한다 | |
| `🟢 m` | 매직 넘버·매직 문자열이 상수로 추출되지 않았다 | `Duration(milliseconds: 300)` → `const _kAnimDuration` |
| `🟢 m` | 동일 로직이 2회 이상 중복된다 (3줄 미만 단순 반복 제외) | |
| `🟢 m` | `async` 함수에서 실제 `await`가 없다 | `async` 제거 가능 |
| `🟢 m` | 한 곳에서만 쓰이는 불필요한 추상화·인터페이스가 있다 | |
| `🟢 m` | 현재 요구사항에 없는 확장성 코드가 있다 (YAGNI) | |

---

## 테스트 파일

| 심각도 | 체크 항목 | 위반 예시 |
|---|---|---|
| `🟡 M` | Reducer 테스트 파일이 존재하지 않는다 | |
| `🟡 M` | Reducer 테스트가 모든 Action 케이스를 커버하지 않는다 | 일부 케이스 누락 |
| `🟡 M` | UseCase 테스트 파일이 존재하지 않는다 | |
| `🟢 m` | Repository 구현체 테스트 파일이 존재하지 않는다 | 70%+ 커버리지 권장 |
| `🟡 M` | domain 레이어 테스트에서 Riverpod를 참조한다 | |
| `🟡 M` | 테스트가 실제 구현이 아닌 mock의 호출 여부만 검증한다 | `verify(mock.method()).called(1)` 만 있음 |
| `🟢 m` | 테스트 파일 위치가 `test/` 하위 `lib/`와 동일한 구조를 따르지 않는다 | |
| `🟢 m` | 테스트 파일명이 `[원본파일명]_test.dart` 패턴이 아니다 | |

---

## ❓ 의문 사항 판단 기준

다음 경우에는 Critical/Major를 부여하지 않고 의문 사항으로 분리한다.

- 코드를 읽어도 의도가 명확하지 않은 경우
- 버그처럼 보이지만 의도적인 예외 처리일 수 있는 경우
- 아키텍처 위반처럼 보이지만 임시 조치일 수 있는 경우
- 비즈니스 규칙 없이는 정상/비정상 판단이 불가능한 경우

출력 형식:

```
- [`파일경로:줄번호`](링크) [구체적인 부분]의 의도가 불명확합니다.
  [의도A]라면 정상이지만, [의도B]라면 [문제]가 발생할 수 있습니다.
  의도가 어느 쪽인지 확인이 필요합니다.
```
