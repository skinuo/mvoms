import 'package:freezed_annotation/freezed_annotation.dart';

import 'member.dart';
import 'organization.dart';
part 'department.freezed.dart';
part 'department.g.dart';

/// 부서 관리
@freezed
class Department with _$Department {
  factory Department({
    required String id,
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

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);
}