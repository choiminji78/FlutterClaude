// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostResponseDtoImpl _$$PostResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PostResponseDtoImpl(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  title: json['title'] as String,
  body: json['body'] as String,
);

Map<String, dynamic> _$$PostResponseDtoImplToJson(
  _$PostResponseDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'body': instance.body,
};
