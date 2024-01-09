// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_system.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TargetSystemImpl _$$TargetSystemImplFromJson(Map<String, dynamic> json) =>
    _$TargetSystemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      registerId: json['registerId'] as String,
      registerTime: DateTime.parse(json['registerTime'] as String),
      useYn: json['useYn'] as String,
      editorId: json['editorId'] as String,
      editTime: DateTime.parse(json['editTime'] as String),
    );

Map<String, dynamic> _$$TargetSystemImplToJson(_$TargetSystemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'registerId': instance.registerId,
      'registerTime': instance.registerTime.toIso8601String(),
      'useYn': instance.useYn,
      'editorId': instance.editorId,
      'editTime': instance.editTime.toIso8601String(),
    };
