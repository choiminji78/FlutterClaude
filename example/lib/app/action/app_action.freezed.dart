// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() initializedSucceeded,
    required TResult Function(String message, AppToastType type) showToast,
    required TResult Function() toastDismissed,
    required TResult Function(ThemeMode mode) themeModeChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function()? initializedSucceeded,
    TResult? Function(String message, AppToastType type)? showToast,
    TResult? Function()? toastDismissed,
    TResult? Function(ThemeMode mode)? themeModeChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? initializedSucceeded,
    TResult Function(String message, AppToastType type)? showToast,
    TResult Function()? toastDismissed,
    TResult Function(ThemeMode mode)? themeModeChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppInitialized value) initialized,
    required TResult Function(AppInitializedSucceeded value)
    initializedSucceeded,
    required TResult Function(AppShowToast value) showToast,
    required TResult Function(AppToastDismissed value) toastDismissed,
    required TResult Function(AppThemeModeChanged value) themeModeChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppInitialized value)? initialized,
    TResult? Function(AppInitializedSucceeded value)? initializedSucceeded,
    TResult? Function(AppShowToast value)? showToast,
    TResult? Function(AppToastDismissed value)? toastDismissed,
    TResult? Function(AppThemeModeChanged value)? themeModeChanged,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppInitialized value)? initialized,
    TResult Function(AppInitializedSucceeded value)? initializedSucceeded,
    TResult Function(AppShowToast value)? showToast,
    TResult Function(AppToastDismissed value)? toastDismissed,
    TResult Function(AppThemeModeChanged value)? themeModeChanged,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppActionCopyWith<$Res> {
  factory $AppActionCopyWith(AppAction value, $Res Function(AppAction) then) =
      _$AppActionCopyWithImpl<$Res, AppAction>;
}

/// @nodoc
class _$AppActionCopyWithImpl<$Res, $Val extends AppAction>
    implements $AppActionCopyWith<$Res> {
  _$AppActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AppInitializedImplCopyWith<$Res> {
  factory _$$AppInitializedImplCopyWith(
    _$AppInitializedImpl value,
    $Res Function(_$AppInitializedImpl) then,
  ) = __$$AppInitializedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppInitializedImplCopyWithImpl<$Res>
    extends _$AppActionCopyWithImpl<$Res, _$AppInitializedImpl>
    implements _$$AppInitializedImplCopyWith<$Res> {
  __$$AppInitializedImplCopyWithImpl(
    _$AppInitializedImpl _value,
    $Res Function(_$AppInitializedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AppInitializedImpl implements AppInitialized {
  const _$AppInitializedImpl();

  @override
  String toString() {
    return 'AppAction.initialized()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppInitializedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() initializedSucceeded,
    required TResult Function(String message, AppToastType type) showToast,
    required TResult Function() toastDismissed,
    required TResult Function(ThemeMode mode) themeModeChanged,
  }) {
    return initialized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function()? initializedSucceeded,
    TResult? Function(String message, AppToastType type)? showToast,
    TResult? Function()? toastDismissed,
    TResult? Function(ThemeMode mode)? themeModeChanged,
  }) {
    return initialized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? initializedSucceeded,
    TResult Function(String message, AppToastType type)? showToast,
    TResult Function()? toastDismissed,
    TResult Function(ThemeMode mode)? themeModeChanged,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppInitialized value) initialized,
    required TResult Function(AppInitializedSucceeded value)
    initializedSucceeded,
    required TResult Function(AppShowToast value) showToast,
    required TResult Function(AppToastDismissed value) toastDismissed,
    required TResult Function(AppThemeModeChanged value) themeModeChanged,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppInitialized value)? initialized,
    TResult? Function(AppInitializedSucceeded value)? initializedSucceeded,
    TResult? Function(AppShowToast value)? showToast,
    TResult? Function(AppToastDismissed value)? toastDismissed,
    TResult? Function(AppThemeModeChanged value)? themeModeChanged,
  }) {
    return initialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppInitialized value)? initialized,
    TResult Function(AppInitializedSucceeded value)? initializedSucceeded,
    TResult Function(AppShowToast value)? showToast,
    TResult Function(AppToastDismissed value)? toastDismissed,
    TResult Function(AppThemeModeChanged value)? themeModeChanged,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class AppInitialized implements AppAction {
  const factory AppInitialized() = _$AppInitializedImpl;
}

/// @nodoc
abstract class _$$AppInitializedSucceededImplCopyWith<$Res> {
  factory _$$AppInitializedSucceededImplCopyWith(
    _$AppInitializedSucceededImpl value,
    $Res Function(_$AppInitializedSucceededImpl) then,
  ) = __$$AppInitializedSucceededImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppInitializedSucceededImplCopyWithImpl<$Res>
    extends _$AppActionCopyWithImpl<$Res, _$AppInitializedSucceededImpl>
    implements _$$AppInitializedSucceededImplCopyWith<$Res> {
  __$$AppInitializedSucceededImplCopyWithImpl(
    _$AppInitializedSucceededImpl _value,
    $Res Function(_$AppInitializedSucceededImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AppInitializedSucceededImpl implements AppInitializedSucceeded {
  const _$AppInitializedSucceededImpl();

  @override
  String toString() {
    return 'AppAction.initializedSucceeded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppInitializedSucceededImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() initializedSucceeded,
    required TResult Function(String message, AppToastType type) showToast,
    required TResult Function() toastDismissed,
    required TResult Function(ThemeMode mode) themeModeChanged,
  }) {
    return initializedSucceeded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function()? initializedSucceeded,
    TResult? Function(String message, AppToastType type)? showToast,
    TResult? Function()? toastDismissed,
    TResult? Function(ThemeMode mode)? themeModeChanged,
  }) {
    return initializedSucceeded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? initializedSucceeded,
    TResult Function(String message, AppToastType type)? showToast,
    TResult Function()? toastDismissed,
    TResult Function(ThemeMode mode)? themeModeChanged,
    required TResult orElse(),
  }) {
    if (initializedSucceeded != null) {
      return initializedSucceeded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppInitialized value) initialized,
    required TResult Function(AppInitializedSucceeded value)
    initializedSucceeded,
    required TResult Function(AppShowToast value) showToast,
    required TResult Function(AppToastDismissed value) toastDismissed,
    required TResult Function(AppThemeModeChanged value) themeModeChanged,
  }) {
    return initializedSucceeded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppInitialized value)? initialized,
    TResult? Function(AppInitializedSucceeded value)? initializedSucceeded,
    TResult? Function(AppShowToast value)? showToast,
    TResult? Function(AppToastDismissed value)? toastDismissed,
    TResult? Function(AppThemeModeChanged value)? themeModeChanged,
  }) {
    return initializedSucceeded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppInitialized value)? initialized,
    TResult Function(AppInitializedSucceeded value)? initializedSucceeded,
    TResult Function(AppShowToast value)? showToast,
    TResult Function(AppToastDismissed value)? toastDismissed,
    TResult Function(AppThemeModeChanged value)? themeModeChanged,
    required TResult orElse(),
  }) {
    if (initializedSucceeded != null) {
      return initializedSucceeded(this);
    }
    return orElse();
  }
}

abstract class AppInitializedSucceeded implements AppAction {
  const factory AppInitializedSucceeded() = _$AppInitializedSucceededImpl;
}

/// @nodoc
abstract class _$$AppShowToastImplCopyWith<$Res> {
  factory _$$AppShowToastImplCopyWith(
    _$AppShowToastImpl value,
    $Res Function(_$AppShowToastImpl) then,
  ) = __$$AppShowToastImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, AppToastType type});
}

/// @nodoc
class __$$AppShowToastImplCopyWithImpl<$Res>
    extends _$AppActionCopyWithImpl<$Res, _$AppShowToastImpl>
    implements _$$AppShowToastImplCopyWith<$Res> {
  __$$AppShowToastImplCopyWithImpl(
    _$AppShowToastImpl _value,
    $Res Function(_$AppShowToastImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? type = null}) {
    return _then(
      _$AppShowToastImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as AppToastType,
      ),
    );
  }
}

/// @nodoc

class _$AppShowToastImpl implements AppShowToast {
  const _$AppShowToastImpl(this.message, this.type);

  @override
  final String message;
  @override
  final AppToastType type;

  @override
  String toString() {
    return 'AppAction.showToast(message: $message, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppShowToastImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, type);

  /// Create a copy of AppAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppShowToastImplCopyWith<_$AppShowToastImpl> get copyWith =>
      __$$AppShowToastImplCopyWithImpl<_$AppShowToastImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() initializedSucceeded,
    required TResult Function(String message, AppToastType type) showToast,
    required TResult Function() toastDismissed,
    required TResult Function(ThemeMode mode) themeModeChanged,
  }) {
    return showToast(message, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function()? initializedSucceeded,
    TResult? Function(String message, AppToastType type)? showToast,
    TResult? Function()? toastDismissed,
    TResult? Function(ThemeMode mode)? themeModeChanged,
  }) {
    return showToast?.call(message, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? initializedSucceeded,
    TResult Function(String message, AppToastType type)? showToast,
    TResult Function()? toastDismissed,
    TResult Function(ThemeMode mode)? themeModeChanged,
    required TResult orElse(),
  }) {
    if (showToast != null) {
      return showToast(message, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppInitialized value) initialized,
    required TResult Function(AppInitializedSucceeded value)
    initializedSucceeded,
    required TResult Function(AppShowToast value) showToast,
    required TResult Function(AppToastDismissed value) toastDismissed,
    required TResult Function(AppThemeModeChanged value) themeModeChanged,
  }) {
    return showToast(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppInitialized value)? initialized,
    TResult? Function(AppInitializedSucceeded value)? initializedSucceeded,
    TResult? Function(AppShowToast value)? showToast,
    TResult? Function(AppToastDismissed value)? toastDismissed,
    TResult? Function(AppThemeModeChanged value)? themeModeChanged,
  }) {
    return showToast?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppInitialized value)? initialized,
    TResult Function(AppInitializedSucceeded value)? initializedSucceeded,
    TResult Function(AppShowToast value)? showToast,
    TResult Function(AppToastDismissed value)? toastDismissed,
    TResult Function(AppThemeModeChanged value)? themeModeChanged,
    required TResult orElse(),
  }) {
    if (showToast != null) {
      return showToast(this);
    }
    return orElse();
  }
}

abstract class AppShowToast implements AppAction {
  const factory AppShowToast(final String message, final AppToastType type) =
      _$AppShowToastImpl;

  String get message;
  AppToastType get type;

  /// Create a copy of AppAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppShowToastImplCopyWith<_$AppShowToastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppToastDismissedImplCopyWith<$Res> {
  factory _$$AppToastDismissedImplCopyWith(
    _$AppToastDismissedImpl value,
    $Res Function(_$AppToastDismissedImpl) then,
  ) = __$$AppToastDismissedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppToastDismissedImplCopyWithImpl<$Res>
    extends _$AppActionCopyWithImpl<$Res, _$AppToastDismissedImpl>
    implements _$$AppToastDismissedImplCopyWith<$Res> {
  __$$AppToastDismissedImplCopyWithImpl(
    _$AppToastDismissedImpl _value,
    $Res Function(_$AppToastDismissedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AppToastDismissedImpl implements AppToastDismissed {
  const _$AppToastDismissedImpl();

  @override
  String toString() {
    return 'AppAction.toastDismissed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppToastDismissedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() initializedSucceeded,
    required TResult Function(String message, AppToastType type) showToast,
    required TResult Function() toastDismissed,
    required TResult Function(ThemeMode mode) themeModeChanged,
  }) {
    return toastDismissed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function()? initializedSucceeded,
    TResult? Function(String message, AppToastType type)? showToast,
    TResult? Function()? toastDismissed,
    TResult? Function(ThemeMode mode)? themeModeChanged,
  }) {
    return toastDismissed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? initializedSucceeded,
    TResult Function(String message, AppToastType type)? showToast,
    TResult Function()? toastDismissed,
    TResult Function(ThemeMode mode)? themeModeChanged,
    required TResult orElse(),
  }) {
    if (toastDismissed != null) {
      return toastDismissed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppInitialized value) initialized,
    required TResult Function(AppInitializedSucceeded value)
    initializedSucceeded,
    required TResult Function(AppShowToast value) showToast,
    required TResult Function(AppToastDismissed value) toastDismissed,
    required TResult Function(AppThemeModeChanged value) themeModeChanged,
  }) {
    return toastDismissed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppInitialized value)? initialized,
    TResult? Function(AppInitializedSucceeded value)? initializedSucceeded,
    TResult? Function(AppShowToast value)? showToast,
    TResult? Function(AppToastDismissed value)? toastDismissed,
    TResult? Function(AppThemeModeChanged value)? themeModeChanged,
  }) {
    return toastDismissed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppInitialized value)? initialized,
    TResult Function(AppInitializedSucceeded value)? initializedSucceeded,
    TResult Function(AppShowToast value)? showToast,
    TResult Function(AppToastDismissed value)? toastDismissed,
    TResult Function(AppThemeModeChanged value)? themeModeChanged,
    required TResult orElse(),
  }) {
    if (toastDismissed != null) {
      return toastDismissed(this);
    }
    return orElse();
  }
}

abstract class AppToastDismissed implements AppAction {
  const factory AppToastDismissed() = _$AppToastDismissedImpl;
}

/// @nodoc
abstract class _$$AppThemeModeChangedImplCopyWith<$Res> {
  factory _$$AppThemeModeChangedImplCopyWith(
    _$AppThemeModeChangedImpl value,
    $Res Function(_$AppThemeModeChangedImpl) then,
  ) = __$$AppThemeModeChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ThemeMode mode});
}

/// @nodoc
class __$$AppThemeModeChangedImplCopyWithImpl<$Res>
    extends _$AppActionCopyWithImpl<$Res, _$AppThemeModeChangedImpl>
    implements _$$AppThemeModeChangedImplCopyWith<$Res> {
  __$$AppThemeModeChangedImplCopyWithImpl(
    _$AppThemeModeChangedImpl _value,
    $Res Function(_$AppThemeModeChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? mode = null}) {
    return _then(
      _$AppThemeModeChangedImpl(
        null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as ThemeMode,
      ),
    );
  }
}

/// @nodoc

class _$AppThemeModeChangedImpl implements AppThemeModeChanged {
  const _$AppThemeModeChangedImpl(this.mode);

  @override
  final ThemeMode mode;

  @override
  String toString() {
    return 'AppAction.themeModeChanged(mode: $mode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppThemeModeChangedImpl &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mode);

  /// Create a copy of AppAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppThemeModeChangedImplCopyWith<_$AppThemeModeChangedImpl> get copyWith =>
      __$$AppThemeModeChangedImplCopyWithImpl<_$AppThemeModeChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() initializedSucceeded,
    required TResult Function(String message, AppToastType type) showToast,
    required TResult Function() toastDismissed,
    required TResult Function(ThemeMode mode) themeModeChanged,
  }) {
    return themeModeChanged(mode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function()? initializedSucceeded,
    TResult? Function(String message, AppToastType type)? showToast,
    TResult? Function()? toastDismissed,
    TResult? Function(ThemeMode mode)? themeModeChanged,
  }) {
    return themeModeChanged?.call(mode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? initializedSucceeded,
    TResult Function(String message, AppToastType type)? showToast,
    TResult Function()? toastDismissed,
    TResult Function(ThemeMode mode)? themeModeChanged,
    required TResult orElse(),
  }) {
    if (themeModeChanged != null) {
      return themeModeChanged(mode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppInitialized value) initialized,
    required TResult Function(AppInitializedSucceeded value)
    initializedSucceeded,
    required TResult Function(AppShowToast value) showToast,
    required TResult Function(AppToastDismissed value) toastDismissed,
    required TResult Function(AppThemeModeChanged value) themeModeChanged,
  }) {
    return themeModeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppInitialized value)? initialized,
    TResult? Function(AppInitializedSucceeded value)? initializedSucceeded,
    TResult? Function(AppShowToast value)? showToast,
    TResult? Function(AppToastDismissed value)? toastDismissed,
    TResult? Function(AppThemeModeChanged value)? themeModeChanged,
  }) {
    return themeModeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppInitialized value)? initialized,
    TResult Function(AppInitializedSucceeded value)? initializedSucceeded,
    TResult Function(AppShowToast value)? showToast,
    TResult Function(AppToastDismissed value)? toastDismissed,
    TResult Function(AppThemeModeChanged value)? themeModeChanged,
    required TResult orElse(),
  }) {
    if (themeModeChanged != null) {
      return themeModeChanged(this);
    }
    return orElse();
  }
}

abstract class AppThemeModeChanged implements AppAction {
  const factory AppThemeModeChanged(final ThemeMode mode) =
      _$AppThemeModeChangedImpl;

  ThemeMode get mode;

  /// Create a copy of AppAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppThemeModeChangedImplCopyWith<_$AppThemeModeChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
