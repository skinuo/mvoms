// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Organization _$OrganizationFromJson(Map<String, dynamic> json) {
  return _Organization.fromJson(json);
}

/// @nodoc
mixin _$Organization {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  set name(String value) => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  set email(String? value) => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  set phone(String? value) => throw _privateConstructorUsedError;
  String get registerId => throw _privateConstructorUsedError;
  set registerId(String value) => throw _privateConstructorUsedError;
  @UTCDateTimeConverter()
  DateTime get registerTime => throw _privateConstructorUsedError;
  @UTCDateTimeConverter()
  set registerTime(DateTime value) => throw _privateConstructorUsedError;
  String get useYn => throw _privateConstructorUsedError;
  set useYn(String value) => throw _privateConstructorUsedError;
  String get editorId => throw _privateConstructorUsedError;
  set editorId(String value) => throw _privateConstructorUsedError;
  @UTCDateTimeConverter()
  DateTime get editTime => throw _privateConstructorUsedError;
  @UTCDateTimeConverter()
  set editTime(DateTime value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrganizationCopyWith<Organization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationCopyWith<$Res> {
  factory $OrganizationCopyWith(
          Organization value, $Res Function(Organization) then) =
      _$OrganizationCopyWithImpl<$Res, Organization>;
  @useResult
  $Res call(
      {String? id,
      String name,
      String? email,
      String? phone,
      String registerId,
      @UTCDateTimeConverter() DateTime registerTime,
      String useYn,
      String editorId,
      @UTCDateTimeConverter() DateTime editTime});
}

/// @nodoc
class _$OrganizationCopyWithImpl<$Res, $Val extends Organization>
    implements $OrganizationCopyWith<$Res> {
  _$OrganizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? email = freezed,
    Object? phone = freezed,
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
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
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
}

/// @nodoc
abstract class _$$OrganizationImplCopyWith<$Res>
    implements $OrganizationCopyWith<$Res> {
  factory _$$OrganizationImplCopyWith(
          _$OrganizationImpl value, $Res Function(_$OrganizationImpl) then) =
      __$$OrganizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      String? email,
      String? phone,
      String registerId,
      @UTCDateTimeConverter() DateTime registerTime,
      String useYn,
      String editorId,
      @UTCDateTimeConverter() DateTime editTime});
}

/// @nodoc
class __$$OrganizationImplCopyWithImpl<$Res>
    extends _$OrganizationCopyWithImpl<$Res, _$OrganizationImpl>
    implements _$$OrganizationImplCopyWith<$Res> {
  __$$OrganizationImplCopyWithImpl(
      _$OrganizationImpl _value, $Res Function(_$OrganizationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? registerId = null,
    Object? registerTime = null,
    Object? useYn = null,
    Object? editorId = null,
    Object? editTime = null,
  }) {
    return _then(_$OrganizationImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$OrganizationImpl implements _Organization {
  _$OrganizationImpl(
      {this.id,
      required this.name,
      this.email,
      this.phone,
      required this.registerId,
      @UTCDateTimeConverter() required this.registerTime,
      required this.useYn,
      required this.editorId,
      @UTCDateTimeConverter() required this.editTime});

  factory _$OrganizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationImplFromJson(json);

  @override
  String? id;
  @override
  String name;
  @override
  String? email;
  @override
  String? phone;
  @override
  String registerId;
  @override
  @UTCDateTimeConverter()
  DateTime registerTime;
  @override
  String useYn;
  @override
  String editorId;
  @override
  @UTCDateTimeConverter()
  DateTime editTime;

  @override
  String toString() {
    return 'Organization(id: $id, name: $name, email: $email, phone: $phone, registerId: $registerId, registerTime: $registerTime, useYn: $useYn, editorId: $editorId, editTime: $editTime)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationImplCopyWith<_$OrganizationImpl> get copyWith =>
      __$$OrganizationImplCopyWithImpl<_$OrganizationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationImplToJson(
      this,
    );
  }
}

abstract class _Organization implements Organization {
  factory _Organization(
      {String? id,
      required String name,
      String? email,
      String? phone,
      required String registerId,
      @UTCDateTimeConverter() required DateTime registerTime,
      required String useYn,
      required String editorId,
      @UTCDateTimeConverter() required DateTime editTime}) = _$OrganizationImpl;

  factory _Organization.fromJson(Map<String, dynamic> json) =
      _$OrganizationImpl.fromJson;

  @override
  String? get id;
  set id(String? value);
  @override
  String get name;
  set name(String value);
  @override
  String? get email;
  set email(String? value);
  @override
  String? get phone;
  set phone(String? value);
  @override
  String get registerId;
  set registerId(String value);
  @override
  @UTCDateTimeConverter()
  DateTime get registerTime;
  @UTCDateTimeConverter()
  set registerTime(DateTime value);
  @override
  String get useYn;
  set useYn(String value);
  @override
  String get editorId;
  set editorId(String value);
  @override
  @UTCDateTimeConverter()
  DateTime get editTime;
  @UTCDateTimeConverter()
  set editTime(DateTime value);
  @override
  @JsonKey(ignore: true)
  _$$OrganizationImplCopyWith<_$OrganizationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
