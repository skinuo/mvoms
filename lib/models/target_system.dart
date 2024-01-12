import 'package:freezed_annotation/freezed_annotation.dart';

part 'target_system.freezed.dart';
part 'target_system.g.dart';

/// 대상 시스템 관리
@unfreezed
class TargetSystem with _$TargetSystem {
  factory TargetSystem({
    required String id,
    required String name,

    required String registerId,
    required DateTime registerTime,
    required String useYn,
    required String editorId,
    required DateTime editTime
  }) = _TargetSystem;

  factory TargetSystem.create() => TargetSystem(id: "", name: "", registerId: "",
      registerTime: DateTime.now(), useYn: "Y", editorId: "", editTime: DateTime.now());

  factory TargetSystem.fromJson(Map<String, dynamic> json) => _$TargetSystemFromJson(json);
}