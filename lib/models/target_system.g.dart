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
      registerTime:
          const UTCDateTimeConverter().fromJson(json['registerTime'] as String),
      useYn: json['useYn'] as String,
      editorId: json['editorId'] as String,
      editTime:
          const UTCDateTimeConverter().fromJson(json['editTime'] as String),
    );

Map<String, dynamic> _$$TargetSystemImplToJson(_$TargetSystemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'registerId': instance.registerId,
      'registerTime':
          const UTCDateTimeConverter().toJson(instance.registerTime),
      'useYn': instance.useYn,
      'editorId': instance.editorId,
      'editTime': const UTCDateTimeConverter().toJson(instance.editTime),
    };
