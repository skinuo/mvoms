import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mvoms/models/target_system.dart';

import 'member.dart';
part 'operation_event.freezed.dart';
part 'operation_event.g.dart';

/// 이벤트 관리
@unfreezed
class OperationEvent with _$OperationEvent {
  factory OperationEvent({
    String? evntId,
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
    required Member requester,
    required String reqMthdCd,
    required String reqTpCd,
  }) = _OperationEvent;

  factory OperationEvent.create() => OperationEvent(title: "", stateCd: "", evntDesc: "",
      evntTime: DateTime.now(), registerId: "", registerTime: DateTime.now(), useYn: "Y",
      editorId: "", editTime: DateTime.now(), requester: Member.create(), reqMthdCd: "", reqTpCd: "");

  factory OperationEvent.fromJson(Map<String, dynamic> json) => _$OperationEventFromJson(json);
}