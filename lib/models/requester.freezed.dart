// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'requester.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Requester _$RequesterFromJson(Map<String, dynamic> json) {
  return _Requester.fromJson(json);
}

/// @nodoc
mixin _$Requester {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get orgName => throw _privateConstructorUsedError;
  String? get depName => throw _privateConstructorUsedError;
  Member? get member => throw _privateConstructorUsedError;
  String get registerId => throw _privateConstructorUsedError;
  DateTime get registerTime => throw _privateConstructorUsedError;
  String get useYn => throw _privateConstructorUsedError;
  String get editorId => throw _privateConstructorUsedError;
  DateTime get editTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequesterCopyWith<Requester> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequesterCopyWith<$Res> {
  factory $RequesterCopyWith(Requester value, $Res Function(Requester) then) =
      _$RequesterCopyWithImpl<$Res, Requester>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? email,
      String? phone,
      String? orgName,
      String? depName,
      Member? member,
      String registerId,
      DateTime registerTime,
      String useYn,
      String editorId,
      DateTime editTime});

  $MemberCopyWith<$Res>? get member;
}

/// @nodoc
class _$RequesterCopyWithImpl<$Res, $Val extends Requester>
    implements $RequesterCopyWith<$Res> {
  _$RequesterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? orgName = freezed,
    Object? depName = freezed,
    Object? member = freezed,
    Object? registerId = null,
    Object? registerTime = null,
    Object? useYn = null,
    Object? editorId = null,
    Object? editTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      orgName: freezed == orgName
          ? _value.orgName
          : orgName // ignore: cast_nullable_to_non_nullable
              as String?,
      depName: freezed == depName
          ? _value.depName
          : depName // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$RequesterImplCopyWith<$Res>
    implements $RequesterCopyWith<$Res> {
  factory _$$RequesterImplCopyWith(
          _$RequesterImpl value, $Res Function(_$RequesterImpl) then) =
      __$$RequesterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? email,
      String? phone,
      String? orgName,
      String? depName,
      Member? member,
      String registerId,
      DateTime registerTime,
      String useYn,
      String editorId,
      DateTime editTime});

  @override
  $MemberCopyWith<$Res>? get member;
}

/// @nodoc
class __$$RequesterImplCopyWithImpl<$Res>
    extends _$RequesterCopyWithImpl<$Res, _$RequesterImpl>
    implements _$$RequesterImplCopyWith<$Res> {
  __$$RequesterImplCopyWithImpl(
      _$RequesterImpl _value, $Res Function(_$RequesterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? orgName = freezed,
    Object? depName = freezed,
    Object? member = freezed,
    Object? registerId = null,
    Object? registerTime = null,
    Object? useYn = null,
    Object? editorId = null,
    Object? editTime = null,
  }) {
    return _then(_$RequesterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      orgName: freezed == orgName
          ? _value.orgName
          : orgName // ignore: cast_nullable_to_non_nullable
              as String?,
      depName: freezed == depName
          ? _value.depName
          : depName // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$RequesterImpl implements _Requester {
  _$RequesterImpl(
      {required this.id,
      required this.name,
      this.email,
      this.phone,
      this.orgName,
      this.depName,
      this.member,
      required this.registerId,
      required this.registerTime,
      required this.useYn,
      required this.editorId,
      required this.editTime});

  factory _$RequesterImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequesterImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? orgName;
  @override
  final String? depName;
  @override
  final Member? member;
  @override
  final String registerId;
  @override
  final DateTime registerTime;
  @override
  final String useYn;
  @override
  final String editorId;
  @override
  final DateTime editTime;

  @override
  String toString() {
    return 'Requester(id: $id, name: $name, email: $email, phone: $phone, orgName: $orgName, depName: $depName, member: $member, registerId: $registerId, registerTime: $registerTime, useYn: $useYn, editorId: $editorId, editTime: $editTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequesterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.orgName, orgName) || other.orgName == orgName) &&
            (identical(other.depName, depName) || other.depName == depName) &&
            (identical(other.member, member) || other.member == member) &&
            (identical(other.registerId, registerId) ||
                other.registerId == registerId) &&
            (identical(other.registerTime, registerTime) ||
                other.registerTime == registerTime) &&
            (identical(other.useYn, useYn) || other.useYn == useYn) &&
            (identical(other.editorId, editorId) ||
                other.editorId == editorId) &&
            (identical(other.editTime, editTime) ||
                other.editTime == editTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, phone, orgName,
      depName, member, registerId, registerTime, useYn, editorId, editTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequesterImplCopyWith<_$RequesterImpl> get copyWith =>
      __$$RequesterImplCopyWithImpl<_$RequesterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequesterImplToJson(
      this,
    );
  }
}

abstract class _Requester implements Requester {
  factory _Requester(
      {required final String id,
      required final String name,
      final String? email,
      final String? phone,
      final String? orgName,
      final String? depName,
      final Member? member,
      required final String registerId,
      required final DateTime registerTime,
      required final String useYn,
      required final String editorId,
      required final DateTime editTime}) = _$RequesterImpl;

  factory _Requester.fromJson(Map<String, dynamic> json) =
      _$RequesterImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get orgName;
  @override
  String? get depName;
  @override
  Member? get member;
  @override
  String get registerId;
  @override
  DateTime get registerTime;
  @override
  String get useYn;
  @override
  String get editorId;
  @override
  DateTime get editTime;
  @override
  @JsonKey(ignore: true)
  _$$RequesterImplCopyWith<_$RequesterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
