import '../models/common_code.dart';

// 전역 객체 관리
class Global {
  // 공통코드
  static final Map<String, List<CommonCode>> _comCodes = {};
  static final Map<String, Map<String,CommonCode>> _comCodeMap = {};

  /// 공통코드 조회
  ///
  /// - [id]: 코드아이디
  static List<CommonCode> getComCode(String id) {
    return _comCodes[id]!;
  }

  /// 공통코드 추가
  ///
  /// - [id]: id
  /// - [comCodes]: 코드목록
  static void addComCode(String id, List<CommonCode> comCodes) {
    _comCodes[id] = comCodes;
    _comCodeMap[id] = {};
    for (var c in comCodes) {
      _comCodeMap[id]![c.code] = c;
    }
  }

  /// 키로 공통코드 반환
  ///
  /// - [id]: id
  /// - [code]: code
  static CommonCode getComCodeByKey(String id, String code) => _comCodeMap[id]![code]!;

  /// 공통코드 이름 반환
  ///
  /// - [id]: id
  /// - [code]: code
  static String? getComCodeName(String id, String code) => getComCodeByKey(id, code).name;
}