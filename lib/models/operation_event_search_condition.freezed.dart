// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation_event_search_condition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OperationEventSearchCondition _$OperationEventSearchConditionFromJson(
    Map<String, dynamic> json) {
  return _OperationEventSearchCondition.fromJson(json);
}

/// @nodoc
mixin _$OperationEventSearchCondition {
/** 제목 유사검색 조건 */
  String? get titleLike => throw _privateConstructorUsedError;
  /** 제목 유사검색 조건 */
  set titleLike(String? value) => throw _privateConstructorUsedError;
  /** 이벤트 설명 유사검색 조건 */
  String? get evntDescLike => throw _privateConstructorUsedError;
  /** 이벤트 설명 유사검색 조건 */
  set evntDescLike(String? value) => throw _privateConstructorUsedError;
  /** 상태 코드 */
  String? get stateCd => throw _privateConstructorUsedError;
  /** 상태 코드 */
  set stateCd(String? value) => throw _privateConstructorUsedError;
  /** 발생일시 시작 */
  DateTime? get evntTimeStart => throw _privateConstructorUsedError;
  /** 발생일시 시작 */
  set evntTimeStart(DateTime? value) => throw _privateConstructorUsedError;
  /** 발생일시 끝 */
  DateTime? get evntTimeEnd => throw _privateConstructorUsedError;
  /** 발생일시 끝 */
  set evntTimeEnd(DateTime? value) => throw _privateConstructorUsedError;
  /** 종결일시 시작 */
  DateTime? get closeTimeStart => throw _privateConstructorUsedError;
  /** 종결일시 시작 */
  set closeTimeStart(DateTime? value) => throw _privateConstructorUsedError;
  /** 종결일시 끝 */
  DateTime? get closeTimeEnd => throw _privateConstructorUsedError;
  /** 종결일시 끝 */
  set closeTimeEnd(DateTime? value) => throw _privateConstructorUsedError;
  /** 의뢰자명 유사검색 */
  String? get requesterNameLike => throw _privateConstructorUsedError;
  /** 의뢰자명 유사검색 */
  set requesterNameLike(String? value) => throw _privateConstructorUsedError;
  /** 처리자명 유사검색 */
  String? get chargerNameLike => throw _privateConstructorUsedError;
  /** 처리자명 유사검색 */
  set chargerNameLike(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OperationEventSearchConditionCopyWith<OperationEventSearchCondition>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OperationEventSearchConditionCopyWith<$Res> {
  factory $OperationEventSearchConditionCopyWith(
          OperationEventSearchCondition value,
          $Res Function(OperationEventSearchCondition) then) =
      _$OperationEventSearchConditionCopyWithImpl<$Res,
          OperationEventSearchCondition>;
  @useResult
  $Res call(
      {String? titleLike,
      String? evntDescLike,
      String? stateCd,
      DateTime? evntTimeStart,
      DateTime? evntTimeEnd,
      DateTime? closeTimeStart,
      DateTime? closeTimeEnd,
      String? requesterNameLike,
      String? chargerNameLike});
}

/// @nodoc
class _$OperationEventSearchConditionCopyWithImpl<$Res,
        $Val extends OperationEventSearchCondition>
    implements $OperationEventSearchConditionCopyWith<$Res> {
  _$OperationEventSearchConditionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleLike = freezed,
    Object? evntDescLike = freezed,
    Object? stateCd = freezed,
    Object? evntTimeStart = freezed,
    Object? evntTimeEnd = freezed,
    Object? closeTimeStart = freezed,
    Object? closeTimeEnd = freezed,
    Object? requesterNameLike = freezed,
    Object? chargerNameLike = freezed,
  }) {
    return _then(_value.copyWith(
      titleLike: freezed == titleLike
          ? _value.titleLike
          : titleLike // ignore: cast_nullable_to_non_nullable
              as String?,
      evntDescLike: freezed == evntDescLike
          ? _value.evntDescLike
          : evntDescLike // ignore: cast_nullable_to_non_nullable
              as String?,
      stateCd: freezed == stateCd
          ? _value.stateCd
          : stateCd // ignore: cast_nullable_to_non_nullable
              as String?,
      evntTimeStart: freezed == evntTimeStart
          ? _value.evntTimeStart
          : evntTimeStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      evntTimeEnd: freezed == evntTimeEnd
          ? _value.evntTimeEnd
          : evntTimeEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      closeTimeStart: freezed == closeTimeStart
          ? _value.closeTimeStart
          : closeTimeStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      closeTimeEnd: freezed == closeTimeEnd
          ? _value.closeTimeEnd
          : closeTimeEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requesterNameLike: freezed == requesterNameLike
          ? _value.requesterNameLike
          : requesterNameLike // ignore: cast_nullable_to_non_nullable
              as String?,
      chargerNameLike: freezed == chargerNameLike
          ? _value.chargerNameLike
          : chargerNameLike // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OperationEventSearchConditionImplCopyWith<$Res>
    implements $OperationEventSearchConditionCopyWith<$Res> {
  factory _$$OperationEventSearchConditionImplCopyWith(
          _$OperationEventSearchConditionImpl value,
          $Res Function(_$OperationEventSearchConditionImpl) then) =
      __$$OperationEventSearchConditionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? titleLike,
      String? evntDescLike,
      String? stateCd,
      DateTime? evntTimeStart,
      DateTime? evntTimeEnd,
      DateTime? closeTimeStart,
      DateTime? closeTimeEnd,
      String? requesterNameLike,
      String? chargerNameLike});
}

/// @nodoc
class __$$OperationEventSearchConditionImplCopyWithImpl<$Res>
    extends _$OperationEventSearchConditionCopyWithImpl<$Res,
        _$OperationEventSearchConditionImpl>
    implements _$$OperationEventSearchConditionImplCopyWith<$Res> {
  __$$OperationEventSearchConditionImplCopyWithImpl(
      _$OperationEventSearchConditionImpl _value,
      $Res Function(_$OperationEventSearchConditionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleLike = freezed,
    Object? evntDescLike = freezed,
    Object? stateCd = freezed,
    Object? evntTimeStart = freezed,
    Object? evntTimeEnd = freezed,
    Object? closeTimeStart = freezed,
    Object? closeTimeEnd = freezed,
    Object? requesterNameLike = freezed,
    Object? chargerNameLike = freezed,
  }) {
    return _then(_$OperationEventSearchConditionImpl(
      titleLike: freezed == titleLike
          ? _value.titleLike
          : titleLike // ignore: cast_nullable_to_non_nullable
              as String?,
      evntDescLike: freezed == evntDescLike
          ? _value.evntDescLike
          : evntDescLike // ignore: cast_nullable_to_non_nullable
              as String?,
      stateCd: freezed == stateCd
          ? _value.stateCd
          : stateCd // ignore: cast_nullable_to_non_nullable
              as String?,
      evntTimeStart: freezed == evntTimeStart
          ? _value.evntTimeStart
          : evntTimeStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      evntTimeEnd: freezed == evntTimeEnd
          ? _value.evntTimeEnd
          : evntTimeEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      closeTimeStart: freezed == closeTimeStart
          ? _value.closeTimeStart
          : closeTimeStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      closeTimeEnd: freezed == closeTimeEnd
          ? _value.closeTimeEnd
          : closeTimeEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requesterNameLike: freezed == requesterNameLike
          ? _value.requesterNameLike
          : requesterNameLike // ignore: cast_nullable_to_non_nullable
              as String?,
      chargerNameLike: freezed == chargerNameLike
          ? _value.chargerNameLike
          : chargerNameLike // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OperationEventSearchConditionImpl
    implements _OperationEventSearchCondition {
  _$OperationEventSearchConditionImpl(
      {this.titleLike,
      this.evntDescLike,
      this.stateCd,
      this.evntTimeStart,
      this.evntTimeEnd,
      this.closeTimeStart,
      this.closeTimeEnd,
      this.requesterNameLike,
      this.chargerNameLike});

  factory _$OperationEventSearchConditionImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$OperationEventSearchConditionImplFromJson(json);

/** 제목 유사검색 조건 */
  @override
  String? titleLike;
/** 이벤트 설명 유사검색 조건 */
  @override
  String? evntDescLike;
/** 상태 코드 */
  @override
  String? stateCd;
/** 발생일시 시작 */
  @override
  DateTime? evntTimeStart;
/** 발생일시 끝 */
  @override
  DateTime? evntTimeEnd;
/** 종결일시 시작 */
  @override
  DateTime? closeTimeStart;
/** 종결일시 끝 */
  @override
  DateTime? closeTimeEnd;
/** 의뢰자명 유사검색 */
  @override
  String? requesterNameLike;
/** 처리자명 유사검색 */
  @override
  String? chargerNameLike;

  @override
  String toString() {
    return 'OperationEventSearchCondition(titleLike: $titleLike, evntDescLike: $evntDescLike, stateCd: $stateCd, evntTimeStart: $evntTimeStart, evntTimeEnd: $evntTimeEnd, closeTimeStart: $closeTimeStart, closeTimeEnd: $closeTimeEnd, requesterNameLike: $requesterNameLike, chargerNameLike: $chargerNameLike)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OperationEventSearchConditionImplCopyWith<
          _$OperationEventSearchConditionImpl>
      get copyWith => __$$OperationEventSearchConditionImplCopyWithImpl<
          _$OperationEventSearchConditionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OperationEventSearchConditionImplToJson(
      this,
    );
  }
}

abstract class _OperationEventSearchCondition
    implements OperationEventSearchCondition {
  factory _OperationEventSearchCondition(
      {String? titleLike,
      String? evntDescLike,
      String? stateCd,
      DateTime? evntTimeStart,
      DateTime? evntTimeEnd,
      DateTime? closeTimeStart,
      DateTime? closeTimeEnd,
      String? requesterNameLike,
      String? chargerNameLike}) = _$OperationEventSearchConditionImpl;

  factory _OperationEventSearchCondition.fromJson(Map<String, dynamic> json) =
      _$OperationEventSearchConditionImpl.fromJson;

  @override
  /** 제목 유사검색 조건 */
  String? get titleLike;
  /** 제목 유사검색 조건 */
  set titleLike(String? value);
  @override
  /** 이벤트 설명 유사검색 조건 */
  String? get evntDescLike;
  /** 이벤트 설명 유사검색 조건 */
  set evntDescLike(String? value);
  @override
  /** 상태 코드 */
  String? get stateCd;
  /** 상태 코드 */
  set stateCd(String? value);
  @override
  /** 발생일시 시작 */
  DateTime? get evntTimeStart;
  /** 발생일시 시작 */
  set evntTimeStart(DateTime? value);
  @override
  /** 발생일시 끝 */
  DateTime? get evntTimeEnd;
  /** 발생일시 끝 */
  set evntTimeEnd(DateTime? value);
  @override
  /** 종결일시 시작 */
  DateTime? get closeTimeStart;
  /** 종결일시 시작 */
  set closeTimeStart(DateTime? value);
  @override
  /** 종결일시 끝 */
  DateTime? get closeTimeEnd;
  /** 종결일시 끝 */
  set closeTimeEnd(DateTime? value);
  @override
  /** 의뢰자명 유사검색 */
  String? get requesterNameLike;
  /** 의뢰자명 유사검색 */
  set requesterNameLike(String? value);
  @override
  /** 처리자명 유사검색 */
  String? get chargerNameLike;
  /** 처리자명 유사검색 */
  set chargerNameLike(String? value);
  @override
  @JsonKey(ignore: true)
  _$$OperationEventSearchConditionImplCopyWith<
          _$OperationEventSearchConditionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
