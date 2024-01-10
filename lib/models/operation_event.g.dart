// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OperationEventImpl _$$OperationEventImplFromJson(Map<String, dynamic> json) =>
    _$OperationEventImpl(
      evntId: json['evntId'] as String?,
      title: json['title'] as String,
      stateCd: json['stateCd'] as String,
      evntDesc: json['evntDesc'] as String,
      evntTime: DateTime.parse(json['evntTime'] as String),
      charger: json['charger'] == null
          ? null
          : Member.fromJson(json['charger'] as Map<String, dynamic>),
      closeTime: json['closeTime'] as String?,
      targetSystem: json['targetSystem'] == null
          ? null
          : TargetSystem.fromJson(json['targetSystem'] as Map<String, dynamic>),
      registerId: json['registerId'] as String,
      registerTime: DateTime.parse(json['registerTime'] as String),
      useYn: json['useYn'] as String,
      editorId: json['editorId'] as String,
      editTime: DateTime.parse(json['editTime'] as String),
      requester: Requester.fromJson(json['requester'] as Map<String, dynamic>),
      reqMthdCd: json['reqMthdCd'] as String,
      reqTpCd: json['reqTpCd'] as String,
    );

Map<String, dynamic> _$$OperationEventImplToJson(
        _$OperationEventImpl instance) =>
    <String, dynamic>{
      'evntId': instance.evntId,
      'title': instance.title,
      'stateCd': instance.stateCd,
      'evntDesc': instance.evntDesc,
      'evntTime': instance.evntTime.toIso8601String(),
      'charger': instance.charger,
      'closeTime': instance.closeTime,
      'targetSystem': instance.targetSystem,
      'registerId': instance.registerId,
      'registerTime': instance.registerTime.toIso8601String(),
      'useYn': instance.useYn,
      'editorId': instance.editorId,
      'editTime': instance.editTime.toIso8601String(),
      'requester': instance.requester,
      'reqMthdCd': instance.reqMthdCd,
      'reqTpCd': instance.reqTpCd,
    };
