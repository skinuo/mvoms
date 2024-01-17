import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mvoms/utilities/UTCDateTimeConverter.dart';
import 'package:mvoms/utilities/global.dart';
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
    @UTCDateTimeConverter() required DateTime registerTime,
    required String useYn,
    required String editorId,
    @UTCDateTimeConverter() required DateTime editTime,
  }) = _Organization;

  factory Organization.create() => Organization(name: "", registerId: Global.user.id!,
      registerTime: DateTime.now(), useYn: "Y", editorId: Global.user.id!, editTime: DateTime.now());

  factory Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);
}