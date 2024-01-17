// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberImpl _$$MemberImplFromJson(Map<String, dynamic> json) => _$MemberImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      department:
          Department.fromJson(json['department'] as Map<String, dynamic>),
      registerId: json['registerId'] as String,
      registerTime:
          const UTCDateTimeConverter().fromJson(json['registerTime'] as String),
      useYn: json['useYn'] as String,
      editorId: json['editorId'] as String,
      editTime:
          const UTCDateTimeConverter().fromJson(json['editTime'] as String),
    );

Map<String, dynamic> _$$MemberImplToJson(_$MemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'department': instance.department,
      'registerId': instance.registerId,
      'registerTime':
          const UTCDateTimeConverter().toJson(instance.registerTime),
      'useYn': instance.useYn,
      'editorId': instance.editorId,
      'editTime': const UTCDateTimeConverter().toJson(instance.editTime),
    };
