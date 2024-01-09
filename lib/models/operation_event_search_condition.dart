import 'package:intl/intl.dart';

/// 이벤트 검색 관리
class OperationEventSearchCondition {
  /** 제목 유사검색 조건 */
  String? titleLike;
  /** 이벤트 설명 유사검색 조건 */
  String? evntDescLike;
  /** 상태 코드 */
  String? stateCd;
  /** 발생일시 시작 */
  DateTime? evntTimeStart;
  /** 발생일시 끝 */
  DateTime? evntTimeEnd;
  /** 종결일시 시작 */
  DateTime? closeTimeStart;
  /** 종결일시 끝 */
  DateTime? closeTimeEnd;
  /** 의뢰자명 유사검색 */
  String? requesterNameLike;
  /** 처리자명 유사검색 */
  String? chargerNameLike;

  OperationEventSearchCondition(){}

  static OperationEventSearchCondition fromJson(Map<String, dynamic> json) {
    var cond = OperationEventSearchCondition();
    cond.titleLike = json['titleLike'];
    cond.evntDescLike = json['evntDescLike'];
    cond.stateCd = json['stateCd'];
    cond.evntTimeStart = json['evntTimeStart'] == null ? DateFormat('yyyy-MM-dd').parse(json['evntTimeStart']) : null;
    cond.evntTimeEnd = json['evntTimeEnd'] == null ? DateFormat('yyyy-MM-dd').parse(json['evntTimeEnd']) : null;
    cond.closeTimeStart = json['closeTimeStart'] == null ? DateFormat('yyyy-MM-dd').parse(json['closeTimeStart']) : null;
    cond.closeTimeEnd = json['closeTimeEnd'] == null ? DateFormat('yyyy-MM-dd').parse(json['closeTimeEnd']) : null;
    cond.requesterNameLike = json['titleLike'];
    cond.chargerNameLike = json['titleLike'];
    return cond;
  }
}