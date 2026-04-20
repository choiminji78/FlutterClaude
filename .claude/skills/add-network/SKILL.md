---
name: add-network
description: HTTP 네트워크 인프라(NetworkException·ApiResponse·[Server]ApiClient·인터셉터·ApiService·network_di·ExceptionMapper)를 설정한다. 도메인 DataSource·DTO·Mapper·Repository는 `/add-remote-datasource` 스킬을 사용한다.
---

# Add Network

HTTP 네트워크 인프라만 설정한다. 인프라 설정 후 도메인 연동은 `/add-remote-datasource`로 진행.

---

## 핵심 원칙

1. **단방향 에러 전파** — `DioException → ErrorInterceptor → NetworkException → ApiFailure → Repository(ExceptionMapper) → AppException → AppFailure`
2. **변환 책임** — `ApiResponse → AppResult`는 Repository에서만. DataSource는 `ApiResponse<DTO>` 그대로 반환.
3. **인터셉터 순서** — `[Logging, Retry, Error]`. Retry가 Error 앞 (원본 DioExceptionType 필요).
4. **서버별 Client** — 서버 이름을 딴 `[Server]ApiClient`. 여러 서버 혼용 시 각각 별도 Client.
5. **Base URL 위치** — `NetworkConstants`에 `static const String [server]BaseUrl`. Client 생성자에 하드코딩 금지.
6. **계획 우선** — 파일 생성·수정 전 계획 제시 후 승인 필수.

---

## 단계 0: 사전 확인

Glob으로 확인:
```
lib/domain/common/entity/app_result.dart
lib/domain/common/exception/app_exception.dart
```
없으면 → "`/init-project` 먼저 실행 필요." 안내 후 중단.

**pubspec.yaml** Read → `name:` ([pkg]), `dio:` 없으면 추가 필요.

```yaml
dependencies:
  dio: ^5.8.0+1
```

---

## 단계 1: 기존 파일 확인

Glob으로 확인:
```
lib/core/network/http/service/api_service.dart
lib/app/di/network_di.dart
lib/data/common/mapper/exception_mapper.dart
```

| api_service.dart | 처리 |
|---|---|
| 없음 | 인프라 신규 → 계속 |
| 있음 | "이미 설정됨." 안내 후 종료 |

---

## 단계 2: 정보 수집 (한 번에 질문)

- **서버 이름**: 클라이언트 클래스명에 사용 (예: `Jsonplaceholder` → `JsonplaceholderApiClient`)
- **Base URL**: `https://api.example.com`
- **인증**: 없음 / Bearer Token / API Key Header
  - Bearer Token이면: SecureStorage 키 이름 (기본 `'auth_token'`) + `storage_di.dart` 존재 여부 Glob 확인
- **Retry**: 0~3회 (0 = 없음). 대상: 네트워크 단절·연결 타임아웃만.
- **타임아웃**: 연결·수신 (기본 10s / 30s)
- **LoggingInterceptor**: 직접 구현 / `pretty_dio_logger`

---

## 단계 3: 계획 제시 (승인 필요)

```
**서버:** [Server]ApiClient
**Base URL:** [url]
**인증:** [방식]
**Retry:** [횟수]회

생성·수정 파일:
1. [경로] — [역할]
...

승인하시면 진행합니다.
```

---

## 단계 4: 코드 생성

### NetworkException

`app_exception.dart` Read 후 케이스 1:1 대응으로 작성.

```dart
// lib/core/network/exception/network_exception.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'network_exception.freezed.dart';

@freezed
sealed class NetworkException with _$NetworkException {
  const factory NetworkException.network(String message) = NetworkExceptionNetwork;
  const factory NetworkException.server(int statusCode, String message) = NetworkExceptionServer;
  const factory NetworkException.unauthorized(String message) = NetworkExceptionUnauthorized;
  const factory NetworkException.forbidden(String message) = NetworkExceptionForbidden;
  const factory NetworkException.notFound(String message) = NetworkExceptionNotFound;
  const factory NetworkException.timeout(String message) = NetworkExceptionTimeout;
  const factory NetworkException.unknown(String message) = NetworkExceptionUnknown;
}
```

---

### ApiResponse

```dart
// lib/core/network/http/dto/api_response.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:[pkg]/core/network/exception/network_exception.dart';
part 'api_response.freezed.dart';

@freezed
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success(T data) = ApiSuccess<T>;
  const factory ApiResponse.failure(NetworkException exception) = ApiFailure<T>;
}
```

---

### NetworkConstants

Base URL은 서버 이름으로 식별. 타임아웃·Retry 횟수 포함.

```dart
// lib/core/network/http/utils/network_constants.dart
class NetworkConstants {
  const NetworkConstants._();

  static const String [server]BaseUrl = '[BASE_URL]';

  static const Duration connectTimeout = Duration(seconds: [N]);
  static const Duration receiveTimeout = Duration(seconds: [N]);
  static const int maxRetryAttempts = [N]; // 0이면 RetryInterceptor 불필요
}
```

---

### LoggingInterceptor

`app_logger.dart` Glob 확인 → 있으면 import, 없으면 `debugPrint`.

```dart
// lib/core/network/http/interceptor/logging_interceptor.dart
import 'package:dio/dio.dart';
import 'package:[pkg]/core/logging/app_logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.debug('[REQ] ${options.method} ${options.uri}');
    handler.next(options);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.debug('[RES] ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error('[ERR] ${err.type} ${err.requestOptions.uri}', err.error);
    handler.next(err);
  }
}
```

`pretty_dio_logger` 선택 시: pubspec 추가 후 `[Server]ApiClient`에서 `PrettyDioLogger()` 직접 인스턴스화.

---

### RetryInterceptor (maxRetryAttempts > 0만)

```dart
// lib/core/network/http/interceptor/retry_interceptor.dart
import 'package:dio/dio.dart';
import 'package:[pkg]/core/network/http/utils/network_constants.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor({required this.dio});
  final Dio dio;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = (err.requestOptions.extra['retryCount'] as int?) ?? 0;
    final shouldRetry = retryCount < NetworkConstants.maxRetryAttempts &&
        (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.connectionTimeout);
    if (!shouldRetry) return handler.next(err);
    err.requestOptions.extra['retryCount'] = retryCount + 1;
    try {
      handler.resolve(await dio.fetch(err.requestOptions));
    } catch (_) {
      handler.next(err);
    }
  }
}
```

---

### ErrorInterceptor

```dart
// lib/core/network/http/interceptor/error_interceptor.dart
import 'package:dio/dio.dart';
import 'package:[pkg]/core/network/exception/network_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: _toNetworkException(err),
    ));
  }

  NetworkException _toNetworkException(DioException err) {
    final msg = err.message ?? '';
    return switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout => NetworkException.timeout(msg),
      DioExceptionType.connectionError => NetworkException.network(msg),
      DioExceptionType.badResponse => _fromStatusCode(err.response?.statusCode ?? 0, msg),
      _ => NetworkException.unknown(msg),
    };
  }

  NetworkException _fromStatusCode(int code, String msg) => switch (code) {
    401 => NetworkException.unauthorized(msg),
    403 => NetworkException.forbidden(msg),
    404 => NetworkException.notFound(msg),
    >= 500 => NetworkException.server(code, msg),
    _ => NetworkException.unknown(msg),
  };
}
```

---

### AuthInterceptor (Bearer Token만)

```dart
// lib/core/network/http/interceptor/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:[pkg]/core/storage/secure_storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.secureStorageService});
  final SecureStorageService secureStorageService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureStorageService.read(key: '[token_key]');
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}
```

---

### BaseClient / [Server]ApiClient

```dart
// lib/core/network/http/client/base_client.dart
import 'package:dio/dio.dart';

abstract class BaseClient {
  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers});
  Future<Response<dynamic>> post(String path, {dynamic data});
  Future<Response<dynamic>> put(String path, {dynamic data});
  Future<Response<dynamic>> patch(String path, {dynamic data});
  Future<Response<dynamic>> delete(String path, {Map<String, dynamic>? queryParameters});
}
```

```dart
// lib/core/network/http/client/[server]_api_client.dart
import 'package:dio/dio.dart';
import 'package:[pkg]/core/network/http/interceptor/error_interceptor.dart';
import 'package:[pkg]/core/network/http/interceptor/logging_interceptor.dart';
// import 'package:[pkg]/core/network/http/interceptor/retry_interceptor.dart';
// import 'package:[pkg]/core/network/http/interceptor/auth_interceptor.dart';
import 'package:[pkg]/core/network/http/utils/network_constants.dart';

class [Server]ApiClient implements BaseClient {
  [Server]ApiClient({
    // AuthInterceptor? authInterceptor,
  }) {
    _dio = Dio(BaseOptions(
      baseUrl: NetworkConstants.[server]BaseUrl,
      connectTimeout: NetworkConstants.connectTimeout,
      receiveTimeout: NetworkConstants.receiveTimeout,
    ))..interceptors.addAll([
        LoggingInterceptor(),
        // RetryInterceptor(dio: _dio),
        // if (authInterceptor != null) authInterceptor,
        ErrorInterceptor(),
      ]);
  }

  late final Dio _dio;

  @override
  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) =>
      _dio.get(path, queryParameters: queryParameters, options: headers != null ? Options(headers: headers) : null);
  @override
  Future<Response<dynamic>> post(String path, {dynamic data}) => _dio.post(path, data: data);
  @override
  Future<Response<dynamic>> put(String path, {dynamic data}) => _dio.put(path, data: data);
  @override
  Future<Response<dynamic>> patch(String path, {dynamic data}) => _dio.patch(path, data: data);
  @override
  Future<Response<dynamic>> delete(String path, {Map<String, dynamic>? queryParameters}) =>
      _dio.delete(path, queryParameters: queryParameters);
}
```

---

### ApiService

```dart
// lib/core/network/http/service/api_service.dart
import 'package:dio/dio.dart';
import 'package:[pkg]/core/network/exception/network_exception.dart';
import 'package:[pkg]/core/network/http/client/base_client.dart';
import 'package:[pkg]/core/network/http/dto/api_response.dart';

class ApiService {
  const ApiService({required this.client});
  final BaseClient client;

  Future<ApiResponse<T>> get<T>(String path, T Function(Map<String, dynamic>) fromJson, {Map<String, dynamic>? queryParameters}) async {
    try {
      final res = await client.get(path, queryParameters: queryParameters);
      return ApiResponse.success(fromJson(res.data as Map<String, dynamic>));
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  // listKey: 서버가 { "items": [...] } 형태로 wrapping하는 경우 key 이름
  Future<ApiResponse<List<T>>> getList<T>(String path, T Function(Map<String, dynamic>) fromJson, {Map<String, dynamic>? queryParameters, String? listKey}) async {
    try {
      final res = await client.get(path, queryParameters: queryParameters);
      final raw = listKey != null
          ? (res.data as Map<String, dynamic>)[listKey] as List<dynamic>
          : res.data as List<dynamic>;
      return ApiResponse.success(raw.map((e) => fromJson(e as Map<String, dynamic>)).toList());
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<T>> post<T>(String path, T Function(Map<String, dynamic>) fromJson, {required Map<String, dynamic> body}) async {
    try {
      final res = await client.post(path, data: body);
      return ApiResponse.success(fromJson(res.data as Map<String, dynamic>));
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<void>> postVoid(String path, {Map<String, dynamic>? body}) async {
    try {
      await client.post(path, data: body);
      return const ApiResponse.success(null);
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<T>> put<T>(String path, T Function(Map<String, dynamic>) fromJson, {required Map<String, dynamic> body}) async {
    try {
      final res = await client.put(path, data: body);
      return ApiResponse.success(fromJson(res.data as Map<String, dynamic>));
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<void>> putVoid(String path, {Map<String, dynamic>? body}) async {
    try {
      await client.put(path, data: body);
      return const ApiResponse.success(null);
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<void>> delete(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      await client.delete(path, queryParameters: queryParameters);
      return const ApiResponse.success(null);
    } on DioException catch (e) {
      return ApiResponse.failure(_extractException(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  NetworkException _extractException(DioException e) =>
      e.error is NetworkException ? e.error as NetworkException : NetworkException.unknown(e.message ?? '');
}
```

---

### network_di.dart

인증 있으면 `storage_di.dart` Read 후 의존 추가.

```dart
// lib/app/di/network_di.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:[pkg]/core/network/http/client/[server]_api_client.dart';
import 'package:[pkg]/core/network/http/service/api_service.dart';
// import 'package:[pkg]/core/network/http/interceptor/auth_interceptor.dart';
// import 'package:[pkg]/app/di/storage_di.dart';
part 'network_di.g.dart';

@Riverpod(keepAlive: true)
ApiService [server]ApiService([Server]ApiServiceRef ref) {
  final client = [Server]ApiClient();
  // Bearer Token 인증 시:
  // final client = [Server]ApiClient(
  //   authInterceptor: AuthInterceptor(secureStorageService: ref.read(secureStorageServiceProvider)),
  // );
  return ApiService(client: client);
}
```

> `keepAlive: true` Provider → `ref.read` 사용. `ref.watch` 금지.

신규 파일이면 `di.dart`에 추가:
```dart
export 'network_di.dart';
```

---

### ExceptionMapper (없을 때만 생성)

`network_exception.dart`와 `app_exception.dart` Read 후 실제 케이스 맞춰 작성.

```dart
// lib/data/common/mapper/exception_mapper.dart
import 'package:[pkg]/core/network/exception/network_exception.dart';
import 'package:[pkg]/domain/common/exception/app_exception.dart';

class ExceptionMapper {
  const ExceptionMapper();

  AppException map(NetworkException exception) => exception.when(
    network: (msg) => AppException.network(msg),
    server: (code, msg) => AppException.server(code, msg),
    unauthorized: (msg) => AppException.unauthorized(msg),
    forbidden: (msg) => AppException.forbidden(msg),
    notFound: (msg) => AppException.notFound(msg),
    timeout: (msg) => AppException.timeout(msg),
    unknown: (msg) => AppException.unknown(msg),
  );
}
```

---

## 단계 5: build_runner

```bash
dart run build_runner build --delete-conflicting-outputs
```

확인 대상: `network_exception.freezed.dart`, `api_response.freezed.dart`, `network_di.g.dart`

---

## 단계 6: 검증

```bash
flutter analyze
```

체크리스트:
- `ApiResponse` / `NetworkException`이 Repository 외부로 노출 안 됨
- `[Server]ApiClient`가 `NetworkConstants.[server]BaseUrl` 참조
- `RetryInterceptor`가 `addAll`에서 `ErrorInterceptor` 앞에 위치
- `ExceptionMapper.when()` 케이스가 `NetworkException` 전체 커버
- `keepAlive: true` Provider에서 `ref.read` 사용

---

## 완료 후 안내

```
**인프라 설정 완료**
**서버:** [Server]ApiClient → NetworkConstants.[server]BaseUrl

생성된 파일:
- [경로] — [역할]

다음 단계:
- 도메인 연동 → `/add-remote-datasource`
```

---

## 금지 사항

- 승인 없이 파일 생성·수정
- `ApiService` / `BaseClient` / `[Server]ApiClient`를 Repository 외 레이어에서 직접 참조
- `ApiResponse` / `NetworkException`을 Repository 구현체 외부로 노출
- DataSource에서 `ApiResponse → AppResult` 변환
- `ExceptionMapper` 없이 `NetworkException` 직접 변환
- `maybeWhen()` 사용
- `keepAlive: true` Provider에서 `ref.watch`
- `RetryInterceptor`를 `ErrorInterceptor` 뒤에 배치
- 인증 토큰을 DI Provider 내부에 하드코딩
- 쿼리 파라미터를 RequestDTO로 감싸서 DataSource에 전달
