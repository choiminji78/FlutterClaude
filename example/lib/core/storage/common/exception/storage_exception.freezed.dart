// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StorageException {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) notFound,
    required TResult Function(String message) general,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? general,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? notFound,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StorageNotFound value) notFound,
    required TResult Function(StorageGeneral value) general,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StorageNotFound value)? notFound,
    TResult? Function(StorageGeneral value)? general,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StorageNotFound value)? notFound,
    TResult Function(StorageGeneral value)? general,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of StorageException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StorageExceptionCopyWith<StorageException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageExceptionCopyWith<$Res> {
  factory $StorageExceptionCopyWith(
    StorageException value,
    $Res Function(StorageException) then,
  ) = _$StorageExceptionCopyWithImpl<$Res, StorageException>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$StorageExceptionCopyWithImpl<$Res, $Val extends StorageException>
    implements $StorageExceptionCopyWith<$Res> {
  _$StorageExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StorageException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StorageNotFoundImplCopyWith<$Res>
    implements $StorageExceptionCopyWith<$Res> {
  factory _$$StorageNotFoundImplCopyWith(
    _$StorageNotFoundImpl value,
    $Res Function(_$StorageNotFoundImpl) then,
  ) = __$$StorageNotFoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$StorageNotFoundImplCopyWithImpl<$Res>
    extends _$StorageExceptionCopyWithImpl<$Res, _$StorageNotFoundImpl>
    implements _$$StorageNotFoundImplCopyWith<$Res> {
  __$$StorageNotFoundImplCopyWithImpl(
    _$StorageNotFoundImpl _value,
    $Res Function(_$StorageNotFoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StorageException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$StorageNotFoundImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$StorageNotFoundImpl implements StorageNotFound {
  const _$StorageNotFoundImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'StorageException.notFound(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageNotFoundImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of StorageException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageNotFoundImplCopyWith<_$StorageNotFoundImpl> get copyWith =>
      __$$StorageNotFoundImplCopyWithImpl<_$StorageNotFoundImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) notFound,
    required TResult Function(String message) general,
  }) {
    return notFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? general,
  }) {
    return notFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? notFound,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StorageNotFound value) notFound,
    required TResult Function(StorageGeneral value) general,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StorageNotFound value)? notFound,
    TResult? Function(StorageGeneral value)? general,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StorageNotFound value)? notFound,
    TResult Function(StorageGeneral value)? general,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class StorageNotFound implements StorageException {
  const factory StorageNotFound(final String message) = _$StorageNotFoundImpl;

  @override
  String get message;

  /// Create a copy of StorageException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageNotFoundImplCopyWith<_$StorageNotFoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StorageGeneralImplCopyWith<$Res>
    implements $StorageExceptionCopyWith<$Res> {
  factory _$$StorageGeneralImplCopyWith(
    _$StorageGeneralImpl value,
    $Res Function(_$StorageGeneralImpl) then,
  ) = __$$StorageGeneralImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$StorageGeneralImplCopyWithImpl<$Res>
    extends _$StorageExceptionCopyWithImpl<$Res, _$StorageGeneralImpl>
    implements _$$StorageGeneralImplCopyWith<$Res> {
  __$$StorageGeneralImplCopyWithImpl(
    _$StorageGeneralImpl _value,
    $Res Function(_$StorageGeneralImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StorageException
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$StorageGeneralImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$StorageGeneralImpl implements StorageGeneral {
  const _$StorageGeneralImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'StorageException.general(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageGeneralImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of StorageException
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageGeneralImplCopyWith<_$StorageGeneralImpl> get copyWith =>
      __$$StorageGeneralImplCopyWithImpl<_$StorageGeneralImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) notFound,
    required TResult Function(String message) general,
  }) {
    return general(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? general,
  }) {
    return general?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? notFound,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (general != null) {
      return general(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StorageNotFound value) notFound,
    required TResult Function(StorageGeneral value) general,
  }) {
    return general(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StorageNotFound value)? notFound,
    TResult? Function(StorageGeneral value)? general,
  }) {
    return general?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StorageNotFound value)? notFound,
    TResult Function(StorageGeneral value)? general,
    required TResult orElse(),
  }) {
    if (general != null) {
      return general(this);
    }
    return orElse();
  }
}

abstract class StorageGeneral implements StorageException {
  const factory StorageGeneral(final String message) = _$StorageGeneralImpl;

  @override
  String get message;

  /// Create a copy of StorageException
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageGeneralImplCopyWith<_$StorageGeneralImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
