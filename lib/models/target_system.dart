import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mvoms/utilities/UTCDateTimeConverter.dart';
import 'package:mvoms/utilities/global.dart';
part 'target_system.freezed.dart';
part 'target_system.g.dart';

/// 대상 시스템 관리
@unfreezed
class TargetSystem with _$TargetSystem {
  factory TargetSystem({
    required String id,
    required String name,

    required String registerId,
    @UTCDateTimeConverter() required DateTime registerTime,
    required String useYn,
    required String editorId,
    @UTCDateTimeConverter() required DateTime editTime
  }) = _TargetSystem;

  factory TargetSystem.create() => TargetSystem(id: "", name: "", registerId: Global.user.id!,
      registerTime: DateTime.now(), useYn: "Y", editorId: Global.user.id!, editTime: DateTime.now());

  factory TargetSystem.fromJson(Map<String, dynamic> json) => _$TargetSystemFromJson(json);
}