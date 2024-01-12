// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_event_search_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OperationEventSearchConditionImpl
    _$$OperationEventSearchConditionImplFromJson(Map<String, dynamic> json) =>
        _$OperationEventSearchConditionImpl(
          titleLike: json['titleLike'] as String?,
          evntDescLike: json['evntDescLike'] as String?,
          stateCd: json['stateCd'] as String?,
          evntTimeStart: json['evntTimeStart'] == null
              ? null
              : DateTime.parse(json['evntTimeStart'] as String),
          evntTimeEnd: json['evntTimeEnd'] == null
              ? null
              : DateTime.parse(json['evntTimeEnd'] as String),
          closeTimeStart: json['closeTimeStart'] == null
              ? null
              : DateTime.parse(json['closeTimeStart'] as String),
          closeTimeEnd: json['closeTimeEnd'] == null
              ? null
              : DateTime.parse(json['closeTimeEnd'] as String),
          requesterNameLike: json['requesterNameLike'] as String?,
          chargerNameLike: json['chargerNameLike'] as String?,
        );

Map<String, dynamic> _$$OperationEventSearchConditionImplToJson(
        _$OperationEventSearchConditionImpl instance) =>
    <String, dynamic>{
      'titleLike': instance.titleLike,
      'evntDescLike': instance.evntDescLike,
      'stateCd': instance.stateCd,
      'evntTimeStart': instance.evntTimeStart?.toIso8601String(),
      'evntTimeEnd': instance.evntTimeEnd?.toIso8601String(),
      'closeTimeStart': instance.closeTimeStart?.toIso8601String(),
      'closeTimeEnd': instance.closeTimeEnd?.toIso8601String(),
      'requesterNameLike': instance.requesterNameLike,
      'chargerNameLike': instance.chargerNameLike,
    };
