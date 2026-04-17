import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_toast.freezed.dart';

enum AppToastType { info, error, success }

@freezed
class AppToast with _$AppToast {
  const factory AppToast({
    required String message,
    @Default(AppToastType.info) AppToastType type,
  }) = _AppToast;
}
