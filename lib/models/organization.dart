import 'package:freezed_annotation/freezed_annotation.dart';
part 'organization.freezed.dart';
part 'organization.g.dart';

/// 기관 관리
@unfreezed
class Organization with _$Organization {
  factory Organization({
    String? id,
    required String name,
    String? email,
    String? phone,
    required String registerId,
    required DateTime registerTime,
    required String useYn,
    required String editorId,
    required DateTime editTime,
  }) = _Organization;

  factory Organization.create() => Organization(name: "", registerId: "",
      registerTime: DateTime.now(), useYn: "Y", editorId: "", editTime: DateTime.now());

  factory Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);
}