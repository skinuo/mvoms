import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mvoms/utilities/UTCDateTimeConverter.dart';
import 'package:mvoms/utilities/global.dart';

import 'department.dart';
part 'member.freezed.dart';
part 'member.g.dart';

/// 사용자 관리
@unfreezed
class Member with _$Member {
  factory Member({
    String? id,
    required String name,
    String? email,
    String? phone,
    required Department department,
    required String registerId,
    @UTCDateTimeConverter() required DateTime registerTime,
    required String useYn,
    required String editorId,
    @UTCDateTimeConverter() required DateTime editTime
  }) = _Member;

  factory Member.create() => Member(name: "", registerId: Global.user.id!, registerTime: DateTime.now(), useYn: "Y",
        editorId: Global.user.id!, editTime: DateTime.now(), department: Department.create());

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}