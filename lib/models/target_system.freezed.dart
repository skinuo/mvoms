// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'target_system.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TargetSystem _$TargetSystemFromJson(Map<String, dynamic> json) {
  return _TargetSystem.fromJson(json);
}

/// @nodoc
mixin _$TargetSystem {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  set name(String value) => throw _privateConstructorUsedError;
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
  $TargetSystemCopyWith<TargetSystem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TargetSystemCopyWith<$Res> {
  factory $TargetSystemCopyWith(
          TargetSystem value, $Res Function(TargetSystem) then) =
      _$TargetSystemCopyWithImpl<$Res, TargetSystem>;
  @useResult
  $Res call(
      {String id,
      String name,
      String registerId,
      DateTime registerTime,
      String useYn,
      String editorId,
      DateTime editTime});
}

/// @nodoc
class _$TargetSystemCopyWithImpl<$Res, $Val extends TargetSystem>
    implements $TargetSystemCopyWith<$Res> {
  _$TargetSystemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
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
abstract class _$$TargetSystemImplCopyWith<$Res>
    implements $TargetSystemCopyWith<$Res> {
  factory _$$TargetSystemImplCopyWith(
          _$TargetSystemImpl value, $Res Function(_$TargetSystemImpl) then) =
      __$$TargetSystemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String registerId,
      DateTime registerTime,
      String useYn,
      String editorId,
      DateTime editTime});
}

/// @nodoc
class __$$TargetSystemImplCopyWithImpl<$Res>
    extends _$TargetSystemCopyWithImpl<$Res, _$TargetSystemImpl>
    implements _$$TargetSystemImplCopyWith<$Res> {
  __$$TargetSystemImplCopyWithImpl(
      _$TargetSystemImpl _value, $Res Function(_$TargetSystemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? registerId = null,
    Object? registerTime = null,
    Object? useYn = null,
    Object? editorId = null,
    Object? editTime = null,
  }) {
    return _then(_$TargetSystemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$TargetSystemImpl implements _TargetSystem {
  _$TargetSystemImpl(
      {required this.id,
      required this.name,
      required this.registerId,
      required this.registerTime,
      required this.useYn,
      required this.editorId,
      required this.editTime});

  factory _$TargetSystemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TargetSystemImplFromJson(json);

  @override
  String id;
  @override
  String name;
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
    return 'TargetSystem(id: $id, name: $name, registerId: $registerId, registerTime: $registerTime, useYn: $useYn, editorId: $editorId, editTime: $editTime)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TargetSystemImplCopyWith<_$TargetSystemImpl> get copyWith =>
      __$$TargetSystemImplCopyWithImpl<_$TargetSystemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TargetSystemImplToJson(
      this,
    );
  }
}

abstract class _TargetSystem implements TargetSystem {
  factory _TargetSystem(
      {required String id,
      required String name,
      required String registerId,
      required DateTime registerTime,
      required String useYn,
      required String editorId,
      required DateTime editTime}) = _$TargetSystemImpl;

  factory _TargetSystem.fromJson(Map<String, dynamic> json) =
      _$TargetSystemImpl.fromJson;

  @override
  String get id;
  set id(String value);
  @override
  String get name;
  set name(String value);
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
  _$$TargetSystemImplCopyWith<_$TargetSystemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
