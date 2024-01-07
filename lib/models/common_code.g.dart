// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommonCodeImpl _$$CommonCodeImplFromJson(Map<String, dynamic> json) =>
    _$CommonCodeImpl(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      desc: json['desc'] as String?,
      orderSeq: json['orderSeq'] as int,
      registerId: json['registerId'] as String,
      registerTime: DateTime.parse(json['registerTime'] as String),
      useYn: json['useYn'] as String,
      editorId: json['editorId'] as String,
      editTime: DateTime.parse(json['editTime'] as String),
    );

Map<String, dynamic> _$$CommonCodeImplToJson(_$CommonCodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'desc': instance.desc,
      'orderSeq': instance.orderSeq,
      'registerId': instance.registerId,
      'registerTime': instance.registerTime.toIso8601String(),
      'useYn': instance.useYn,
      'editorId': instance.editorId,
      'editTime': instance.editTime.toIso8601String(),
    };
