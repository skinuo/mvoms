// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OperationEvent _$OperationEventFromJson(Map<String, dynamic> json) {
  return _OperationEvent.fromJson(json);
}

/// @nodoc
mixin _$OperationEvent {
  String get evntId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get stateCd => throw _privateConstructorUsedError;
  String get evntDesc => throw _privateConstructorUsedError;
  DateTime get evntTime => throw _privateConstructorUsedError;
  Member? get charger => throw _privateConstructorUsedError;
  String? get closeTime => throw _privateConstructorUsedError;
  TargetSystem? get targetSystem => throw _privateConstructorUsedError;
  String get registerId => throw _privateConstructorUsedError;
  DateTime get registerTime => throw _privateConstructorUsedError;
  String get useYn => throw _privateConstructorUsedError;
  String get editorId => throw _privateConstructorUsedError;
  DateTime get editTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OperationEventCopyWith<OperationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OperationEventCopyWith<$Res> {
  factory $OperationEventCopyWith(
          OperationEvent value, $Res Function(OperationEvent) then) =
      _$OperationEventCopyWithImpl<$Res, OperationEvent>;
  @useResult
  $Res call(
      {String evntId,
      String title,
      String stateCd,
      String evntDesc,
      DateTime evntTime,
      Member? charger,
      String? closeTime,
      TargetSystem? targetSystem,
      String registerId,
      DateTime registerTime,
      String useYn,
      String editorId,
      DateTime editTime});

  $MemberCopyWith<$Res>? get charger;
  $TargetSystemCopyWith<$Res>? get targetSystem;
}

/// @nodoc
class _$OperationEventCopyWithImpl<$Res, $Val extends OperationEvent>
    implements $OperationEventCopyWith<$Res> {
  _$OperationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? evntId = null,
    Object? title = null,
    Object? stateCd = null,
    Object? evntDesc = null,
    Object? evntTime = null,
    Object? charger = freezed,
    Object? closeTime = freezed,
    Object? targetSystem = freezed,
    Object? registerId = null,
    Object? registerTime = null,
    Object? useYn = null,
    Object? editorId = null,
    Object? editTime = null,
  }) {
    return _then(_value.copyWith(
      evntId: null == evntId
          ? _value.evntId
          : evntId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      stateCd: null == stateCd
          ? _value.stateCd
          : stateCd // ignore: cast_nullable_to_non_nullable
              as String,
      evntDesc: null == evntDesc
          ? _value.evntDesc
          : evntDesc // ignore: cast_nullable_to_non_nullable
              as String,
      evntTime: null == evntTime
          ? _value.evntTime
          : evntTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      charger: freezed == charger
          ? _value.charger
          : charger // ignore: cast_nullable_to_non_nullable
              as Member?,
      closeTime: freezed == closeTime
          ? _value.closeTime
          : closeTime // ignore: cast_nullable_to_non_nullable
              as String?,
      targetSystem: freezed == targetSystem
          ? _value.targetSystem
          : targetSystem // ignore: cast_nullable_to_non_nullable
              as TargetSystem?,
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
  $MemberCopyWith<$Res>? get charger {
    if (_value.charger == null) {
      return null;
    }

    return $MemberCopyWith<$Res>(_value.charger!, (value) {
      return _then(_value.copyWith(charger: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TargetSystemCopyWith<$Res>? get targetSystem {
    if (_value.targetSystem == null) {
      return null;
    }

    return $TargetSystemCopyWith<$Res>(_value.targetSystem!, (value) {
      return _then(_value.copyWith(targetSystem: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OperationEventImplCopyWith<$Res>
    implements $OperationEventCopyWith<$Res> {
  factory _$$OperationEventImplCopyWith(_$OperationEventImpl value,
          $Res Function(_$OperationEventImpl) then) =
      __$$OperationEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String evntId,
      String title,
      String stateCd,
      String evntDesc,
      DateTime evntTime,
      Member? charger,
      String? closeTime,
      TargetSystem? targetSystem,
      String registerId,
      DateTime registerTime,
      String useYn,
      String editorId,
      DateTime editTime});

  @override
  $MemberCopyWith<$Res>? get charger;
  @override
  $TargetSystemCopyWith<$Res>? get targetSystem;
}

/// @nodoc
class __$$OperationEventImplCopyWithImpl<$Res>
    extends _$OperationEventCopyWithImpl<$Res, _$OperationEventImpl>
    implements _$$OperationEventImplCopyWith<$Res> {
  __$$OperationEventImplCopyWithImpl(
      _$OperationEventImpl _value, $Res Function(_$OperationEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? evntId = null,
    Object? title = null,
    Object? stateCd = null,
    Object? evntDesc = null,
    Object? evntTime = null,
    Object? charger = freezed,
    Object? closeTime = freezed,
    Object? targetSystem = freezed,
    Object? registerId = null,
    Object? registerTime = null,
    Object? useYn = null,
    Object? editorId = null,
    Object? editTime = null,
  }) {
    return _then(_$OperationEventImpl(
      evntId: null == evntId
          ? _value.evntId
          : evntId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      stateCd: null == stateCd
          ? _value.stateCd
          : stateCd // ignore: cast_nullable_to_non_nullable
              as String,
      evntDesc: null == evntDesc
          ? _value.evntDesc
          : evntDesc // ignore: cast_nullable_to_non_nullable
              as String,
      evntTime: null == evntTime
          ? _value.evntTime
          : evntTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      charger: freezed == charger
          ? _value.charger
          : charger // ignore: cast_nullable_to_non_nullable
              as Member?,
      closeTime: freezed == closeTime
          ? _value.closeTime
          : closeTime // ignore: cast_nullable_to_non_nullable
              as String?,
      targetSystem: freezed == targetSystem
          ? _value.targetSystem
          : targetSystem // ignore: cast_nullable_to_non_nullable
              as TargetSystem?,
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
class _$OperationEventImpl implements _OperationEvent {
  _$OperationEventImpl(
      {required this.evntId,
      required this.title,
      required this.stateCd,
      required this.evntDesc,
      required this.evntTime,
      this.charger,
      this.closeTime,
      this.targetSystem,
      required this.registerId,
      required this.registerTime,
      required this.useYn,
      required this.editorId,
      required this.editTime});

  factory _$OperationEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$OperationEventImplFromJson(json);

  @override
  final String evntId;
  @override
  final String title;
  @override
  final String stateCd;
  @override
  final String evntDesc;
  @override
  final DateTime evntTime;
  @override
  final Member? charger;
  @override
  final String? closeTime;
  @override
  final TargetSystem? targetSystem;
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
    return 'OperationEvent(evntId: $evntId, title: $title, stateCd: $stateCd, evntDesc: $evntDesc, evntTime: $evntTime, charger: $charger, closeTime: $closeTime, targetSystem: $targetSystem, registerId: $registerId, registerTime: $registerTime, useYn: $useYn, editorId: $editorId, editTime: $editTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OperationEventImpl &&
            (identical(other.evntId, evntId) || other.evntId == evntId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.stateCd, stateCd) || other.stateCd == stateCd) &&
            (identical(other.evntDesc, evntDesc) ||
                other.evntDesc == evntDesc) &&
            (identical(other.evntTime, evntTime) ||
                other.evntTime == evntTime) &&
            (identical(other.charger, charger) || other.charger == charger) &&
            (identical(other.closeTime, closeTime) ||
                other.closeTime == closeTime) &&
            (identical(other.targetSystem, targetSystem) ||
                other.targetSystem == targetSystem) &&
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
  int get hashCode => Object.hash(
      runtimeType,
      evntId,
      title,
      stateCd,
      evntDesc,
      evntTime,
      charger,
      closeTime,
      targetSystem,
      registerId,
      registerTime,
      useYn,
      editorId,
      editTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OperationEventImplCopyWith<_$OperationEventImpl> get copyWith =>
      __$$OperationEventImplCopyWithImpl<_$OperationEventImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OperationEventImplToJson(
      this,
    );
  }
}

abstract class _OperationEvent implements OperationEvent {
  factory _OperationEvent(
      {required final String evntId,
      required final String title,
      required final String stateCd,
      required final String evntDesc,
      required final DateTime evntTime,
      final Member? charger,
      final String? closeTime,
      final TargetSystem? targetSystem,
      required final String registerId,
      required final DateTime registerTime,
      required final String useYn,
      required final String editorId,
      required final DateTime editTime}) = _$OperationEventImpl;

  factory _OperationEvent.fromJson(Map<String, dynamic> json) =
      _$OperationEventImpl.fromJson;

  @override
  String get evntId;
  @override
  String get title;
  @override
  String get stateCd;
  @override
  String get evntDesc;
  @override
  DateTime get evntTime;
  @override
  Member? get charger;
  @override
  String? get closeTime;
  @override
  TargetSystem? get targetSystem;
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
  _$$OperationEventImplCopyWith<_$OperationEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
