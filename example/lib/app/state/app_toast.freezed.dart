// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_toast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppToast {
  String get message => throw _privateConstructorUsedError;
  AppToastType get type => throw _privateConstructorUsedError;

  /// Create a copy of AppToast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppToastCopyWith<AppToast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppToastCopyWith<$Res> {
  factory $AppToastCopyWith(AppToast value, $Res Function(AppToast) then) =
      _$AppToastCopyWithImpl<$Res, AppToast>;
  @useResult
  $Res call({String message, AppToastType type});
}

/// @nodoc
class _$AppToastCopyWithImpl<$Res, $Val extends AppToast>
    implements $AppToastCopyWith<$Res> {
  _$AppToastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppToast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? type = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as AppToastType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppToastImplCopyWith<$Res>
    implements $AppToastCopyWith<$Res> {
  factory _$$AppToastImplCopyWith(
    _$AppToastImpl value,
    $Res Function(_$AppToastImpl) then,
  ) = __$$AppToastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, AppToastType type});
}

/// @nodoc
class __$$AppToastImplCopyWithImpl<$Res>
    extends _$AppToastCopyWithImpl<$Res, _$AppToastImpl>
    implements _$$AppToastImplCopyWith<$Res> {
  __$$AppToastImplCopyWithImpl(
    _$AppToastImpl _value,
    $Res Function(_$AppToastImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppToast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? type = null}) {
    return _then(
      _$AppToastImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as AppToastType,
      ),
    );
  }
}

/// @nodoc

class _$AppToastImpl implements _AppToast {
  const _$AppToastImpl({required this.message, this.type = AppToastType.info});

  @override
  final String message;
  @override
  @JsonKey()
  final AppToastType type;

  @override
  String toString() {
    return 'AppToast(message: $message, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppToastImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, type);

  /// Create a copy of AppToast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppToastImplCopyWith<_$AppToastImpl> get copyWith =>
      __$$AppToastImplCopyWithImpl<_$AppToastImpl>(this, _$identity);
}

abstract class _AppToast implements AppToast {
  const factory _AppToast({
    required final String message,
    final AppToastType type,
  }) = _$AppToastImpl;

  @override
  String get message;
  @override
  AppToastType get type;

  /// Create a copy of AppToast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppToastImplCopyWith<_$AppToastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
