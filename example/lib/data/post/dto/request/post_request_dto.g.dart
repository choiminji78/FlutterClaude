// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostRequestDtoImpl _$$PostRequestDtoImplFromJson(Map<String, dynamic> json) =>
    _$PostRequestDtoImpl(
      userId: (json['userId'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$$PostRequestDtoImplToJson(
  _$PostRequestDtoImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'title': instance.title,
  'body': instance.body,
};
