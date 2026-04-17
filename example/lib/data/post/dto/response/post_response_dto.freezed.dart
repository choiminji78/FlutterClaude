// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PostResponseDto _$PostResponseDtoFromJson(Map<String, dynamic> json) {
  return _PostResponseDto.fromJson(json);
}

/// @nodoc
mixin _$PostResponseDto {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;

  /// Serializes this PostResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostResponseDtoCopyWith<PostResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostResponseDtoCopyWith<$Res> {
  factory $PostResponseDtoCopyWith(
    PostResponseDto value,
    $Res Function(PostResponseDto) then,
  ) = _$PostResponseDtoCopyWithImpl<$Res, PostResponseDto>;
  @useResult
  $Res call({int id, int userId, String title, String body});
}

/// @nodoc
class _$PostResponseDtoCopyWithImpl<$Res, $Val extends PostResponseDto>
    implements $PostResponseDtoCopyWith<$Res> {
  _$PostResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$PostResponseDtoImplCopyWith<$Res>
    implements $PostResponseDtoCopyWith<$Res> {
  factory _$$PostResponseDtoImplCopyWith(
    _$PostResponseDtoImpl value,
    $Res Function(_$PostResponseDtoImpl) then,
  ) = __$$PostResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int userId, String title, String body});
}

/// @nodoc
class __$$PostResponseDtoImplCopyWithImpl<$Res>
    extends _$PostResponseDtoCopyWithImpl<$Res, _$PostResponseDtoImpl>
    implements _$$PostResponseDtoImplCopyWith<$Res> {
  __$$PostResponseDtoImplCopyWithImpl(
    _$PostResponseDtoImpl _value,
    $Res Function(_$PostResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
  }) {
    return _then(
      _$PostResponseDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$PostResponseDtoImpl implements _PostResponseDto {
  const _$PostResponseDtoImpl({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory _$PostResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostResponseDtoImplFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final String title;
  @override
  final String body;

  @override
  String toString() {
    return 'PostResponseDto(id: $id, userId: $userId, title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostResponseDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, title, body);

  /// Create a copy of PostResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostResponseDtoImplCopyWith<_$PostResponseDtoImpl> get copyWith =>
      __$$PostResponseDtoImplCopyWithImpl<_$PostResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PostResponseDtoImplToJson(this);
  }
}

abstract class _PostResponseDto implements PostResponseDto {
  const factory _PostResponseDto({
    required final int id,
    required final int userId,
    required final String title,
    required final String body,
  }) = _$PostResponseDtoImpl;

  factory _PostResponseDto.fromJson(Map<String, dynamic> json) =
      _$PostResponseDtoImpl.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get title;
  @override
  String get body;

  /// Create a copy of PostResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostResponseDtoImplCopyWith<_$PostResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
