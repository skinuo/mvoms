import 'package:freezed_annotation/freezed_annotation.dart';
part 'organization.freezed.dart';
part 'organization.g.dart';

/// 기관 관리
@freezed
class Organization with _$Organization {
  factory Organization({
    required String id,
    required String name,
    String? email,
    String? phone,
    required String registerId,
    required DateTime registerTime,
    required String useYn,
    required String editorId,
    required DateTime editTime,
  }) = _Organization;

  factory Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);
}