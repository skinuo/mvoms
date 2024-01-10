import 'package:freezed_annotation/freezed_annotation.dart';

import 'member.dart';
part 'requester.freezed.dart';
part 'requester.g.dart';

/// 요청자 관리
@freezed
class Requester with _$Requester {
  factory Requester({
  required String id,
  required String name,
  String? email,
  String? phone,
  String? orgName,
  String? depName,
  Member? member,
  required String registerId,
  required DateTime registerTime,
  required String useYn,
  required String editorId,
  required DateTime editTime,
  }) = _Requester;

  factory Requester.fromJson(Map<String, dynamic> json) => _$RequesterFromJson(json);
}