import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mvoms/models/target_system.dart';

import 'member.dart';
part 'operation_event.freezed.dart';
part 'operation_event.g.dart';

/// 이벤트 관리
@freezed
class OperationEvent with _$OperationEvent {
  factory OperationEvent({
    required String evntId,
    required String title,
    required String stateCd,
    required String evntDesc,
    required DateTime evntTime,
    Member? charger,
    String? closeTime,
    TargetSystem? targetSystem,
    required String registerId,
    required DateTime registerTime,
    required String useYn,
    required String editorId,
    required DateTime editTime,
  }) = _OperationEvent;

  factory OperationEvent.fromJson(Map<String, dynamic> json) => _$OperationEventFromJson(json);
}