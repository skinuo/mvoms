import 'package:freezed_annotation/freezed_annotation.dart';

part 'target_system.freezed.dart';
part 'target_system.g.dart';

/// 대상 시스템 관리
@freezed
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
  factory TargetSystem.fromJson(Map<String, dynamic> json) => _$TargetSystemFromJson(json);
}