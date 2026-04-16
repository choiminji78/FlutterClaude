---
name: add-storage-preferences
description: This skill should be used when the user asks to "preferences 저장소 추가", "SharedPreferences 도메인 추가", "키-값 저장소 생성", "설정값 저장 추가", "preferences 필드 추가", "저장 필드 추가", "add-storage-preferences", or requests creation or extension of a SharedPreferences-based storage for a domain.
argument-hint: "[domain] ([field]:[type])?"
---

# Add Preferences Storage

SharedPreferences 기반 키-값 저장 필드를 도메인 단위로 생성하거나 기존 도메인에 추가한다.

> 아키텍처·에러 전파·DI 규칙 → `.claude/docs/architecture-detail.md`
> 파일명·클래스명 패턴 → `.claude/docs/naming-detail.md`
> 디렉토리 구조 → `.claude/docs/directory-structure.md`

---

## 핵심 원칙

1. **단방향 의존** — `DataSource → Repository → ViewModel` 경로만 허용. ViewModel·UseCase에서 `PreferencesService` 직접 참조 금지.
2. **변환 책임** — `StorageResponse → AppResult` 변환은 Repository 구현체에서만 수행. DataSource는 `StorageResponse<T>`를 그대로 반환.
3. **계획 우선** — 파일 생성·수정 전 반드시 계획을 제시하고 사용자 승인을 받는다.
4. **추측 금지** — 도메인명·필드명·타입이 불명확하면 구현하지 않고 확인한다.

---

## 단계 0: 기반 파일 사전 확인

Glob으로 아래 파일의 존재 여부를 확인한다.

```
lib/core/storage/common/dto/storage_response.dart
lib/core/storage/common/exception/storage_exception.dart
lib/domain/common/entity/app_result.dart
lib/domain/common/exception/app_exception.dart
```

| 파일 | 없을 때 대응 |
|---|---|
| `storage_response.dart` / `storage_exception.dart` | "StorageResponse/StorageException이 없습니다. `/init-project`로 프로젝트 기반 구조를 먼저 생성해 주세요." 안내 후 중단 |
| `app_result.dart` / `app_exception.dart` | "AppResult/AppException이 없습니다. `/init-project`로 프로젝트 기반 구조를 먼저 생성해 주세요." 안내 후 중단 |

모두 존재하면 다음으로 이동.

---

## pubspec.yaml 확인

스킬 실행 전 `pubspec.yaml`을 **Read** 로 읽어 두 가지를 확인한다.

1. `name:` 필드 → 이후 모든 import 경로에 사용 (`package:[name]/`)
2. `shared_preferences:` 의존성 → 없으면 추가 후 `flutter pub get` 실행

```yaml
dependencies:
  shared_preferences: ^2.3.4
```

> SharedPreferences는 코드 생성 불필요. DI `.g.dart`만 재생성하면 된다.
> 이하 모든 import 경로에서 `[pkg]`는 `pubspec.yaml`의 `name:` 값이다 (예: `flutter_claude`).

---

## 단계 1: 인수 확인

`$ARGUMENTS`에서 도메인명과 필드 정보를 파악한다.

| `$ARGUMENTS` 형태 | 처리 |
|---|---|
| 없음 | 도메인명·필드명·타입을 사용자에게 질문 |
| `[domain]` | 도메인 확인됨. 단계 2로 이동 후 필드명·타입 추가 질문 |
| `[domain] [field]:[type]` | 모두 확인됨 |

**지원 타입:** `String`, `bool`, `int`, `double`

---

## 단계 2: 기존 파일 탐색 → 흐름 분기

아래 파일 존재 여부를 Glob으로 확인한다.

```
lib/data/[domain]/datasource/local/[domain]_local_data_source.dart
lib/domain/[domain]/repository/[domain]_repository.dart
lib/data/common/mapper/storage_exception_mapper.dart
lib/core/storage/preferences/preferences_service.dart
lib/app/di/storage_di.dart
lib/app/di/[domain]_di.dart
```

결과에 따라 흐름을 결정한다.

| 로컬 DataSource | PreferencesService import | 흐름 |
|---|---|---|
| 없음 | — | **신규** → 단계 3A |
| 있음 | 있음 | **필드 추가** → 단계 3B |
| 있음 | 없음 | **통합 추가** → 단계 3C |

파일이 있으면 반드시 **Read** 해 내용을 파악한 후 다음 단계로 진행한다.

**추가 확인:**
- `preferences_service.dart`가 있으면 **Read** 해 실제 메서드 시그니처를 확인한다. 이후 모든 코드에서 그 패턴을 따른다.
- `storage_exception_mapper.dart`가 없으면 단계 5에서 함께 생성한다.
- `[domain]_repository.dart`가 있으면 **Read** 해 기존 시그니처 패턴을 파악한다.

---

## 단계 3A: 신규 — 생성 계획

| # | 파일 경로 | 역할 |
|---|---|---|
| 1 | `lib/core/storage/preferences/preferences_service.dart` | PreferencesService (이미 있으면 생략) |
| 2 | `lib/data/common/mapper/storage_exception_mapper.dart` | 공통 StorageExceptionMapper (이미 있으면 생략) |
| 3 | `lib/domain/[domain]/repository/[domain]_repository.dart` | Repository 인터페이스 (없으면 생성, 있으면 시그니처 추가) |
| 4 | `lib/data/[domain]/datasource/local/[domain]_local_data_source.dart` | LocalDataSource |
| 5 | `lib/data/[domain]/repository/[domain]_repository_impl.dart` | RepositoryImpl (없으면 생성, 있으면 구현 추가) |
| 6 | `lib/app/di/storage_di.dart` | preferencesServiceProvider 등록 (없으면 생성, 있으면 provider 추가) |
| 7 | `lib/app/di/[domain]_di.dart` | DataSource·Repository Provider 등록 (없으면 생성, 있으면 추가) |
| 8 | `lib/app/di/di.dart` | export 추가 (신규 DI 파일일 때만) |
| 9 | `test/data/[domain]/repository/[domain]_repository_impl_test.dart` | Repository 테스트 |

**DI 등록 순서:** DataSource → Repository

---

## 단계 3B: 필드 추가 — 수정 계획

아래 **4개 파일만** 수정한다.

| # | 파일 경로 | 수정 내용 |
|---|---|---|
| 1 | `lib/data/[domain]/datasource/local/[domain]_local_data_source.dart` | 키 상수 + get/set/remove 메서드 추가 |
| 2 | `lib/domain/[domain]/repository/[domain]_repository.dart` | 메서드 시그니처 추가 |
| 3 | `lib/data/[domain]/repository/[domain]_repository_impl.dart` | 메서드 구현 추가 |
| 4 | `test/data/[domain]/repository/[domain]_repository_impl_test.dart` | 신규 메서드 테스트 케이스 추가 |

**건드리지 않는 파일:** `preferences_service.dart`, `storage_exception_mapper.dart`, `[domain]_di.dart`, `di.dart`

---

## 단계 3C: 통합 추가 — 수정 계획

기존 DataSource(Hive/SecureStorage 등)에 PreferencesService를 통합한다.

| # | 파일 경로 | 수정 내용 |
|---|---|---|
| 1 | `lib/data/[domain]/datasource/local/[domain]_local_data_source.dart` | PreferencesService import·생성자 파라미터·키 상수·메서드 추가 |
| 2 | `lib/domain/[domain]/repository/[domain]_repository.dart` | 메서드 시그니처 추가 |
| 3 | `lib/data/[domain]/repository/[domain]_repository_impl.dart` | 메서드 구현 추가 |
| 4 | `lib/app/di/[domain]_di.dart` | DataSource Provider에 preferencesService 주입 추가 |
| 5 | `test/data/[domain]/repository/[domain]_repository_impl_test.dart` | 신규 메서드 테스트 추가 |

**건드리지 않는 파일:** `preferences_service.dart`, `storage_exception_mapper.dart`, `di.dart`

> **DI 체인 주의** — DataSource Provider를 `Future<[Domain]LocalDataSource>`로 바꾸면 Repository Provider도 `Future<[Domain]Repository>`로 변경해야 하고, Effect의 `ref.read([domain]RepositoryProvider)`도 `await ref.read([domain]RepositoryProvider.future)`로 수정해야 한다. 기존 Provider 반환 타입을 확인한 뒤 영향 범위를 사전에 파악하고 사용자에게 고지한다.

---

## 단계 4: 계획 제시 (승인 필요)

```
## 실행 계획

**흐름:** [신규 생성 / 필드 추가 / 통합 추가]
**도메인:** [domain]  |  **필드:** [field] ([Type])

**생성·수정 파일:**
1. [파일 경로] — [역할 / 수정 내용]
...

승인하시면 진행합니다.
```

**반드시 승인을 받은 후 단계 5로 진행한다.**

---

## 단계 5: 코드 생성

### PreferencesService (없을 때만 생성)

```dart
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  const PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  String? getString(String key) => _prefs.getString(key);
  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  bool? getBool(String key) => _prefs.getBool(key);
  Future<void> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  int? getInt(String key) => _prefs.getInt(key);
  Future<void> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  double? getDouble(String key) => _prefs.getDouble(key);
  Future<void> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  Future<void> remove(String key) => _prefs.remove(key);
}
```

> PreferencesService가 이미 있으면 Read 로 실제 메서드 시그니처를 파악하고 그 패턴을 따른다.

### StorageExceptionMapper (없을 때만 생성)

`lib/core/storage/common/exception/storage_exception.dart`와 `lib/domain/common/exception/app_exception.dart`를 **Read** 해 `when()` 케이스를 파악한 뒤 작성한다.

```dart
import 'package:[pkg]/core/storage/common/exception/storage_exception.dart';
import 'package:[pkg]/domain/common/exception/app_exception.dart';

class StorageExceptionMapper {
  const StorageExceptionMapper();

  AppException map(StorageException exception) {
    return exception.when(
      // Read로 파악한 케이스를 AppException 케이스로 매핑
      // 예: notFound: (msg) => AppException.notFound(msg),
      // 예: general: (msg) => AppException.unknown(msg),
    );
  }
}
```

> 도메인과 무관한 공통 인프라다. 앱 전체에서 한 번만 생성하며 이후 수정할 필요가 없다.

### 타입별 메서드 매핑

| 타입 | DataSource get | DataSource set | Repository read | Repository write |
|---|---|---|---|---|
| `String` | `getString` | `setString(key, value)` | `AppResult<String> read[F]()` | `Future<AppResult<void>> write[F](String value)` |
| `bool` | `getBool` | `setBool(key, value)` | `AppResult<bool> read[F]()` | `Future<AppResult<void>> write[F](bool value)` |
| `int` | `getInt` | `setInt(key, value)` | `AppResult<int> read[F]()` | `Future<AppResult<void>> write[F](int value)` |
| `double` | `getDouble` | `setDouble(key, value)` | `AppResult<double> read[F]()` | `Future<AppResult<void>> write[F](double value)` |

> **read는 동기** (`Future` 없음) — SharedPreferences는 메모리 캐시에서 즉시 반환한다.
> **write·remove는 비동기** — 디스크 쓰기가 발생한다.

### Repository 인터페이스

```dart
import 'package:[pkg]/domain/common/entity/app_result.dart';

abstract class [Domain]Repository {
  AppResult<[Type]> read[Field]();
  Future<AppResult<void>> write[Field]([Type] value);
  Future<AppResult<void>> remove[Field]();
}
```

### LocalDataSource

```dart
import 'package:[pkg]/core/storage/common/dto/storage_response.dart';
import 'package:[pkg]/core/storage/common/exception/storage_exception.dart';
import 'package:[pkg]/core/storage/preferences/preferences_service.dart';

abstract class [Domain]LocalDataSource {
  StorageResponse<[Type]> get[Field]();
  Future<StorageResponse<void>> set[Field]([Type] value);
  Future<StorageResponse<void>> remove[Field]();
}

class [Domain]LocalDataSourceImpl implements [Domain]LocalDataSource {
  const [Domain]LocalDataSourceImpl({required PreferencesService preferencesService})
      : _prefs = preferencesService;

  final PreferencesService _prefs;

  static const _k[Field] = '[domain]_[field]';

  @override
  StorageResponse<[Type]> get[Field]() {
    final value = _prefs.get[TypeMethod](_k[Field]);
    if (value == null) {
      return StorageResponse.failure(
        StorageException.notFound('[Field] not found'),
      );
    }
    return StorageResponse.success(value);
  }

  @override
  Future<StorageResponse<void>> set[Field]([Type] value) async {
    try {
      await _prefs.set[TypeMethod](_k[Field], value);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> remove[Field]() async {
    try {
      await _prefs.remove(_k[Field]);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }
}
```

> 기존 키 네이밍 패턴(`_k[Field]`)을 확인해 일관성을 유지한다.
> **키 충돌 주의** — SharedPreferences 키는 앱 전역에서 공유된다. Grep으로 기존 키 상수(`static const _k`)를 검색해 목록을 확인하고 `[domain]_[field]` 형식으로 고유하게 지정한다.
> 통합 추가(3C) 시: 기존 생성자 파라미터 다음에 `PreferencesService`를 추가하고 기존 필드·메서드 다음에 삽입한다.

### RepositoryImpl

```dart
import 'package:[pkg]/domain/common/entity/app_result.dart';
import 'package:[pkg]/domain/common/exception/app_exception.dart';
import 'package:[pkg]/domain/[domain]/repository/[domain]_repository.dart';
import 'package:[pkg]/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import 'package:[pkg]/data/common/mapper/storage_exception_mapper.dart';

class [Domain]RepositoryImpl implements [Domain]Repository {
  const [Domain]RepositoryImpl({
    required this.localDataSource,
    required this.storageExceptionMapper,
  });

  final [Domain]LocalDataSource localDataSource;
  final StorageExceptionMapper storageExceptionMapper;

  @override
  AppResult<[Type]> read[Field]() {
    final response = localDataSource.get[Field]();
    return response.when(
      success: (value) => AppResult.success(value),
      failure: (exception) => AppResult.failure(storageExceptionMapper.map(exception)),
    );
  }

  @override
  Future<AppResult<void>> write[Field]([Type] value) async {
    final response = await localDataSource.set[Field](value);
    return response.when(
      success: (_) => const AppResult.success(null),
      failure: (exception) => AppResult.failure(storageExceptionMapper.map(exception)),
    );
  }

  @override
  Future<AppResult<void>> remove[Field]() async {
    final response = await localDataSource.remove[Field]();
    return response.when(
      success: (_) => const AppResult.success(null),
      failure: (exception) => AppResult.failure(storageExceptionMapper.map(exception)),
    );
  }
}
```

### DI

**storage_di.dart** — `preferencesServiceProvider` 없으면 추가:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:[pkg]/core/storage/preferences/preferences_service.dart';

part 'storage_di.g.dart';

@Riverpod(keepAlive: true)
Future<PreferencesService> preferencesService(PreferencesServiceRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  return PreferencesService(prefs);
}
```

**[domain]_di.dart** — `PreferencesService`의 비동기 초기화로 인해 Provider가 `Future<>` 반환:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:[pkg]/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import 'package:[pkg]/data/[domain]/repository/[domain]_repository_impl.dart';
import 'package:[pkg]/data/common/mapper/storage_exception_mapper.dart';
import 'package:[pkg]/domain/[domain]/repository/[domain]_repository.dart';
import 'package:[pkg]/app/di/storage_di.dart';

part '[domain]_di.g.dart';

// 순서 1: DataSource
@Riverpod(keepAlive: true)
Future<[Domain]LocalDataSource> [domain]LocalDataSource(
  [Domain]LocalDataSourceRef ref,
) async {
  final prefs = await ref.read(preferencesServiceProvider.future);
  return [Domain]LocalDataSourceImpl(preferencesService: prefs);
}

// 순서 2: Repository
@Riverpod(keepAlive: true)
Future<[Domain]Repository> [domain]Repository([Domain]RepositoryRef ref) async {
  final ds = await ref.read([domain]LocalDataSourceProvider.future);
  return [Domain]RepositoryImpl(
    localDataSource: ds,
    storageExceptionMapper: const StorageExceptionMapper(),
  );
}
```

**di.dart** — 신규 DI 파일일 때만 export 추가:

```dart
export '[domain]_di.dart';
```

**Effect에서 사용 시:**

```dart
// read: 동기
final repo = await ref.read([domain]RepositoryProvider.future);
final result = repo.read[Field]();

// write: 비동기
final repo = await ref.read([domain]RepositoryProvider.future);
final result = await repo.write[Field](value);
```

### 테스트

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:[pkg]/core/storage/common/dto/storage_response.dart';
import 'package:[pkg]/core/storage/common/exception/storage_exception.dart';
import 'package:[pkg]/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import 'package:[pkg]/data/[domain]/repository/[domain]_repository_impl.dart';
import 'package:[pkg]/data/common/mapper/storage_exception_mapper.dart';
import 'package:[pkg]/domain/common/entity/app_result.dart';
import '[domain]_repository_impl_test.mocks.dart';

@GenerateMocks([[Domain]LocalDataSource])
void main() {
  late [Domain]RepositoryImpl repository;
  late Mock[Domain]LocalDataSource mockDataSource;

  setUp(() {
    mockDataSource = Mock[Domain]LocalDataSource();
    repository = [Domain]RepositoryImpl(
      localDataSource: mockDataSource,
      storageExceptionMapper: const StorageExceptionMapper(),
    );
  });

  group('[Domain]RepositoryImpl', () {
    // 타입에 맞게 선택:
    // String → const testValue = 'test-value';
    // bool   → const testValue = true;
    // int    → const testValue = 42;
    // double → const testValue = 3.14;

    test('read[Field] 성공 시 AppSuccess와 값을 반환한다', () {
      // get[Field]는 동기 → thenReturn (thenAnswer 아님)
      when(mockDataSource.get[Field]())
          .thenReturn(StorageResponse.success(testValue));

      final result = repository.read[Field]();

      result.when(
        success: (value) => expect(value, testValue),
        failure: (_) => fail('success 기대'),
      );
    });

    test('read[Field] 값 없을 때 AppFailure를 반환한다', () {
      when(mockDataSource.get[Field]()).thenReturn(
        StorageResponse.failure(
          StorageException.notFound('[Field] not found'),
        ),
      );

      final result = repository.read[Field]();

      expect(result, isA<AppFailure<[Type]>>());
    });

    test('write[Field] 성공 시 AppSuccess를 반환한다', () async {
      when(mockDataSource.set[Field](testValue))
          .thenAnswer((_) async => const StorageResponse.success(null));

      final result = await repository.write[Field](testValue);

      result.when(
        success: (_) => expect(true, true),
        failure: (_) => fail('success 기대'),
      );
    });

    test('remove[Field] 성공 시 AppSuccess를 반환한다', () async {
      when(mockDataSource.remove[Field]())
          .thenAnswer((_) async => const StorageResponse.success(null));

      final result = await repository.remove[Field]();

      result.when(
        success: (_) => expect(true, true),
        failure: (_) => fail('success 기대'),
      );
    });
  });
}
```

> `get[Field]`는 동기이므로 Mock에서 `thenReturn` 사용. `set`/`remove`는 `thenAnswer`.

---

## 단계 6: build_runner

DI 파일을 변경했으면 재생성한다.

```bash
dart run build_runner build --delete-conflicting-outputs
```

확인 파일:
- `storage_di.g.dart` (신규 생성·수정한 경우)
- `[domain]_di.g.dart`
- `[domain]_repository_impl_test.mocks.dart`

---

## 단계 7: 검증

```bash
flutter analyze
flutter test test/data/[domain]/repository/[domain]_repository_impl_test.dart
```

체크리스트:
- `StorageResponse` / `StorageException`이 Repository 구현체 외부로 노출되지 않음
- `read[Field]`가 동기, `write[Field]`·`remove[Field]`가 비동기
- 모든 `StorageResponse.when()` 케이스 처리 (success / failure)
- `maybeWhen()` 미사용
- `keepAlive: true` Provider에서 `ref.read` 사용 (`ref.watch` 금지)
- 신규 DI 파일이면 `di.dart`에 export 추가됐는지 확인

---

## 완료 보고

```
## 완료

**흐름:** [신규 생성 / 필드 추가 / 통합 추가]
**도메인:** [domain]  |  **필드:** [field] ([Type])

**생성·수정된 파일:**
- [파일 경로] — [역할]
```

---

## 금지 사항

- 사용자 승인 없이 파일을 생성·수정하지 않는다
- `DataSource`에서 `StorageResponse`를 `AppResult`로 변환하지 않는다
- `Repository`에서 `StorageException`을 `AppException`으로 직접 변환하지 않는다 (`StorageExceptionMapper` 사용)
- `PreferencesService`를 ViewModel·UseCase에서 직접 참조하도록 구현하지 않는다
- `maybeWhen()`을 사용하지 않는다 (`when()` 필수)
- `read[Field]`를 `async/Future`로 구현하지 않는다 — SharedPreferences는 메모리 캐시에서 동기 반환
- `keepAlive: true` Provider에서 `ref.watch`를 사용하지 않는다
- 지원 타입 (`String`, `bool`, `int`, `double`) 외 타입을 추측으로 구현하지 않는다
- 필드 추가(3B)에서 DI 파일·`preferences_service.dart`·`storage_exception_mapper.dart`를 건드리지 않는다
