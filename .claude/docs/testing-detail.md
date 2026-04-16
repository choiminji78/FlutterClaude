---
name: testing-detail
description: 레이어별 테스트 패턴 — Reducer, UseCase, DataSource, Repository, ViewModel의 Mockito 설정과 코드 템플릿
---

# Testing Detail

> 커버리지 목표: Reducer 100% | UseCase 80%+ | DataSource·Repository 70%+ | ViewModel 주요 흐름

## Mockito 공통 규칙

- Freezed sealed class를 반환하는 stub에는 `setUp` 최상단에서 `provideDummy<T>()` 등록 필수 (미등록 시 `MissingDummyValueError`)
- 동기 stub: `.thenReturn(...)` / 비동기 stub: `.thenAnswer((_) async => ...)`
- `@GenerateMocks([...])` 추가 후 `dart run build_runner build --delete-conflicting-outputs` 실행 → `*.mocks.dart` 생성 확인

---

## Reducer 테스트

순수 함수이므로 mock 불필요.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_claude/feature/[feature]/action/[feature]_action.dart';
import 'package:flutter_claude/feature/[feature]/reducer/[feature]_reducer.dart';
import 'package:flutter_claude/feature/[feature]/state/[feature]_state.dart';
import 'package:flutter_claude/domain/common/exception/app_exception.dart';

void main() {
  group('[feature]Reducer', () {
    test('[action]Started: isLoading true', () {
      final next = [feature]Reducer(
        const [Feature]State(),
        const [Feature]Action.[action]Started(),
      );
      expect(next.isLoading, isTrue);
      expect(next.error, isNull);
    });

    test('[action]Succeeded: isLoading false, 데이터 갱신', () {
      final next = [feature]Reducer(
        const [Feature]State(isLoading: true),
        [Feature]Action.[action]Succeeded([data]),
      );
      expect(next.isLoading, isFalse);
      expect(next.[field], [data]);
    });

    test('[action]Failed: error 설정', () {
      const error = AppException.unknown('err');
      final next = [feature]Reducer(
        const [Feature]State(isLoading: true),
        [Feature]Action.[action]Failed(error),
      );
      expect(next.isLoading, isFalse);
      expect(next.error, error);
    });
  });
}
```

---

## UseCase 테스트

### 유형 A — Repository 주입형

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_claude/domain/[domain]/usecase/[verb]_[domain]_usecase.dart';
import 'package:flutter_claude/domain/[domain]/repository/[domain]_repository.dart';
import 'package:flutter_claude/domain/common/entity/app_result.dart';
import '[verb]_[domain]_usecase_test.mocks.dart';

@GenerateMocks([[Domain]Repository])
void main() {
  late [Verb][Domain]UseCase useCase;
  late Mock[Domain]Repository mockRepository;

  setUp(() {
    mockRepository = Mock[Domain]Repository();
    useCase = [Verb][Domain]UseCase([domain]Repository: mockRepository);
  });

  group('[Verb][Domain]UseCase', () {
    test('성공 시 AppSuccess 반환', () async {
      when(mockRepository.[method](id: anyNamed('id')))
          .thenAnswer((_) async => AppResult.success([entity]));
      final result = await useCase(id: 'test-id');
      result.when(
        success: (data) => expect(data, [entity]),
        failure: (_) => fail('success 기대'),
      );
    });

    test('실패 시 AppFailure 반환', () async {
      when(mockRepository.[method](id: anyNamed('id')))
          .thenAnswer((_) async => AppResult.failure(AppException.unknown('msg')));
      final result = await useCase(id: 'test-id');
      expect(result, isA<AppFailure<[Domain]Entity>>());
    });
  });
}
```

### 유형 B — 순수 로직형

mock 불필요. `useCase = const [Verb][Domain]UseCase()`. 유효/무효 입력 케이스 작성.

---

## DataSource 테스트

### SharedPreferences DataSource

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_claude/core/storage/common/dto/storage_response.dart';
import 'package:flutter_claude/core/storage/common/exception/storage_exception.dart';
import 'package:flutter_claude/core/storage/preferences/preferences_service.dart';
import 'package:flutter_claude/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import '[domain]_local_data_source_test.mocks.dart';

@GenerateMocks([PreferencesService])
void main() {
  late [Domain]LocalDataSourceImpl dataSource;
  late MockPreferencesService mockPrefs;

  setUp(() {
    provideDummy<StorageResponse<String>>(const StorageResponse.success(''));
    provideDummy<StorageResponse<void>>(const StorageResponse.success(null));
    mockPrefs = MockPreferencesService();
    dataSource = [Domain]LocalDataSourceImpl(preferencesService: mockPrefs);
  });

  group('[Domain]LocalDataSource', () {
    test('get[Value] — 값 있을 때 success', () {
      when(mockPrefs.getString(any)).thenReturn('test-value');
      final result = dataSource.get[Value]();
      result.when(
        success: (v) => expect(v, 'test-value'),
        failure: (_) => fail('success 기대'),
      );
    });

    test('get[Value] — 값 없을 때 notFound', () {
      when(mockPrefs.getString(any)).thenReturn(null);
      expect(dataSource.get[Value](), isA<StorageFailure<String>>());
    });

    test('save[Value] — 성공', () async {
      when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
      expect(await dataSource.save[Value](value: 'v'), isA<StorageSuccess<void>>());
    });
  });
}
```

### SecureStorage DataSource

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_claude/core/storage/common/dto/storage_response.dart';
import 'package:flutter_claude/core/storage/common/exception/storage_exception.dart';
import 'package:flutter_claude/core/storage/secure_storage/secure_storage_service.dart';
import 'package:flutter_claude/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import '[domain]_local_data_source_test.mocks.dart';

@GenerateMocks([SecureStorageService])
void main() {
  late [Domain]LocalDataSourceImpl dataSource;
  late MockSecureStorageService mockSecure;

  setUp(() {
    provideDummy<StorageResponse<String>>(const StorageResponse.success(''));
    provideDummy<StorageResponse<void>>(const StorageResponse.success(null));
    mockSecure = MockSecureStorageService();
    dataSource = [Domain]LocalDataSourceImpl(secureStorageService: mockSecure);
  });

  group('[Domain]LocalDataSource', () {
    test('get[Value] — 값 있을 때 success', () async {
      when(mockSecure.read(key: anyNamed('key'))).thenAnswer((_) async => 'test-value');
      final result = await dataSource.get[Value]();
      result.when(
        success: (v) => expect(v, 'test-value'),
        failure: (_) => fail('success 기대'),
      );
    });

    test('get[Value] — 값 없을 때 notFound', () async {
      when(mockSecure.read(key: anyNamed('key'))).thenAnswer((_) async => null);
      expect(await dataSource.get[Value](), isA<StorageFailure<String>>());
    });

    test('save[Value] — 성공', () async {
      when(mockSecure.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((_) async {});
      expect(await dataSource.save[Value](value: 'v'), isA<StorageSuccess<void>>());
    });

    test('delete[Value] — 성공', () async {
      when(mockSecure.delete(key: anyNamed('key'))).thenAnswer((_) async {});
      expect(await dataSource.delete[Value](), isA<StorageSuccess<void>>());
    });
  });
}
```

### Drift DataSource — in-memory DB 사용 (mock 불필요)

```dart
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_claude/core/storage/common/dto/storage_response.dart';
import 'package:flutter_claude/core/storage/database/drift/drift_database_service.dart';
import 'package:flutter_claude/core/storage/database/drift/tables/[domain]_table.dart';
import 'package:flutter_claude/data/[domain]/datasource/local/[domain]_local_data_source.dart';

void main() {
  late DriftDatabaseService db;
  late [Domain]LocalDataSourceImpl dataSource;

  setUp(() {
    db = DriftDatabaseService(NativeDatabase.memory());
    dataSource = [Domain]LocalDataSourceImpl(db: db);
  });

  tearDown(() async => db.close());

  group('[Domain]LocalDataSource', () {
    test('save + get[Domain] — 성공', () async {
      final data = [Domain]TableData(id: 1 /*, 필드 */);
      expect(await dataSource.save[Domain](data: data), isA<StorageSuccess<void>>());
      (await dataSource.get[Domain](id: 1)).when(
        success: (d) => expect(d.id, 1),
        failure: (_) => fail('success 기대'),
      );
    });

    test('get[Domain] — 없는 id → notFound', () async {
      expect(
        await dataSource.get[Domain](id: 999),
        isA<StorageFailure<[Domain]TableData>>(),
      );
    });
  });
}
```

---

## Repository 테스트

DataSource를 mock. 패턴은 UseCase 테스트와 동일 구조.

- **Remote**: `@GenerateMocks([[Domain]RemoteDataSource])` — `ApiResponse.success/failure(NetworkException...)` stub
- **Local (Prefs/Secure)**: `@GenerateMocks([[Domain]LocalDataSource])` — `StorageResponse.success/failure` stub + `provideDummy` 필수
- **Local (Drift)**: `provideDummy<StorageResponse<[Domain]TableData>>` + `provideDummy<StorageResponse<void>>` 등록

---

## ViewModel 테스트

성공·실패 흐름은 `ProviderContainer`에 UseCase를 오버라이드하고 `notifier.dispatch()`로 검증한다.  
guard flag 검증은 **별도 그룹**에서 Effect를 직접 생성해 테스트한다 (아래 섹션 참조).

```dart
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_claude/app/di/[domain]_di.dart';
import 'package:flutter_claude/domain/[domain]/usecase/[verb]_[domain]_usecase.dart';
import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:flutter_claude/feature/[feature]/action/[feature]_action.dart';
import 'package:flutter_claude/feature/[feature]/effect/[feature]_effect.dart';
import 'package:flutter_claude/feature/[feature]/viewmodel/[feature]_view_model.dart';

// guard flag 테스트용: ProviderContainer에서 Ref를 꺼내기 위한 전용 Provider.
// AutoDispose가 아니므로 container 소멸 전까지 ref가 유효하다.
final _testRefProvider = Provider<Ref>((ref) => ref);

// ── Fake UseCase ──────────────────────────────────────────────────────────────

class _Fake[Verb][Domain]UseCase extends Fake implements [Verb][Domain]UseCase {
  final AppResult<[ReturnType]> _result;
  int callCount = 0;

  _Fake[Verb][Domain]UseCase(this._result);

  @override
  Future<AppResult<[ReturnType]>> call(/* params */) async {
    callCount++;
    return _result;
  }
}

/// guard flag 검증용: Completer가 완료될 때까지 블로킹된다.
class _Blocking[Verb][Domain]UseCase extends Fake implements [Verb][Domain]UseCase {
  final Completer<AppResult<[ReturnType]>> _completer;
  int callCount = 0;

  _Blocking[Verb][Domain]UseCase(this._completer);

  @override
  Future<AppResult<[ReturnType]>> call(/* params */) {
    callCount++;
    return _completer.future;
  }
}

// ── 공통 픽스처 ───────────────────────────────────────────────────────────────

ProviderContainer _makeContainer({
  required [Verb][Domain]UseCase useCase,
}) {
  return ProviderContainer(
    overrides: [
      [verb][Domain]UseCaseProvider.overrideWith((_) async => useCase),
    ],
  );
}

void main() {
  // ── [Feature]ViewModel 통합 테스트 ──────────────────────────────────────────
  // dispatch → reduce → effect → reduce 전체 흐름을 검증한다.
  group('[Feature]ViewModel', () {
    test('성공 흐름 — isLoading true → false, [field] 갱신', () async {
      final container = _makeContainer(
        useCase: _Fake[Verb][Domain]UseCase(AppResult.success([data])),
      );
      addTearDown(container.dispose);

      final states = <[Feature]State>[];
      container.listen(
        [feature]ViewModelProvider,
        (_, s) => states.add(s),
        fireImmediately: true,
      );

      container
          .read([feature]ViewModelProvider.notifier)
          .dispatch(const [Feature]Action.[action]Started());

      await pumpEventQueue();

      // [0] 초기, [1] isLoading=true(Started), [2] isLoading=false(Succeeded)
      expect(states, hasLength(3));
      expect(states[1].isLoading, true);
      expect(states[2].isLoading, false);
      expect(states[2].[field], [data]);
    });

    test('실패 흐름 — isLoading false, error 설정', () async {
      final container = _makeContainer(
        useCase: _Fake[Verb][Domain]UseCase(
          AppResult.failure(const AppException.unknown('err')),
        ),
      );
      addTearDown(container.dispose);

      final states = <[Feature]State>[];
      container.listen(
        [feature]ViewModelProvider,
        (_, s) => states.add(s),
        fireImmediately: true,
      );

      container
          .read([feature]ViewModelProvider.notifier)
          .dispatch(const [Feature]Action.[action]Started());

      await pumpEventQueue();

      // [0] 초기, [1] isLoading=true(Started), [2] isLoading=false+error(Failed)
      expect(states, hasLength(3));
      expect(states[2].isLoading, false);
      expect(states[2].error, isNotNull);
    });
  });

  // ── [Feature]Effect guard flag 테스트 ────────────────────────────────────────
  // BaseViewModel 큐는 Effect를 순차 처리(await)하므로 큐를 통한 중복 실행은
  // 발생하지 않는다. guard flag의 실제 역할(동시 진입 차단)을 검증하려면
  // Effect를 직접 생성해 handleEffect를 await 없이 연속 호출해야 한다.
  group('[Feature]Effect guard flag', () {
    test('[action] 실행 중 동일 action 재진입 시 UseCase 호출이 차단된다', () async {
      final completer = Completer<AppResult<[ReturnType]>>();
      final blockingUseCase = _Blocking[Verb][Domain]UseCase(completer);

      final container = ProviderContainer(
        overrides: [
          [verb][Domain]UseCaseProvider.overrideWith((_) async => blockingUseCase),
        ],
      );
      addTearDown(container.dispose);

      // _testRefProvider를 통해 container의 Ref를 획득한다.
      final effectRef = container.read(_testRefProvider);
      final dispatched = <[Feature]Action>[];
      final effect = [Feature]Effect(effectRef, dispatched.add);

      const action = [Feature]Action.[action]Started(/* params */);

      // await 없이 연속 호출 → f1이 첫 번째 await에서 yield되는 사이
      // f2가 guard를 만나 즉시 반환된다.
      final f1 = effect.handleEffect(action);
      final f2 = effect.handleEffect(action);

      completer.complete(AppResult.success([data]));
      await Future.wait([f1, f2]);

      expect(blockingUseCase.callCount, 1, reason: 'guard flag로 두 번째 호출 차단');
      expect(dispatched, hasLength(1));
      expect(dispatched.first, isA<[ActionSucceeded]>());
    });
  });
}
```

> `pumpEventQueue()`: `Future.delayed(Duration.zero)` 대신 사용. 마이크로태스크·이벤트 큐를 모두 소진한다.
> async provider override: `keepAlive: true` + `Future<UseCase>`인 경우 `.overrideWith((_) async => useCase)` 사용.
> `_testRefProvider`: `AutoDispose`가 아닌 `Provider<Ref>`로 선언해야 container 소멸 전까지 ref가 유효하다.
