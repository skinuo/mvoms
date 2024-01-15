import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mvoms/models/target_system.dart';
import 'package:mvoms/utilities/UTCDateTimeConverter.dart';
import 'package:mvoms/utilities/global.dart';

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
    @UTCDateTimeConverter() required DateTime evntTime,
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

  factory OperationEvent.create() => OperationEvent(title: "", stateCd: "REQ", evntDesc: "",
      evntTime: DateTime.now(), registerId: Global.user.id!, registerTime: DateTime.now(), useYn: "Y",
      editorId: Global.user.id!, editTime: DateTime.now(), requester: Member.create(), reqMthdCd: "", reqTpCd: "");

  factory OperationEvent.fromJson(Map<String, dynamic> json) => _$OperationEventFromJson(json);
}