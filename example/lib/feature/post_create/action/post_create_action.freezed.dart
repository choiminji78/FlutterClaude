// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_create_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PostCreateAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) titleChanged,
    required TResult Function(String body) bodyChanged,
    required TResult Function(String title, String body) createPostStarted,
    required TResult Function(PostEntity post) createPostSucceeded,
    required TResult Function(AppException error) createPostFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title)? titleChanged,
    TResult? Function(String body)? bodyChanged,
    TResult? Function(String title, String body)? createPostStarted,
    TResult? Function(PostEntity post)? createPostSucceeded,
    TResult? Function(AppException error)? createPostFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String body)? bodyChanged,
    TResult Function(String title, String body)? createPostStarted,
    TResult Function(PostEntity post)? createPostSucceeded,
    TResult Function(AppException error)? createPostFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleChanged value) titleChanged,
    required TResult Function(BodyChanged value) bodyChanged,
    required TResult Function(CreatePostStarted value) createPostStarted,
    required TResult Function(CreatePostSucceeded value) createPostSucceeded,
    required TResult Function(CreatePostFailed value) createPostFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TitleChanged value)? titleChanged,
    TResult? Function(BodyChanged value)? bodyChanged,
    TResult? Function(CreatePostStarted value)? createPostStarted,
    TResult? Function(CreatePostSucceeded value)? createPostSucceeded,
    TResult? Function(CreatePostFailed value)? createPostFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(BodyChanged value)? bodyChanged,
    TResult Function(CreatePostStarted value)? createPostStarted,
    TResult Function(CreatePostSucceeded value)? createPostSucceeded,
    TResult Function(CreatePostFailed value)? createPostFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCreateActionCopyWith<$Res> {
  factory $PostCreateActionCopyWith(
    PostCreateAction value,
    $Res Function(PostCreateAction) then,
  ) = _$PostCreateActionCopyWithImpl<$Res, PostCreateAction>;
}

/// @nodoc
class _$PostCreateActionCopyWithImpl<$Res, $Val extends PostCreateAction>
    implements $PostCreateActionCopyWith<$Res> {
  _$PostCreateActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TitleChangedImplCopyWith<$Res> {
  factory _$$TitleChangedImplCopyWith(
    _$TitleChangedImpl value,
    $Res Function(_$TitleChangedImpl) then,
  ) = __$$TitleChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title});
}

/// @nodoc
class __$$TitleChangedImplCopyWithImpl<$Res>
    extends _$PostCreateActionCopyWithImpl<$Res, _$TitleChangedImpl>
    implements _$$TitleChangedImplCopyWith<$Res> {
  __$$TitleChangedImplCopyWithImpl(
    _$TitleChangedImpl _value,
    $Res Function(_$TitleChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null}) {
    return _then(
      _$TitleChangedImpl(
        null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$TitleChangedImpl implements TitleChanged {
  const _$TitleChangedImpl(this.title);

  @override
  final String title;

  @override
  String toString() {
    return 'PostCreateAction.titleChanged(title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TitleChangedImpl &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title);

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TitleChangedImplCopyWith<_$TitleChangedImpl> get copyWith =>
      __$$TitleChangedImplCopyWithImpl<_$TitleChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) titleChanged,
    required TResult Function(String body) bodyChanged,
    required TResult Function(String title, String body) createPostStarted,
    required TResult Function(PostEntity post) createPostSucceeded,
    required TResult Function(AppException error) createPostFailed,
  }) {
    return titleChanged(title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title)? titleChanged,
    TResult? Function(String body)? bodyChanged,
    TResult? Function(String title, String body)? createPostStarted,
    TResult? Function(PostEntity post)? createPostSucceeded,
    TResult? Function(AppException error)? createPostFailed,
  }) {
    return titleChanged?.call(title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String body)? bodyChanged,
    TResult Function(String title, String body)? createPostStarted,
    TResult Function(PostEntity post)? createPostSucceeded,
    TResult Function(AppException error)? createPostFailed,
    required TResult orElse(),
  }) {
    if (titleChanged != null) {
      return titleChanged(title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleChanged value) titleChanged,
    required TResult Function(BodyChanged value) bodyChanged,
    required TResult Function(CreatePostStarted value) createPostStarted,
    required TResult Function(CreatePostSucceeded value) createPostSucceeded,
    required TResult Function(CreatePostFailed value) createPostFailed,
  }) {
    return titleChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TitleChanged value)? titleChanged,
    TResult? Function(BodyChanged value)? bodyChanged,
    TResult? Function(CreatePostStarted value)? createPostStarted,
    TResult? Function(CreatePostSucceeded value)? createPostSucceeded,
    TResult? Function(CreatePostFailed value)? createPostFailed,
  }) {
    return titleChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(BodyChanged value)? bodyChanged,
    TResult Function(CreatePostStarted value)? createPostStarted,
    TResult Function(CreatePostSucceeded value)? createPostSucceeded,
    TResult Function(CreatePostFailed value)? createPostFailed,
    required TResult orElse(),
  }) {
    if (titleChanged != null) {
      return titleChanged(this);
    }
    return orElse();
  }
}

abstract class TitleChanged implements PostCreateAction {
  const factory TitleChanged(final String title) = _$TitleChangedImpl;

  String get title;

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TitleChangedImplCopyWith<_$TitleChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BodyChangedImplCopyWith<$Res> {
  factory _$$BodyChangedImplCopyWith(
    _$BodyChangedImpl value,
    $Res Function(_$BodyChangedImpl) then,
  ) = __$$BodyChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String body});
}

/// @nodoc
class __$$BodyChangedImplCopyWithImpl<$Res>
    extends _$PostCreateActionCopyWithImpl<$Res, _$BodyChangedImpl>
    implements _$$BodyChangedImplCopyWith<$Res> {
  __$$BodyChangedImplCopyWithImpl(
    _$BodyChangedImpl _value,
    $Res Function(_$BodyChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? body = null}) {
    return _then(
      _$BodyChangedImpl(
        null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$BodyChangedImpl implements BodyChanged {
  const _$BodyChangedImpl(this.body);

  @override
  final String body;

  @override
  String toString() {
    return 'PostCreateAction.bodyChanged(body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BodyChangedImpl &&
            (identical(other.body, body) || other.body == body));
  }

  @override
  int get hashCode => Object.hash(runtimeType, body);

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BodyChangedImplCopyWith<_$BodyChangedImpl> get copyWith =>
      __$$BodyChangedImplCopyWithImpl<_$BodyChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) titleChanged,
    required TResult Function(String body) bodyChanged,
    required TResult Function(String title, String body) createPostStarted,
    required TResult Function(PostEntity post) createPostSucceeded,
    required TResult Function(AppException error) createPostFailed,
  }) {
    return bodyChanged(body);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title)? titleChanged,
    TResult? Function(String body)? bodyChanged,
    TResult? Function(String title, String body)? createPostStarted,
    TResult? Function(PostEntity post)? createPostSucceeded,
    TResult? Function(AppException error)? createPostFailed,
  }) {
    return bodyChanged?.call(body);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String body)? bodyChanged,
    TResult Function(String title, String body)? createPostStarted,
    TResult Function(PostEntity post)? createPostSucceeded,
    TResult Function(AppException error)? createPostFailed,
    required TResult orElse(),
  }) {
    if (bodyChanged != null) {
      return bodyChanged(body);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleChanged value) titleChanged,
    required TResult Function(BodyChanged value) bodyChanged,
    required TResult Function(CreatePostStarted value) createPostStarted,
    required TResult Function(CreatePostSucceeded value) createPostSucceeded,
    required TResult Function(CreatePostFailed value) createPostFailed,
  }) {
    return bodyChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TitleChanged value)? titleChanged,
    TResult? Function(BodyChanged value)? bodyChanged,
    TResult? Function(CreatePostStarted value)? createPostStarted,
    TResult? Function(CreatePostSucceeded value)? createPostSucceeded,
    TResult? Function(CreatePostFailed value)? createPostFailed,
  }) {
    return bodyChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(BodyChanged value)? bodyChanged,
    TResult Function(CreatePostStarted value)? createPostStarted,
    TResult Function(CreatePostSucceeded value)? createPostSucceeded,
    TResult Function(CreatePostFailed value)? createPostFailed,
    required TResult orElse(),
  }) {
    if (bodyChanged != null) {
      return bodyChanged(this);
    }
    return orElse();
  }
}

abstract class BodyChanged implements PostCreateAction {
  const factory BodyChanged(final String body) = _$BodyChangedImpl;

  String get body;

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BodyChangedImplCopyWith<_$BodyChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreatePostStartedImplCopyWith<$Res> {
  factory _$$CreatePostStartedImplCopyWith(
    _$CreatePostStartedImpl value,
    $Res Function(_$CreatePostStartedImpl) then,
  ) = __$$CreatePostStartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title, String body});
}

/// @nodoc
class __$$CreatePostStartedImplCopyWithImpl<$Res>
    extends _$PostCreateActionCopyWithImpl<$Res, _$CreatePostStartedImpl>
    implements _$$CreatePostStartedImplCopyWith<$Res> {
  __$$CreatePostStartedImplCopyWithImpl(
    _$CreatePostStartedImpl _value,
    $Res Function(_$CreatePostStartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? body = null}) {
    return _then(
      _$CreatePostStartedImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CreatePostStartedImpl implements CreatePostStarted {
  const _$CreatePostStartedImpl({required this.title, required this.body});

  @override
  final String title;
  @override
  final String body;

  @override
  String toString() {
    return 'PostCreateAction.createPostStarted(title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePostStartedImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, body);

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePostStartedImplCopyWith<_$CreatePostStartedImpl> get copyWith =>
      __$$CreatePostStartedImplCopyWithImpl<_$CreatePostStartedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) titleChanged,
    required TResult Function(String body) bodyChanged,
    required TResult Function(String title, String body) createPostStarted,
    required TResult Function(PostEntity post) createPostSucceeded,
    required TResult Function(AppException error) createPostFailed,
  }) {
    return createPostStarted(title, body);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title)? titleChanged,
    TResult? Function(String body)? bodyChanged,
    TResult? Function(String title, String body)? createPostStarted,
    TResult? Function(PostEntity post)? createPostSucceeded,
    TResult? Function(AppException error)? createPostFailed,
  }) {
    return createPostStarted?.call(title, body);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String body)? bodyChanged,
    TResult Function(String title, String body)? createPostStarted,
    TResult Function(PostEntity post)? createPostSucceeded,
    TResult Function(AppException error)? createPostFailed,
    required TResult orElse(),
  }) {
    if (createPostStarted != null) {
      return createPostStarted(title, body);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleChanged value) titleChanged,
    required TResult Function(BodyChanged value) bodyChanged,
    required TResult Function(CreatePostStarted value) createPostStarted,
    required TResult Function(CreatePostSucceeded value) createPostSucceeded,
    required TResult Function(CreatePostFailed value) createPostFailed,
  }) {
    return createPostStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TitleChanged value)? titleChanged,
    TResult? Function(BodyChanged value)? bodyChanged,
    TResult? Function(CreatePostStarted value)? createPostStarted,
    TResult? Function(CreatePostSucceeded value)? createPostSucceeded,
    TResult? Function(CreatePostFailed value)? createPostFailed,
  }) {
    return createPostStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(BodyChanged value)? bodyChanged,
    TResult Function(CreatePostStarted value)? createPostStarted,
    TResult Function(CreatePostSucceeded value)? createPostSucceeded,
    TResult Function(CreatePostFailed value)? createPostFailed,
    required TResult orElse(),
  }) {
    if (createPostStarted != null) {
      return createPostStarted(this);
    }
    return orElse();
  }
}

abstract class CreatePostStarted implements PostCreateAction {
  const factory CreatePostStarted({
    required final String title,
    required final String body,
  }) = _$CreatePostStartedImpl;

  String get title;
  String get body;

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePostStartedImplCopyWith<_$CreatePostStartedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreatePostSucceededImplCopyWith<$Res> {
  factory _$$CreatePostSucceededImplCopyWith(
    _$CreatePostSucceededImpl value,
    $Res Function(_$CreatePostSucceededImpl) then,
  ) = __$$CreatePostSucceededImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PostEntity post});

  $PostEntityCopyWith<$Res> get post;
}

/// @nodoc
class __$$CreatePostSucceededImplCopyWithImpl<$Res>
    extends _$PostCreateActionCopyWithImpl<$Res, _$CreatePostSucceededImpl>
    implements _$$CreatePostSucceededImplCopyWith<$Res> {
  __$$CreatePostSucceededImplCopyWithImpl(
    _$CreatePostSucceededImpl _value,
    $Res Function(_$CreatePostSucceededImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? post = null}) {
    return _then(
      _$CreatePostSucceededImpl(
        null == post
            ? _value.post
            : post // ignore: cast_nullable_to_non_nullable
                  as PostEntity,
      ),
    );
  }

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostEntityCopyWith<$Res> get post {
    return $PostEntityCopyWith<$Res>(_value.post, (value) {
      return _then(_value.copyWith(post: value));
    });
  }
}

/// @nodoc

class _$CreatePostSucceededImpl implements CreatePostSucceeded {
  const _$CreatePostSucceededImpl(this.post);

  @override
  final PostEntity post;

  @override
  String toString() {
    return 'PostCreateAction.createPostSucceeded(post: $post)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePostSucceededImpl &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePostSucceededImplCopyWith<_$CreatePostSucceededImpl> get copyWith =>
      __$$CreatePostSucceededImplCopyWithImpl<_$CreatePostSucceededImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) titleChanged,
    required TResult Function(String body) bodyChanged,
    required TResult Function(String title, String body) createPostStarted,
    required TResult Function(PostEntity post) createPostSucceeded,
    required TResult Function(AppException error) createPostFailed,
  }) {
    return createPostSucceeded(post);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title)? titleChanged,
    TResult? Function(String body)? bodyChanged,
    TResult? Function(String title, String body)? createPostStarted,
    TResult? Function(PostEntity post)? createPostSucceeded,
    TResult? Function(AppException error)? createPostFailed,
  }) {
    return createPostSucceeded?.call(post);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String body)? bodyChanged,
    TResult Function(String title, String body)? createPostStarted,
    TResult Function(PostEntity post)? createPostSucceeded,
    TResult Function(AppException error)? createPostFailed,
    required TResult orElse(),
  }) {
    if (createPostSucceeded != null) {
      return createPostSucceeded(post);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleChanged value) titleChanged,
    required TResult Function(BodyChanged value) bodyChanged,
    required TResult Function(CreatePostStarted value) createPostStarted,
    required TResult Function(CreatePostSucceeded value) createPostSucceeded,
    required TResult Function(CreatePostFailed value) createPostFailed,
  }) {
    return createPostSucceeded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TitleChanged value)? titleChanged,
    TResult? Function(BodyChanged value)? bodyChanged,
    TResult? Function(CreatePostStarted value)? createPostStarted,
    TResult? Function(CreatePostSucceeded value)? createPostSucceeded,
    TResult? Function(CreatePostFailed value)? createPostFailed,
  }) {
    return createPostSucceeded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(BodyChanged value)? bodyChanged,
    TResult Function(CreatePostStarted value)? createPostStarted,
    TResult Function(CreatePostSucceeded value)? createPostSucceeded,
    TResult Function(CreatePostFailed value)? createPostFailed,
    required TResult orElse(),
  }) {
    if (createPostSucceeded != null) {
      return createPostSucceeded(this);
    }
    return orElse();
  }
}

abstract class CreatePostSucceeded implements PostCreateAction {
  const factory CreatePostSucceeded(final PostEntity post) =
      _$CreatePostSucceededImpl;

  PostEntity get post;

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePostSucceededImplCopyWith<_$CreatePostSucceededImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreatePostFailedImplCopyWith<$Res> {
  factory _$$CreatePostFailedImplCopyWith(
    _$CreatePostFailedImpl value,
    $Res Function(_$CreatePostFailedImpl) then,
  ) = __$$CreatePostFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException error});

  $AppExceptionCopyWith<$Res> get error;
}

/// @nodoc
class __$$CreatePostFailedImplCopyWithImpl<$Res>
    extends _$PostCreateActionCopyWithImpl<$Res, _$CreatePostFailedImpl>
    implements _$$CreatePostFailedImplCopyWith<$Res> {
  __$$CreatePostFailedImplCopyWithImpl(
    _$CreatePostFailedImpl _value,
    $Res Function(_$CreatePostFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$CreatePostFailedImpl(
        null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as AppException,
      ),
    );
  }

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppExceptionCopyWith<$Res> get error {
    return $AppExceptionCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$CreatePostFailedImpl implements CreatePostFailed {
  const _$CreatePostFailedImpl(this.error);

  @override
  final AppException error;

  @override
  String toString() {
    return 'PostCreateAction.createPostFailed(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePostFailedImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePostFailedImplCopyWith<_$CreatePostFailedImpl> get copyWith =>
      __$$CreatePostFailedImplCopyWithImpl<_$CreatePostFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) titleChanged,
    required TResult Function(String body) bodyChanged,
    required TResult Function(String title, String body) createPostStarted,
    required TResult Function(PostEntity post) createPostSucceeded,
    required TResult Function(AppException error) createPostFailed,
  }) {
    return createPostFailed(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title)? titleChanged,
    TResult? Function(String body)? bodyChanged,
    TResult? Function(String title, String body)? createPostStarted,
    TResult? Function(PostEntity post)? createPostSucceeded,
    TResult? Function(AppException error)? createPostFailed,
  }) {
    return createPostFailed?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String body)? bodyChanged,
    TResult Function(String title, String body)? createPostStarted,
    TResult Function(PostEntity post)? createPostSucceeded,
    TResult Function(AppException error)? createPostFailed,
    required TResult orElse(),
  }) {
    if (createPostFailed != null) {
      return createPostFailed(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleChanged value) titleChanged,
    required TResult Function(BodyChanged value) bodyChanged,
    required TResult Function(CreatePostStarted value) createPostStarted,
    required TResult Function(CreatePostSucceeded value) createPostSucceeded,
    required TResult Function(CreatePostFailed value) createPostFailed,
  }) {
    return createPostFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TitleChanged value)? titleChanged,
    TResult? Function(BodyChanged value)? bodyChanged,
    TResult? Function(CreatePostStarted value)? createPostStarted,
    TResult? Function(CreatePostSucceeded value)? createPostSucceeded,
    TResult? Function(CreatePostFailed value)? createPostFailed,
  }) {
    return createPostFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(BodyChanged value)? bodyChanged,
    TResult Function(CreatePostStarted value)? createPostStarted,
    TResult Function(CreatePostSucceeded value)? createPostSucceeded,
    TResult Function(CreatePostFailed value)? createPostFailed,
    required TResult orElse(),
  }) {
    if (createPostFailed != null) {
      return createPostFailed(this);
    }
    return orElse();
  }
}

abstract class CreatePostFailed implements PostCreateAction {
  const factory CreatePostFailed(final AppException error) =
      _$CreatePostFailedImpl;

  AppException get error;

  /// Create a copy of PostCreateAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePostFailedImplCopyWith<_$CreatePostFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
