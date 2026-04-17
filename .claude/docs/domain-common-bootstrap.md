## 단계 0: domain/common 사전 확인

Glob으로 아래 두 파일의 존재 여부를 확인한다.

```
lib/domain/common/entity/app_result.dart
lib/domain/common/exception/app_exception.dart
```

| 상태 | 대응 |
|---|---|
| 두 파일 모두 존재 | 단계 1로 이동 |
| 하나라도 없음 | 아래 템플릿으로 자동 생성한 뒤 build_runner를 먼저 실행한다. |

### lib/domain/common/exception/app_exception.dart

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
sealed class AppException with _$AppException {
  const factory AppException.notFound(String message) = AppNotFound;
  const factory AppException.unknown(String message) = AppUnknown;
}
```

### lib/domain/common/entity/app_result.dart

```dart
import 'package:flutter_claude/domain/common/exception/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_result.freezed.dart';

@freezed
sealed class AppResult<T> with _$AppResult<T> {
  const factory AppResult.success(T data) = AppSuccess<T>;
  const factory AppResult.failure(AppException exception) = AppFailure<T>;
}
```

> 신규 생성 시 build_runner를 먼저 실행한다.
> ```bash
> dart run build_runner build --delete-conflicting-outputs
> ```
