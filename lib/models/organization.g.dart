// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrganizationImpl _$$OrganizationImplFromJson(Map<String, dynamic> json) =>
    _$OrganizationImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      registerId: json['registerId'] as String,
      registerTime:
          const UTCDateTimeConverter().fromJson(json['registerTime'] as String),
      useYn: json['useYn'] as String,
      editorId: json['editorId'] as String,
      editTime:
          const UTCDateTimeConverter().fromJson(json['editTime'] as String),
    );

Map<String, dynamic> _$$OrganizationImplToJson(_$OrganizationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'registerId': instance.registerId,
      'registerTime':
          const UTCDateTimeConverter().toJson(instance.registerTime),
      'useYn': instance.useYn,
      'editorId': instance.editorId,
      'editTime': const UTCDateTimeConverter().toJson(instance.editTime),
    };
