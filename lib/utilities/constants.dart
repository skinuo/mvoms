import 'package:flutter/material.dart';

/// 상수 관리
abstract class ConstantValues {
  ConstantValues._();

  static const Color kColorGray = Color.fromRGBO(235, 235, 235, 1);
  static const Color kColorBlue = Color.fromRGBO(135, 186, 215, 0.25);
  static const Color kColorBlue01 = Color.fromRGBO(135, 186, 215, 0.1);
  static const Color kColorBlue05 = Color.fromRGBO(135, 186, 215, 0.5);

  static const double kBodyFontSize = 12;
  static const double kDialogFontSize = 14;

  // 비밀번호 암호화 키
  static const String kEncKey = "mvsoftech07076393629j;kasjf;lksjf;ajf3foisdflkj";

  // 공통 코드
  // 상태 코드
  static const String kCodeState = "state_cd";
  // 요청 경로
  static const String kCodeReqMethod = "req_mthd_cd";
  // 요청 유형
  static const String kCodeReqType = "req_tp_cd";

  // 메시지
  static const Map<String, String> kMessages = {
    "Required": "필수입력 입니다.",
  };

  // http 상태
  static const Map<int, String> kHttpStatus = {
      461: "대상 객체가 존재하지 않음",
      462: "대상 객체가 이미 존재함",
  };
}

