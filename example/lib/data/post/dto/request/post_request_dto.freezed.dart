// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PostRequestDto _$PostRequestDtoFromJson(Map<String, dynamic> json) {
  return _PostRequestDto.fromJson(json);
}

/// @nodoc
mixin _$PostRequestDto {
  int get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;

  /// Serializes this PostRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostRequestDtoCopyWith<PostRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostRequestDtoCopyWith<$Res> {
  factory $PostRequestDtoCopyWith(
    PostRequestDto value,
    $Res Function(PostRequestDto) then,
  ) = _$PostRequestDtoCopyWithImpl<$Res, PostRequestDto>;
  @useResult
  $Res call({int userId, String title, String body});
}

/// @nodoc
class _$PostRequestDtoCopyWithImpl<$Res, $Val extends PostRequestDto>
    implements $PostRequestDtoCopyWith<$Res> {
  _$PostRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? title = null,
    Object? body = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostRequestDtoImplCopyWith<$Res>
    implements $PostRequestDtoCopyWith<$Res> {
  factory _$$PostRequestDtoImplCopyWith(
    _$PostRequestDtoImpl value,
    $Res Function(_$PostRequestDtoImpl) then,
  ) = __$$PostRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int userId, String title, String body});
}

/// @nodoc
class __$$PostRequestDtoImplCopyWithImpl<$Res>
    extends _$PostRequestDtoCopyWithImpl<$Res, _$PostRequestDtoImpl>
    implements _$$PostRequestDtoImplCopyWith<$Res> {
  __$$PostRequestDtoImplCopyWithImpl(
    _$PostRequestDtoImpl _value,
    $Res Function(_$PostRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? title = null,
    Object? body = null,
  }) {
    return _then(
      _$PostRequestDtoImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
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
@JsonSerializable()
class _$PostRequestDtoImpl implements _PostRequestDto {
  const _$PostRequestDtoImpl({
    required this.userId,
    required this.title,
    required this.body,
  });

  factory _$PostRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostRequestDtoImplFromJson(json);

  @override
  final int userId;
  @override
  final String title;
  @override
  final String body;

  @override
  String toString() {
    return 'PostRequestDto(userId: $userId, title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostRequestDtoImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, title, body);

  /// Create a copy of PostRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostRequestDtoImplCopyWith<_$PostRequestDtoImpl> get copyWith =>
      __$$PostRequestDtoImplCopyWithImpl<_$PostRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PostRequestDtoImplToJson(this);
  }
}

abstract class _PostRequestDto implements PostRequestDto {
  const factory _PostRequestDto({
    required final int userId,
    required final String title,
    required final String body,
  }) = _$PostRequestDtoImpl;

  factory _PostRequestDto.fromJson(Map<String, dynamic> json) =
      _$PostRequestDtoImpl.fromJson;

  @override
  int get userId;
  @override
  String get title;
  @override
  String get body;

  /// Create a copy of PostRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostRequestDtoImplCopyWith<_$PostRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
