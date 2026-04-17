// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_create_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PostCreateState {
  String get titleInput => throw _privateConstructorUsedError;
  String get bodyInput => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  AppException? get error => throw _privateConstructorUsedError;
  PostEntity? get createdPost => throw _privateConstructorUsedError;

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostCreateStateCopyWith<PostCreateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCreateStateCopyWith<$Res> {
  factory $PostCreateStateCopyWith(
    PostCreateState value,
    $Res Function(PostCreateState) then,
  ) = _$PostCreateStateCopyWithImpl<$Res, PostCreateState>;
  @useResult
  $Res call({
    String titleInput,
    String bodyInput,
    bool isLoading,
    AppException? error,
    PostEntity? createdPost,
  });

  $AppExceptionCopyWith<$Res>? get error;
  $PostEntityCopyWith<$Res>? get createdPost;
}

/// @nodoc
class _$PostCreateStateCopyWithImpl<$Res, $Val extends PostCreateState>
    implements $PostCreateStateCopyWith<$Res> {
  _$PostCreateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleInput = null,
    Object? bodyInput = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? createdPost = freezed,
  }) {
    return _then(
      _value.copyWith(
            titleInput: null == titleInput
                ? _value.titleInput
                : titleInput // ignore: cast_nullable_to_non_nullable
                      as String,
            bodyInput: null == bodyInput
                ? _value.bodyInput
                : bodyInput // ignore: cast_nullable_to_non_nullable
                      as String,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as AppException?,
            createdPost: freezed == createdPost
                ? _value.createdPost
                : createdPost // ignore: cast_nullable_to_non_nullable
                      as PostEntity?,
          )
          as $Val,
    );
  }

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppExceptionCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $AppExceptionCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostEntityCopyWith<$Res>? get createdPost {
    if (_value.createdPost == null) {
      return null;
    }

    return $PostEntityCopyWith<$Res>(_value.createdPost!, (value) {
      return _then(_value.copyWith(createdPost: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostCreateStateImplCopyWith<$Res>
    implements $PostCreateStateCopyWith<$Res> {
  factory _$$PostCreateStateImplCopyWith(
    _$PostCreateStateImpl value,
    $Res Function(_$PostCreateStateImpl) then,
  ) = __$$PostCreateStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String titleInput,
    String bodyInput,
    bool isLoading,
    AppException? error,
    PostEntity? createdPost,
  });

  @override
  $AppExceptionCopyWith<$Res>? get error;
  @override
  $PostEntityCopyWith<$Res>? get createdPost;
}

/// @nodoc
class __$$PostCreateStateImplCopyWithImpl<$Res>
    extends _$PostCreateStateCopyWithImpl<$Res, _$PostCreateStateImpl>
    implements _$$PostCreateStateImplCopyWith<$Res> {
  __$$PostCreateStateImplCopyWithImpl(
    _$PostCreateStateImpl _value,
    $Res Function(_$PostCreateStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleInput = null,
    Object? bodyInput = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? createdPost = freezed,
  }) {
    return _then(
      _$PostCreateStateImpl(
        titleInput: null == titleInput
            ? _value.titleInput
            : titleInput // ignore: cast_nullable_to_non_nullable
                  as String,
        bodyInput: null == bodyInput
            ? _value.bodyInput
            : bodyInput // ignore: cast_nullable_to_non_nullable
                  as String,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as AppException?,
        createdPost: freezed == createdPost
            ? _value.createdPost
            : createdPost // ignore: cast_nullable_to_non_nullable
                  as PostEntity?,
      ),
    );
  }
}

/// @nodoc

class _$PostCreateStateImpl implements _PostCreateState {
  const _$PostCreateStateImpl({
    this.titleInput = '',
    this.bodyInput = '',
    this.isLoading = false,
    this.error = null,
    this.createdPost = null,
  });

  @override
  @JsonKey()
  final String titleInput;
  @override
  @JsonKey()
  final String bodyInput;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final AppException? error;
  @override
  @JsonKey()
  final PostEntity? createdPost;

  @override
  String toString() {
    return 'PostCreateState(titleInput: $titleInput, bodyInput: $bodyInput, isLoading: $isLoading, error: $error, createdPost: $createdPost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostCreateStateImpl &&
            (identical(other.titleInput, titleInput) ||
                other.titleInput == titleInput) &&
            (identical(other.bodyInput, bodyInput) ||
                other.bodyInput == bodyInput) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.createdPost, createdPost) ||
                other.createdPost == createdPost));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    titleInput,
    bodyInput,
    isLoading,
    error,
    createdPost,
  );

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostCreateStateImplCopyWith<_$PostCreateStateImpl> get copyWith =>
      __$$PostCreateStateImplCopyWithImpl<_$PostCreateStateImpl>(
        this,
        _$identity,
      );
}

abstract class _PostCreateState implements PostCreateState {
  const factory _PostCreateState({
    final String titleInput,
    final String bodyInput,
    final bool isLoading,
    final AppException? error,
    final PostEntity? createdPost,
  }) = _$PostCreateStateImpl;

  @override
  String get titleInput;
  @override
  String get bodyInput;
  @override
  bool get isLoading;
  @override
  AppException? get error;
  @override
  PostEntity? get createdPost;

  /// Create a copy of PostCreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostCreateStateImplCopyWith<_$PostCreateStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
