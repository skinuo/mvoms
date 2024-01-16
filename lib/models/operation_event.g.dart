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
      evntTime:
          const UTCDateTimeConverter().fromJson(json['evntTime'] as String),
      charger: json['charger'] == null
          ? null
          : Member.fromJson(json['charger'] as Map<String, dynamic>),
      closeTime: _$JsonConverterFromJson<String, DateTime>(
          json['closeTime'], const UTCDateTimeConverter().fromJson),
      targetSystem: json['targetSystem'] == null
          ? null
          : TargetSystem.fromJson(json['targetSystem'] as Map<String, dynamic>),
      registerId: json['registerId'] as String,
      registerTime:
          const UTCDateTimeConverter().fromJson(json['registerTime'] as String),
      useYn: json['useYn'] as String,
      editorId: json['editorId'] as String,
      editTime:
          const UTCDateTimeConverter().fromJson(json['editTime'] as String),
      requester: Member.fromJson(json['requester'] as Map<String, dynamic>),
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
      'evntTime': const UTCDateTimeConverter().toJson(instance.evntTime),
      'charger': instance.charger,
      'closeTime': _$JsonConverterToJson<String, DateTime>(
          instance.closeTime, const UTCDateTimeConverter().toJson),
      'targetSystem': instance.targetSystem,
      'registerId': instance.registerId,
      'registerTime':
          const UTCDateTimeConverter().toJson(instance.registerTime),
      'useYn': instance.useYn,
      'editorId': instance.editorId,
      'editTime': const UTCDateTimeConverter().toJson(instance.editTime),
      'requester': instance.requester,
      'reqMthdCd': instance.reqMthdCd,
      'reqTpCd': instance.reqTpCd,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
