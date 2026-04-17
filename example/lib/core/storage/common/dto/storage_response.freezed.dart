// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StorageResponse<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(StorageException exception) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(StorageException exception)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(StorageException exception)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StorageSuccess<T> value) success,
    required TResult Function(StorageFailure<T> value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StorageSuccess<T> value)? success,
    TResult? Function(StorageFailure<T> value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StorageSuccess<T> value)? success,
    TResult Function(StorageFailure<T> value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageResponseCopyWith<T, $Res> {
  factory $StorageResponseCopyWith(
    StorageResponse<T> value,
    $Res Function(StorageResponse<T>) then,
  ) = _$StorageResponseCopyWithImpl<T, $Res, StorageResponse<T>>;
}

/// @nodoc
class _$StorageResponseCopyWithImpl<T, $Res, $Val extends StorageResponse<T>>
    implements $StorageResponseCopyWith<T, $Res> {
  _$StorageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StorageResponse
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StorageSuccessImplCopyWith<T, $Res> {
  factory _$$StorageSuccessImplCopyWith(
    _$StorageSuccessImpl<T> value,
    $Res Function(_$StorageSuccessImpl<T>) then,
  ) = __$$StorageSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$StorageSuccessImplCopyWithImpl<T, $Res>
    extends _$StorageResponseCopyWithImpl<T, $Res, _$StorageSuccessImpl<T>>
    implements _$$StorageSuccessImplCopyWith<T, $Res> {
  __$$StorageSuccessImplCopyWithImpl(
    _$StorageSuccessImpl<T> _value,
    $Res Function(_$StorageSuccessImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of StorageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = freezed}) {
    return _then(
      _$StorageSuccessImpl<T>(
        freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T,
      ),
    );
  }
}

/// @nodoc

class _$StorageSuccessImpl<T> implements StorageSuccess<T> {
  const _$StorageSuccessImpl(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'StorageResponse<$T>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageSuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of StorageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageSuccessImplCopyWith<T, _$StorageSuccessImpl<T>> get copyWith =>
      __$$StorageSuccessImplCopyWithImpl<T, _$StorageSuccessImpl<T>>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(StorageException exception) failure,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(StorageException exception)? failure,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(StorageException exception)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StorageSuccess<T> value) success,
    required TResult Function(StorageFailure<T> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StorageSuccess<T> value)? success,
    TResult? Function(StorageFailure<T> value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StorageSuccess<T> value)? success,
    TResult Function(StorageFailure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class StorageSuccess<T> implements StorageResponse<T> {
  const factory StorageSuccess(final T data) = _$StorageSuccessImpl<T>;

  T get data;

  /// Create a copy of StorageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageSuccessImplCopyWith<T, _$StorageSuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StorageFailureImplCopyWith<T, $Res> {
  factory _$$StorageFailureImplCopyWith(
    _$StorageFailureImpl<T> value,
    $Res Function(_$StorageFailureImpl<T>) then,
  ) = __$$StorageFailureImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({StorageException exception});

  $StorageExceptionCopyWith<$Res> get exception;
}

/// @nodoc
class __$$StorageFailureImplCopyWithImpl<T, $Res>
    extends _$StorageResponseCopyWithImpl<T, $Res, _$StorageFailureImpl<T>>
    implements _$$StorageFailureImplCopyWith<T, $Res> {
  __$$StorageFailureImplCopyWithImpl(
    _$StorageFailureImpl<T> _value,
    $Res Function(_$StorageFailureImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of StorageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? exception = null}) {
    return _then(
      _$StorageFailureImpl<T>(
        null == exception
            ? _value.exception
            : exception // ignore: cast_nullable_to_non_nullable
                  as StorageException,
      ),
    );
  }

  /// Create a copy of StorageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StorageExceptionCopyWith<$Res> get exception {
    return $StorageExceptionCopyWith<$Res>(_value.exception, (value) {
      return _then(_value.copyWith(exception: value));
    });
  }
}

/// @nodoc

class _$StorageFailureImpl<T> implements StorageFailure<T> {
  const _$StorageFailureImpl(this.exception);

  @override
  final StorageException exception;

  @override
  String toString() {
    return 'StorageResponse<$T>.failure(exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageFailureImpl<T> &&
            (identical(other.exception, exception) ||
                other.exception == exception));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exception);

  /// Create a copy of StorageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageFailureImplCopyWith<T, _$StorageFailureImpl<T>> get copyWith =>
      __$$StorageFailureImplCopyWithImpl<T, _$StorageFailureImpl<T>>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(StorageException exception) failure,
  }) {
    return failure(exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(StorageException exception)? failure,
  }) {
    return failure?.call(exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(StorageException exception)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StorageSuccess<T> value) success,
    required TResult Function(StorageFailure<T> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StorageSuccess<T> value)? success,
    TResult? Function(StorageFailure<T> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StorageSuccess<T> value)? success,
    TResult Function(StorageFailure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class StorageFailure<T> implements StorageResponse<T> {
  const factory StorageFailure(final StorageException exception) =
      _$StorageFailureImpl<T>;

  StorageException get exception;

  /// Create a copy of StorageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageFailureImplCopyWith<T, _$StorageFailureImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
