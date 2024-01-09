import 'package:freezed_annotation/freezed_annotation.dart';

import 'department.dart';
part 'member.freezed.dart';
part 'member.g.dart';

/// 사용자 관리
@freezed
class Member with _$Member {
  factory Member({
    required String id,
    required String name,
    String? email,
    String? phone,
    required Department department,

    required String registerId,
    required DateTime registerTime,
    required String useYn,
    required String editorId,
    required DateTime editTime
  }) = _Member;
factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}