import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mvoms/utilities/global.dart';

import 'member.dart';
import 'organization.dart';
part 'department.freezed.dart';
part 'department.g.dart';

/// 부서 관리
@unfreezed
class Department with _$Department {
  factory Department({
    String? id,
    required String name,
    required Organization organization,
    Department? superDepartment,
    Member? member,
    required String registerId,
    required DateTime registerTime,
    required String useYn,
    required String editorId,
    required DateTime editTime
  }) = _Department;

  factory Department.create() => Department(name: "", registerId: Global.user.id!, registerTime: DateTime.now(),
      useYn: "Y", editorId: Global.user.id!, editTime: DateTime.now(), organization: Organization.create());

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);
}