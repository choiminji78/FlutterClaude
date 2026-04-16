---
name: add-storage-secure-storage
description: This skill should be used when the user asks to "secure storage 추가", "보안 저장소 추가", "토큰 저장소 생성", "암호화 저장 추가", "secure storage 필드 추가", "민감 정보 저장 추가", "add-storage-secure-storage", or requests creation or extension of a flutter_secure_storage-based encrypted storage for a domain.
argument-hint: "[domain] ([field])?"
---

# Add Secure Storage

`flutter_secure_storage` 기반 암호화 키-값 저장소를 도메인에 추가한다.
iOS Keychain / Android Keystore에 자동 암호화 저장. **String 타입만 지원.**

> Hive·SharedPreferences 등 다른 저장소 유형이 필요하면 `/add-local-datasource` 사용.

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

모두 존재하면 단계 1로 이동.

---

## 단계 1: 인수 확인

`$ARGUMENTS`에서 도메인명과 필드명을 파악한다.

| `$ARGUMENTS` 형태 | 처리 |
|---|---|
| 없음 | 도메인명·필드명을 사용자에게 질문 |
| `[domain]` | 도메인 확인됨. 필드명을 사용자에게 질문 |
| `[domain] [field]` | 모두 확인됨. 2단계로 이동 |

**타입 고정:** `flutter_secure_storage`는 String만 지원. 타입 질문 불필요.

---

## 단계 2: 사전 확인 → 흐름 분기

### pubspec.yaml + Android 설정 확인

`pubspec.yaml`을 Read로 읽어 세 가지를 확인한다.

1. `flutter_secure_storage` 의존성 — 없으면 추가 후 `flutter pub get` 실행
2. `name:` 필드 값 파악 — 이후 모든 import는 `package:[패키지명]/` 절대 경로로 작성
3. `android/app/build.gradle`을 Read로 읽어 `minSdkVersion` 확인 — **18 미만이면** 사용자에게 `minSdkVersion 18` 이상으로 변경을 안내하고 중단

### 기존 파일 확인

Glob으로 아래 파일을 확인한다.

```
lib/domain/[domain]/repository/[domain]_repository.dart              ← Repository 인터페이스
lib/data/[domain]/datasource/local/[domain]_local_data_source.dart   ← LocalDataSource 존재 여부
lib/data/[domain]/repository/[domain]_repository_impl.dart           ← 구현체 존재 여부
lib/data/common/mapper/storage_exception_mapper.dart                 ← 공통 Mapper
lib/core/storage/secure_storage/secure_storage_service.dart          ← Service
lib/app/di/storage_di.dart                                           ← Storage DI
```

**Repository 인터페이스 필수:**

| 상태 | 대응 |
|---|---|
| 없음 | "Repository 인터페이스가 없습니다. `/add-repository`로 먼저 생성해 주세요." 후 중단 |
| 있음 | Read로 기존 메서드 목록을 파악한 뒤 다음으로 |

**흐름 분기:**

LocalDataSource 파일이 있으면 반드시 Read로 열어 `SecureStorageService` import 존재 여부를 확인한다.

| LocalDataSource | `SecureStorageService` import | 흐름 |
|---|---|---|
| 없음 | — | **신규** |
| 있음 | 있음 | **필드 추가** |
| 있음 | 없음 | **통합 추가** |

---

## 단계 3: 파일 목록 제시

흐름에 따라 아래 파일 목록을 제시한다. **반드시 사용자 승인 후 4단계로 진행.**

### 신규

```
lib/core/storage/secure_storage/secure_storage_service.dart      ← 없을 때만 생성
lib/data/common/mapper/storage_exception_mapper.dart             ← 없을 때만 생성
lib/data/[domain]/datasource/local/[domain]_local_data_source.dart
lib/domain/[domain]/repository/[domain]_repository.dart          ← 메서드 시그니처 추가
lib/data/[domain]/repository/[domain]_repository_impl.dart       ← 없으면 생성, 있으면 메서드 추가
lib/app/di/storage_di.dart                                       ← 없으면 생성, secureStorageServiceProvider 없으면 추가
lib/app/di/di.dart                                               ← storage_di.dart 신규 생성 시 export 추가
lib/app/di/[domain]_di.dart                                      ← 없으면 생성, 있으면 Provider 추가
lib/app/di/di.dart                                               ← [domain]_di.dart 신규 생성 시 export 추가
test/data/[domain]/repository/[domain]_repository_impl_test.dart ← 없으면 생성, 있으면 케이스 추가
```

### 필드 추가

```
lib/data/[domain]/datasource/local/[domain]_local_data_source.dart  ← 키 상수 + 메서드 추가
lib/domain/[domain]/repository/[domain]_repository.dart             ← 시그니처 추가
lib/data/[domain]/repository/[domain]_repository_impl.dart          ← 메서드 구현 추가
test/data/[domain]/repository/[domain]_repository_impl_test.dart    ← 테스트 케이스 추가
```

### 통합 추가

```
lib/core/storage/secure_storage/secure_storage_service.dart      ← 없을 때만 생성
lib/data/common/mapper/storage_exception_mapper.dart             ← 없을 때만 생성
lib/data/[domain]/datasource/local/[domain]_local_data_source.dart  ← SecureStorageService 주입 통합
lib/domain/[domain]/repository/[domain]_repository.dart             ← 시그니처 추가
lib/data/[domain]/repository/[domain]_repository_impl.dart          ← 메서드 구현 + import 추가
lib/app/di/storage_di.dart                                          ← 없으면 생성, secureStorageServiceProvider 없으면 추가
lib/app/di/di.dart                                                  ← storage_di.dart 신규 생성 시 export 추가
lib/app/di/[domain]_di.dart                                         ← DataSource Provider 수정
test/data/[domain]/repository/[domain]_repository_impl_test.dart    ← 테스트 케이스 추가
```

---

## 단계 4: 코드 생성

**신규 흐름 생성 순서:** SecureStorageService → StorageExceptionMapper → LocalDataSource → Repository 인터페이스(시그니처 추가) → RepositoryImpl → storage_di → [domain]_di → di.dart export → 테스트

각 파일은 생성·수정 전 반드시 Read로 현재 상태를 확인한다.

---

### SecureStorageService (없을 때만 생성)

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<String?> read({required String key}) => _storage.read(key: key);

  Future<void> write({required String key, required String value}) =>
      _storage.write(key: key, value: value);

  Future<void> delete({required String key}) => _storage.delete(key: key);
}
```

> 위치: `lib/core/storage/secure_storage/secure_storage_service.dart`

---

### StorageExceptionMapper (없을 때만 생성)

`lib/core/storage/common/exception/storage_exception.dart`와 `lib/domain/common/exception/app_exception.dart`를 Read로 열어 `when()` 케이스를 파악한 뒤 작성한다.

```dart
import 'package:[패키지명]/core/storage/common/exception/storage_exception.dart';
import 'package:[패키지명]/domain/common/exception/app_exception.dart';

class StorageExceptionMapper {
  const StorageExceptionMapper();

  AppException map(StorageException exception) {
    return exception.when(
      // Read로 파악한 StorageException 케이스를 AppException 케이스로 매핑
      // 예: notFound: (message) => AppException.notFound(message),
      // 예: general: (message) => AppException.unknown(message),
    );
  }
}
```

> 위치: `lib/data/common/mapper/storage_exception_mapper.dart`
> 이 파일은 도메인과 무관한 공통 인프라. 앱 전체에서 한 번만 생성된다.

---

### Local DataSource

**신규 / 통합 추가 — 신규 생성 또는 SecureStorageService 통합:**

```dart
import 'package:[패키지명]/core/storage/common/dto/storage_response.dart';
import 'package:[패키지명]/core/storage/common/exception/storage_exception.dart';
import 'package:[패키지명]/core/storage/secure_storage/secure_storage_service.dart';

abstract class [Domain]LocalDataSource {
  Future<StorageResponse<String>> read[Field]();
  Future<StorageResponse<void>> write[Field]({required String value});
  Future<StorageResponse<void>> delete[Field]();
}

class [Domain]LocalDataSourceImpl implements [Domain]LocalDataSource {
  const [Domain]LocalDataSourceImpl({required this.secureStorageService});

  final SecureStorageService secureStorageService;

  static const _key[Field] = '[domain]_[field]';

  @override
  Future<StorageResponse<String>> read[Field]() async {
    try {
      final value = await secureStorageService.read(key: _key[Field]);
      if (value == null) {
        return StorageResponse.failure(
          StorageException.notFound('[Field] not found'),
        );
      }
      return StorageResponse.success(value);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> write[Field]({required String value}) async {
    try {
      await secureStorageService.write(key: _key[Field], value: value);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }

  @override
  Future<StorageResponse<void>> delete[Field]() async {
    try {
      await secureStorageService.delete(key: _key[Field]);
      return const StorageResponse.success(null);
    } catch (e) {
      return StorageResponse.failure(StorageException.general(e.toString()));
    }
  }
}
```

**필드 추가 — 기존 파일에 추가 (기존 마지막 항목 다음):**

abstract에 시그니처 3개, Impl에 키 상수 + 메서드 구현 3개를 추가한다.
키 상수 네이밍은 `_key[Field] = '[domain]_[field]'` 형태로 기존 패턴을 유지한다.

**통합 추가 — 기존 DataSource에 SecureStorageService 통합 시 수정 순서:**
1. `import secure_storage_service.dart` 추가
2. 생성자에 `required this.secureStorageService` 파라미터 추가
3. `final SecureStorageService secureStorageService;` 필드 선언 추가
4. 기존 필드·메서드 다음에 키 상수 + 메서드 추가

---

### Repository 인터페이스 — 메서드 시그니처 추가

기존 `[domain]_repository.dart`에 아래 시그니처를 추가한다.

```dart
Future<AppResult<String>> read[Field]();
Future<AppResult<void>> write[Field]({required String value});
Future<AppResult<void>> delete[Field]();
```

---

### Repository 구현체

**신규 생성 (구현체 없을 때):**

```dart
import 'package:[패키지명]/domain/common/entity/app_result.dart';
import 'package:[패키지명]/domain/common/exception/app_exception.dart';
import 'package:[패키지명]/domain/[domain]/repository/[domain]_repository.dart';
import 'package:[패키지명]/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import 'package:[패키지명]/data/common/mapper/storage_exception_mapper.dart';

class [Domain]RepositoryImpl implements [Domain]Repository {
  const [Domain]RepositoryImpl({
    required this.localDataSource,
    required this.storageExceptionMapper,
  });

  final [Domain]LocalDataSource localDataSource;
  final StorageExceptionMapper storageExceptionMapper;

  @override
  Future<AppResult<String>> read[Field]() async {
    final response = await localDataSource.read[Field]();
    return response.when(
      success: (value) => AppResult.success(value),
      failure: (exception) => AppResult.failure(storageExceptionMapper.map(exception)),
    );
  }

  @override
  Future<AppResult<void>> write[Field]({required String value}) async {
    final response = await localDataSource.write[Field](value: value);
    return response.when(
      success: (_) => const AppResult.success(null),
      failure: (exception) => AppResult.failure(storageExceptionMapper.map(exception)),
    );
  }

  @override
  Future<AppResult<void>> delete[Field]() async {
    final response = await localDataSource.delete[Field]();
    return response.when(
      success: (_) => const AppResult.success(null),
      failure: (exception) => AppResult.failure(storageExceptionMapper.map(exception)),
    );
  }
}
```

**기존 구현체에 메서드 추가:**

기존 파일을 Read 후 마지막 메서드 다음에 추가한다.
`storageExceptionMapper` 필드가 없으면 생성자 파라미터와 필드 선언도 추가한다.

```dart
// 기존 구현체에 추가 — write[Field], delete[Field]도 동일 패턴
@override
Future<AppResult<String>> read[Field]() async {
  final response = await localDataSource.read[Field]();
  return response.when(
    success: (value) => AppResult.success(value),
    failure: (exception) => AppResult.failure(storageExceptionMapper.map(exception)),
  );
}
```

---

### DI 등록

#### storage_di.dart

파일을 Read로 열어 `secureStorageServiceProvider` 존재 여부를 확인한다.

**`storage_di.dart` 없으면 신규 생성:**

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:[패키지명]/core/storage/secure_storage/secure_storage_service.dart';

part 'storage_di.g.dart';

@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(SecureStorageServiceRef ref) {
  return SecureStorageService();
}
```

신규 생성 시 `lib/app/di/di.dart`에 export 한 줄을 추가한다.

```dart
export 'storage_di.dart';
```

**`storage_di.dart` 있고 `secureStorageServiceProvider` 없으면:** 파일 마지막에 Provider만 추가한다.

**`secureStorageServiceProvider` 이미 있으면:** 건드리지 않는다.

#### [domain]_di.dart

**신규 생성:**

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:[패키지명]/app/di/storage_di.dart';
import 'package:[패키지명]/core/storage/secure_storage/secure_storage_service.dart';
import 'package:[패키지명]/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import 'package:[패키지명]/data/[domain]/repository/[domain]_repository_impl.dart';
import 'package:[패키지명]/data/common/mapper/storage_exception_mapper.dart';
import 'package:[패키지명]/domain/[domain]/repository/[domain]_repository.dart';

part '[domain]_di.g.dart';

// 순서 1: DataSource
@Riverpod(keepAlive: true)
[Domain]LocalDataSource [domain]LocalDataSource([Domain]LocalDataSourceRef ref) {
  return [Domain]LocalDataSourceImpl(
    secureStorageService: ref.read(secureStorageServiceProvider),
  );
}

// 순서 2: Repository
@Riverpod(keepAlive: true)
[Domain]Repository [domain]Repository([Domain]RepositoryRef ref) {
  return [Domain]RepositoryImpl(
    localDataSource: ref.read([domain]LocalDataSourceProvider),
    storageExceptionMapper: const StorageExceptionMapper(),
  );
}
```

신규 생성 시 `lib/app/di/di.dart`에 export 한 줄을 추가한다.

```dart
export '[domain]_di.dart';
```

**기존 파일에 Provider 추가:**
파일을 Read 후 기존 마지막 Provider 다음에 `[domain]LocalDataSource` Provider와 필요 시 `[domain]Repository` Provider를 추가한다.
`storage_di.dart` import가 없으면 추가한다.

**통합 추가 — 기존 DataSource Provider 수정:**
기존 DataSource Provider 생성자에 `secureStorageService: ref.read(secureStorageServiceProvider)` 주입을 추가하고, `storage_di.dart` import를 추가한다.
기존 Provider 반환 타입(`Future<>` 여부)은 그대로 유지한다.

---

### 테스트

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:[패키지명]/core/storage/common/dto/storage_response.dart';
import 'package:[패키지명]/core/storage/common/exception/storage_exception.dart';
import 'package:[패키지명]/data/[domain]/datasource/local/[domain]_local_data_source.dart';
import 'package:[패키지명]/data/[domain]/repository/[domain]_repository_impl.dart';
import 'package:[패키지명]/data/common/mapper/storage_exception_mapper.dart';
import 'package:[패키지명]/domain/common/entity/app_result.dart';
import '[domain]_repository_impl_test.mocks.dart';

@GenerateMocks([[Domain]LocalDataSource])
void main() {
  late [Domain]RepositoryImpl repository;
  late Mock[Domain]LocalDataSource mockLocalDataSource;

  setUp(() {
    // Freezed sealed class 반환 타입에 대한 Mockito 기본값 등록 (MissingDummyValueError 방지)
    provideDummy<StorageResponse<String>>(const StorageResponse.success(''));
    provideDummy<StorageResponse<void>>(const StorageResponse.success(null));
    mockLocalDataSource = Mock[Domain]LocalDataSource();
    repository = [Domain]RepositoryImpl(
      localDataSource: mockLocalDataSource,
      storageExceptionMapper: const StorageExceptionMapper(),
    );
  });

  group('[Domain]RepositoryImpl', () {
    const testValue = 'test-value';

    group('read[Field]', () {
      test('성공 시 AppSuccess와 String을 반환한다', () async {
        when(mockLocalDataSource.read[Field]())
            .thenAnswer((_) async => const StorageResponse.success(testValue));

        final result = await repository.read[Field]();

        result.when(
          success: (value) => expect(value, testValue),
          failure: (_) => fail('success 기대'),
        );
      });

      test('값이 없으면 AppFailure를 반환한다', () async {
        when(mockLocalDataSource.read[Field]()).thenAnswer(
          (_) async => StorageResponse.failure(
            StorageException.notFound('[Field] not found'),
          ),
        );

        final result = await repository.read[Field]();

        expect(result, isA<AppFailure<String>>());
      });
    });

    group('write[Field]', () {
      test('성공 시 AppSuccess를 반환한다', () async {
        when(mockLocalDataSource.write[Field](value: testValue))
            .thenAnswer((_) async => const StorageResponse.success(null));

        final result = await repository.write[Field](value: testValue);

        result.when(
          success: (_) => expect(true, isTrue),
          failure: (_) => fail('success 기대'),
        );
      });

      test('저장 실패 시 AppFailure를 반환한다', () async {
        when(mockLocalDataSource.write[Field](value: testValue)).thenAnswer(
          (_) async => StorageResponse.failure(
            StorageException.general('write failed'),
          ),
        );

        final result = await repository.write[Field](value: testValue);

        expect(result, isA<AppFailure<void>>());
      });
    });

    group('delete[Field]', () {
      test('성공 시 AppSuccess를 반환한다', () async {
        when(mockLocalDataSource.delete[Field]())
            .thenAnswer((_) async => const StorageResponse.success(null));

        final result = await repository.delete[Field]();

        result.when(
          success: (_) => expect(true, isTrue),
          failure: (_) => fail('success 기대'),
        );
      });

      test('삭제 실패 시 AppFailure를 반환한다', () async {
        when(mockLocalDataSource.delete[Field]()).thenAnswer(
          (_) async => StorageResponse.failure(
            StorageException.general('delete failed'),
          ),
        );

        final result = await repository.delete[Field]();

        expect(result, isA<AppFailure<void>>());
      });
    });
  });
}
```

기존 테스트 파일이 있으면 Read 후 해당 `group` 블록 안에 케이스만 추가한다.

---

## 단계 5: build_runner

```bash
dart run build_runner build --delete-conflicting-outputs
```

변경 파일에 아래가 포함됐는지 확인한다.

- `storage_di.g.dart` (`storage_di.dart` 신규 생성 시)
- `[domain]_di.g.dart` (DI 변경 시)
- `[domain]_repository_impl_test.mocks.dart`

---

## 단계 6: 검증

```bash
flutter analyze
flutter test test/data/[domain]/repository/[domain]_repository_impl_test.dart
```

- LocalDataSource import: `core/storage/secure_storage/` + `core/storage/common/` 만 허용
- Repository 구현체 외부로 `StorageResponse` / `StorageException` 노출 없음
- `StorageResponse.when()` 모든 케이스 처리 (success / failure)
- 키 상수 네이밍: `_key[Field] = '[domain]_[field]'` 형태
- `keepAlive: true` DI Provider에서 `ref.read` 사용 (`ref.watch` 없음)
- 신규 DI 파일이면 `di.dart`에 export 추가됐는지 확인

---

## 금지

- Repository 인터페이스 없이 LocalDataSource를 먼저 생성
- DataSource에서 `StorageResponse`를 `AppResult`로 변환
- `StorageException`을 `StorageExceptionMapper` 없이 직접 변환
- `SecureStorageService`를 ViewModel / UseCase에서 직접 참조
- `maybeWhen()` 사용 (`when()` 필수)
- String 외 타입으로 저장 (`flutter_secure_storage`는 String 전용)
- `keepAlive: true` DI Provider에서 `ref.watch` 사용
- 사용자 승인 없이 파일 생성·수정
