// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DepartmentImpl _$$DepartmentImplFromJson(Map<String, dynamic> json) =>
    _$DepartmentImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      organization:
          Organization.fromJson(json['organization'] as Map<String, dynamic>),
      superDepartment: json['superDepartment'] == null
          ? null
          : Department.fromJson(
              json['superDepartment'] as Map<String, dynamic>),
      member: json['member'] == null
          ? null
          : Member.fromJson(json['member'] as Map<String, dynamic>),
      registerId: json['registerId'] as String,
      registerTime:
          const UTCDateTimeConverter().fromJson(json['registerTime'] as String),
      useYn: json['useYn'] as String,
      editorId: json['editorId'] as String,
      editTime:
          const UTCDateTimeConverter().fromJson(json['editTime'] as String),
    );

Map<String, dynamic> _$$DepartmentImplToJson(_$DepartmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'organization': instance.organization,
      'superDepartment': instance.superDepartment,
      'member': instance.member,
      'registerId': instance.registerId,
      'registerTime':
          const UTCDateTimeConverter().toJson(instance.registerTime),
      'useYn': instance.useYn,
      'editorId': instance.editorId,
      'editTime': const UTCDateTimeConverter().toJson(instance.editTime),
    };
