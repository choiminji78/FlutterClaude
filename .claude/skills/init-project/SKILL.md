---
name: init-project
description: 새 Flutter 프로젝트에 5-레이어 아키텍처 뼈대(core, domain/common, data/common, app, main.dart)를 생성한다. "프로젝트 초기화", "프로젝트 뼈대 생성", "아키텍처 초기화", "init-project" 등의 요청 시 사용.
argument-hint: ""
---

# Init Project

새 Flutter 프로젝트에 5-레이어 아키텍처 뼈대를 생성한다.

---

## 단계 0: 중복 확인

`lib/core/viewmodel/base_view_model.dart` Glob 확인.
존재 시 "이미 초기화된 프로젝트입니다. 덮어쓸까요?" 확인 후 진행.

## 단계 1: Flutter 프로젝트 생성 (pubspec.yaml 없을 때만)

`pubspec.yaml` Glob 확인. 없으면 한 번에 질문:

1. **org** — 역도메인 (예: `net.huray`)
2. **project name** — snake_case (예: `nest_flutter`)
3. **앱 표시명** — `[AppTitle]` 치환
4. **플랫폼** — 기본 `android,ios`

```bash
flutter create . --org [org] --project-name [project_name] --platforms [platforms]
```

생성 후 앱 표시명 반영:
- `android/app/src/main/AndroidManifest.xml` → `android:label="[AppTitle]"`
- `ios/Runner/Info.plist` → `CFBundleDisplayName` 값을 `[AppTitle]`로 교체

## 단계 2: 정보 수집

`pubspec.yaml` Read → `name:` 추출 → `[pkg]` 치환.
수집 안 된 항목만 질문:
1. **앱 이름** — `MaterialApp.router`의 `title` (`[AppTitle]` 치환)
2. **네트워크 레이어 포함 여부** — 포함 시 base URL도 수집 (`[base_url]` 치환)

## 단계 3: 코드 생성

`[pkg]` → 패키지명, `[AppTitle]` → 앱 이름, `[base_url]` → API URL 치환하여 아래 파일을 생성. 네트워크 관련 파일은 포함 시에만 생성.

### core/viewmodel/base_view_model.dart

```dart
import 'dart:async';
import 'dart:collection';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin BaseViewModel<S, A> on AutoDisposeNotifier<S> {
  final Queue<A> _queue = Queue<A>();
  bool _isProcessing = false;

  @override
  S build() => buildInitialState();
  S buildInitialState();
  S reduce(S state, A action);
  Future<void> handleEffect(A action) async {}

  void dispatch(A action) {
    _queue.add(action);
    unawaited(_drain());
  }

  Future<void> _drain() async {
    if (_isProcessing) return;
    _isProcessing = true;
    while (_queue.isNotEmpty) {
      final action = _queue.removeFirst();
      state = reduce(state, action);
      try {
        await handleEffect(action);
      } catch (_) {}
    }
    _isProcessing = false;
  }
}
```

### core/viewmodel/base_keep_alive_view_model.dart

`base_view_model.dart`와 동일. 변경점:
- `mixin BaseKeepAliveViewModel<S, A> on Notifier<S>`

### core/storage/common/dto/storage_response.dart

```dart
import 'package:[pkg]/core/storage/common/exception/storage_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_response.freezed.dart';

@freezed
sealed class StorageResponse<T> with _$StorageResponse<T> {
  const factory StorageResponse.success(T data) = StorageSuccess<T>;
  const factory StorageResponse.failure(StorageException exception) = StorageFailure<T>;
}
```

### core/storage/common/exception/storage_exception.dart

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_exception.freezed.dart';

@freezed
sealed class StorageException with _$StorageException {
  const factory StorageException.notFound(String message) = StorageNotFound;
  const factory StorageException.general(String message) = StorageGeneral;
}
```

### core/storage/preferences/preferences_service.dart

```dart
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  const PreferencesService(this._prefs);
  final SharedPreferences _prefs;

  String? getString(String key) => _prefs.getString(key);
  Future<void> setString(String key, String value) => _prefs.setString(key, value);
  bool? getBool(String key) => _prefs.getBool(key);
  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);
  int? getInt(String key) => _prefs.getInt(key);
  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);
  double? getDouble(String key) => _prefs.getDouble(key);
  Future<void> setDouble(String key, double value) => _prefs.setDouble(key, value);
  Future<void> remove(String key) => _prefs.remove(key);
}
```

### core/storage/secure_storage/secure_storage_service.dart

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService() : _storage = const FlutterSecureStorage();
  final FlutterSecureStorage _storage;

  Future<String?> read({required String key}) => _storage.read(key: key);
  Future<void> write({required String key, required String value}) => _storage.write(key: key, value: value);
  Future<void> delete({required String key}) => _storage.delete(key: key);
}
```

### core/network/dto/api_response.dart (네트워크 포함 시)

```dart
import 'package:[pkg]/core/network/exception/network_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success(T data) = ApiSuccess<T>;
  const factory ApiResponse.failure(NetworkException exception) = ApiFailure<T>;
}
```

### core/network/exception/network_exception.dart (네트워크 포함 시)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception.freezed.dart';

@freezed
sealed class NetworkException with _$NetworkException {
  const factory NetworkException.unauthorized(String message) = NetworkUnauthorized;
  const factory NetworkException.notFound(String message) = NetworkNotFound;
  const factory NetworkException.serverError(String message) = NetworkServerError;
  const factory NetworkException.noConnection(String message) = NetworkNoConnection;
  const factory NetworkException.unknown(String message) = NetworkUnknown;
}
```

### core/network/service/api_service.dart (네트워크 포함 시)

```dart
import 'package:[pkg]/core/network/dto/api_response.dart';
import 'package:[pkg]/core/network/exception/network_exception.dart';
import 'package:dio/dio.dart';

class ApiService {
  const ApiService(this._dio);
  final Dio _dio;

  Future<ApiResponse<T>> get<T>(String path, T Function(dynamic) fromJson) async {
    try {
      final res = await _dio.get<dynamic>(path);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(_map(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<T>> post<T>(String path, T Function(dynamic) fromJson, {dynamic data}) async {
    try {
      final res = await _dio.post<dynamic>(path, data: data);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(_map(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<T>> put<T>(String path, T Function(dynamic) fromJson, {dynamic data}) async {
    try {
      final res = await _dio.put<dynamic>(path, data: data);
      return ApiResponse.success(fromJson(res.data));
    } on DioException catch (e) {
      return ApiResponse.failure(_map(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  Future<ApiResponse<void>> delete(String path) async {
    try {
      await _dio.delete<dynamic>(path);
      return const ApiResponse.success(null);
    } on DioException catch (e) {
      return ApiResponse.failure(_map(e));
    } catch (e) {
      return ApiResponse.failure(NetworkException.unknown(e.toString()));
    }
  }

  NetworkException _map(DioException e) {
    final statusCode = e.response?.statusCode;
    if (statusCode == 401) return NetworkException.unauthorized(e.message ?? 'Unauthorized');
    if (statusCode == 404) return NetworkException.notFound(e.message ?? 'Not found');
    if (statusCode != null && statusCode >= 500) return NetworkException.serverError(e.message ?? 'Server error');
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return NetworkException.noConnection(e.message ?? 'No connection');
    }
    return NetworkException.unknown(e.message ?? 'Unknown error');
  }
}
```

### domain/common/entity/app_result.dart

```dart
import 'package:[pkg]/domain/common/exception/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_result.freezed.dart';

@freezed
sealed class AppResult<T> with _$AppResult<T> {
  const factory AppResult.success(T data) = AppSuccess<T>;
  const factory AppResult.failure(AppException exception) = AppFailure<T>;
}
```

### domain/common/exception/app_exception.dart

네트워크 제외 시 `notFound` + `unknown`만. 네트워크 포함 시 전체.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
sealed class AppException with _$AppException {
  const factory AppException.notFound(String message) = AppNotFound;
  const factory AppException.unauthorized(String message) = AppUnauthorized;   // 네트워크 포함 시
  const factory AppException.serverError(String message) = AppServerError;     // 네트워크 포함 시
  const factory AppException.noConnection(String message) = AppNoConnection;   // 네트워크 포함 시
  const factory AppException.unknown(String message) = AppUnknown;
}
```

### data/common/mapper/storage_exception_mapper.dart

```dart
import 'package:[pkg]/core/storage/common/exception/storage_exception.dart';
import 'package:[pkg]/domain/common/exception/app_exception.dart';

class StorageExceptionMapper {
  const StorageExceptionMapper();

  AppException map(StorageException exception) {
    return exception.when(
      notFound: (msg) => AppException.notFound(msg),
      general: (msg) => AppException.unknown(msg),
    );
  }
}
```

### data/common/mapper/network_exception_mapper.dart (네트워크 포함 시)

```dart
import 'package:[pkg]/core/network/exception/network_exception.dart';
import 'package:[pkg]/domain/common/exception/app_exception.dart';

class NetworkExceptionMapper {
  const NetworkExceptionMapper();

  AppException map(NetworkException exception) {
    return exception.when(
      unauthorized: (msg) => AppException.unauthorized(msg),
      notFound: (msg) => AppException.notFound(msg),
      serverError: (msg) => AppException.serverError(msg),
      noConnection: (msg) => AppException.noConnection(msg),
      unknown: (msg) => AppException.unknown(msg),
    );
  }
}
```

### app/di/storage_di.dart

```dart
import 'package:[pkg]/core/storage/preferences/preferences_service.dart';
import 'package:[pkg]/core/storage/secure_storage/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage_di.g.dart';

@Riverpod(keepAlive: true)
Future<PreferencesService> preferencesService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return PreferencesService(prefs);
}

@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(Ref ref) => SecureStorageService();
```

### app/di/network_di.dart (네트워크 포함 시)

```dart
import 'package:[pkg]/core/network/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_di.g.dart';

@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) {
  final dio = Dio(BaseOptions(
    baseUrl: '[base_url]',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  return ApiService(dio);
}
```

### app/di/di.dart

```dart
export 'storage_di.dart';
// 네트워크 포함 시: export 'network_di.dart';
```

### app/state/app_state.dart

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(false) bool isInitialized,
  }) = _AppState;
}
```

### app/action/app_action.dart

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_action.freezed.dart';

@freezed
sealed class AppAction with _$AppAction {
  const factory AppAction.initialized() = AppInitialized;
  const factory AppAction.initializedSucceeded() = AppInitializedSucceeded;
}
```

### app/reducer/app_reducer.dart

```dart
import 'package:[pkg]/app/action/app_action.dart';
import 'package:[pkg]/app/state/app_state.dart';

AppState appReducer(AppState state, AppAction action) {
  return action.when(
    initialized: () => state,
    initializedSucceeded: () => state.copyWith(isInitialized: true),
  );
}
```

### app/effect/app_effect.dart

```dart
import 'package:[pkg]/app/action/app_action.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppEffect {
  AppEffect(this._ref, this._dispatch);

  // ignore: unused_field
  final Ref _ref;
  final void Function(AppAction) _dispatch;

  Future<void> handleEffect(AppAction action) async {
    await action.when(
      initialized: () => _initialize(),
      initializedSucceeded: () => null,
    );
  }

  Future<void> _initialize() async {
    _dispatch(const AppAction.initializedSucceeded());
  }
}
```

### app/viewmodel/app_view_model.dart

```dart
import 'package:[pkg]/app/action/app_action.dart';
import 'package:[pkg]/app/effect/app_effect.dart';
import 'package:[pkg]/app/reducer/app_reducer.dart';
import 'package:[pkg]/app/router/app_router.dart';
import 'package:[pkg]/app/state/app_state.dart';
import 'package:[pkg]/core/viewmodel/base_keep_alive_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_view_model.g.dart';

@Riverpod(keepAlive: true)
class AppViewModel extends _$AppViewModel
    with BaseKeepAliveViewModel<AppState, AppAction> {
  late final _effect = AppEffect(ref, dispatch);

  @override
  AppState build() => buildInitialState();

  @override
  AppState buildInitialState() => const AppState();

  @override
  AppState reduce(AppState state, AppAction action) => appReducer(state, action);

  @override
  Future<void> handleEffect(AppAction action) => _effect.handleEffect(action);

  void go(String path) => ref.read(appRouterProvider).go(path);
  void push(String path) => ref.read(appRouterProvider).push(path);
  void pop() => ref.read(appRouterProvider).pop();
}
```

### app/router/app_router.dart

```dart
import 'package:[pkg]/app/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(routes: AppRoutes.routes, initialLocation: AppRoutes.home);
}
```

### app/router/app_routes.dart

`/add-feature` 스킬 실행 시 GoRoute가 추가된다.

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const home = '/';

  static final routes = <RouteBase>[
    GoRoute(
      path: home,
      builder: (context, state) => const Placeholder(),
    ),
  ];
}
```

### app/view/app.dart

```dart
import 'package:[pkg]/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: '[AppTitle]',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
```

### main.dart

```dart
import 'package:[pkg]/app/view/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}
```

### test/widget_test.dart

flutter create 기본 파일이 `MyApp`을 참조하므로 교체한다.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:[pkg]/app/view/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    expect(find.byType(App), findsOneWidget);
  });
}
```

---

## 단계 4: 빌드 & 검증

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
```
