// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'department.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Department _$DepartmentFromJson(Map<String, dynamic> json) {
  return _Department.fromJson(json);
}

/// @nodoc
mixin _$Department {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  set name(String value) => throw _privateConstructorUsedError;
  Organization get organization => throw _privateConstructorUsedError;
  set organization(Organization value) => throw _privateConstructorUsedError;
  Department? get superDepartment => throw _privateConstructorUsedError;
  set superDepartment(Department? value) => throw _privateConstructorUsedError;
  Member? get member => throw _privateConstructorUsedError;
  set member(Member? value) => throw _privateConstructorUsedError;
  String get registerId => throw _privateConstructorUsedError;
  set registerId(String value) => throw _privateConstructorUsedError;
  DateTime get registerTime => throw _privateConstructorUsedError;
  set registerTime(DateTime value) => throw _privateConstructorUsedError;
  String get useYn => throw _privateConstructorUsedError;
  set useYn(String value) => throw _privateConstructorUsedError;
  String get editorId => throw _privateConstructorUsedError;
  set editorId(String value) => throw _privateConstructorUsedError;
  DateTime get editTime => throw _privateConstructorUsedError;
  set editTime(DateTime value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DepartmentCopyWith<Department> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepartmentCopyWith<$Res> {
  factory $DepartmentCopyWith(
          Department value, $Res Function(Department) then) =
      _$DepartmentCopyWithImpl<$Res, Department>;
  @useResult
  $Res call(
      {String? id,
      String name,
      Organization organization,
      Department? superDepartment,
      Member? member,
      String registerId,
      DateTime registerTime,
      String useYn,
      String editorId,
      DateTime editTime});

  $OrganizationCopyWith<$Res> get organization;
  $DepartmentCopyWith<$Res>? get superDepartment;
  $MemberCopyWith<$Res>? get member;
}

/// @nodoc
class _$DepartmentCopyWithImpl<$Res, $Val extends Department>
    implements $DepartmentCopyWith<$Res> {
  _$DepartmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? organization = null,
    Object? superDepartment = freezed,
    Object? member = freezed,
    Object? registerId = null,
    Object? registerTime = null,
    Object? useYn = null,
    Object? editorId = null,
    Object? editTime = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      organization: null == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as Organization,
      superDepartment: freezed == superDepartment
          ? _value.superDepartment
          : superDepartment // ignore: cast_nullable_to_non_nullable
              as Department?,
      member: freezed == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as Member?,
      registerId: null == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String,
      registerTime: null == registerTime
          ? _value.registerTime
          : registerTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      useYn: null == useYn
          ? _value.useYn
          : useYn // ignore: cast_nullable_to_non_nullable
              as String,
      editorId: null == editorId
          ? _value.editorId
          : editorId // ignore: cast_nullable_to_non_nullable
              as String,
      editTime: null == editTime
          ? _value.editTime
          : editTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrganizationCopyWith<$Res> get organization {
    return $OrganizationCopyWith<$Res>(_value.organization, (value) {
      return _then(_value.copyWith(organization: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DepartmentCopyWith<$Res>? get superDepartment {
    if (_value.superDepartment == null) {
      return null;
    }

    return $DepartmentCopyWith<$Res>(_value.superDepartment!, (value) {
      return _then(_value.copyWith(superDepartment: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MemberCopyWith<$Res>? get member {
    if (_value.member == null) {
      return null;
    }

    return $MemberCopyWith<$Res>(_value.member!, (value) {
      return _then(_value.copyWith(member: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DepartmentImplCopyWith<$Res>
    implements $DepartmentCopyWith<$Res> {
  factory _$$DepartmentImplCopyWith(
          _$DepartmentImpl value, $Res Function(_$DepartmentImpl) then) =
      __$$DepartmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      Organization organization,
      Department? superDepartment,
      Member? member,
      String registerId,
      DateTime registerTime,
      String useYn,
      String editorId,
      DateTime editTime});

  @override
  $OrganizationCopyWith<$Res> get organization;
  @override
  $DepartmentCopyWith<$Res>? get superDepartment;
  @override
  $MemberCopyWith<$Res>? get member;
}

/// @nodoc
class __$$DepartmentImplCopyWithImpl<$Res>
    extends _$DepartmentCopyWithImpl<$Res, _$DepartmentImpl>
    implements _$$DepartmentImplCopyWith<$Res> {
  __$$DepartmentImplCopyWithImpl(
      _$DepartmentImpl _value, $Res Function(_$DepartmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? organization = null,
    Object? superDepartment = freezed,
    Object? member = freezed,
    Object? registerId = null,
    Object? registerTime = null,
    Object? useYn = null,
    Object? editorId = null,
    Object? editTime = null,
  }) {
    return _then(_$DepartmentImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      organization: null == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as Organization,
      superDepartment: freezed == superDepartment
          ? _value.superDepartment
          : superDepartment // ignore: cast_nullable_to_non_nullable
              as Department?,
      member: freezed == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as Member?,
      registerId: null == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String,
      registerTime: null == registerTime
          ? _value.registerTime
          : registerTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      useYn: null == useYn
          ? _value.useYn
          : useYn // ignore: cast_nullable_to_non_nullable
              as String,
      editorId: null == editorId
          ? _value.editorId
          : editorId // ignore: cast_nullable_to_non_nullable
              as String,
      editTime: null == editTime
          ? _value.editTime
          : editTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DepartmentImpl implements _Department {
  _$DepartmentImpl(
      {this.id,
      required this.name,
      required this.organization,
      this.superDepartment,
      this.member,
      required this.registerId,
      required this.registerTime,
      required this.useYn,
      required this.editorId,
      required this.editTime});

  factory _$DepartmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DepartmentImplFromJson(json);

  @override
  String? id;
  @override
  String name;
  @override
  Organization organization;
  @override
  Department? superDepartment;
  @override
  Member? member;
  @override
  String registerId;
  @override
  DateTime registerTime;
  @override
  String useYn;
  @override
  String editorId;
  @override
  DateTime editTime;

  @override
  String toString() {
    return 'Department(id: $id, name: $name, organization: $organization, superDepartment: $superDepartment, member: $member, registerId: $registerId, registerTime: $registerTime, useYn: $useYn, editorId: $editorId, editTime: $editTime)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DepartmentImplCopyWith<_$DepartmentImpl> get copyWith =>
      __$$DepartmentImplCopyWithImpl<_$DepartmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DepartmentImplToJson(
      this,
    );
  }
}

abstract class _Department implements Department {
  factory _Department(
      {String? id,
      required String name,
      required Organization organization,
      Department? superDepartment,
      Member? member,
      required String registerId,
      required DateTime registerTime,
      required String useYn,
      required String editorId,
      required DateTime editTime}) = _$DepartmentImpl;

  factory _Department.fromJson(Map<String, dynamic> json) =
      _$DepartmentImpl.fromJson;

  @override
  String? get id;
  set id(String? value);
  @override
  String get name;
  set name(String value);
  @override
  Organization get organization;
  set organization(Organization value);
  @override
  Department? get superDepartment;
  set superDepartment(Department? value);
  @override
  Member? get member;
  set member(Member? value);
  @override
  String get registerId;
  set registerId(String value);
  @override
  DateTime get registerTime;
  set registerTime(DateTime value);
  @override
  String get useYn;
  set useYn(String value);
  @override
  String get editorId;
  set editorId(String value);
  @override
  DateTime get editTime;
  set editTime(DateTime value);
  @override
  @JsonKey(ignore: true)
  _$$DepartmentImplCopyWith<_$DepartmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
