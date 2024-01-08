import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../models/common_code.dart';

mixin Common {
  // 공통코드
  static Map<String, List<CommonCode>> _comCodes = {};
  static Map<String, Map<String,CommonCode>> _comCodeMap = {};

  /// 공통코드 조회
  ///
  /// - [id]: 코드아이디
  static List<CommonCode> getComCode(String id) => _comCodes[id]!;

  /// 공통코드 쓰기
  ///
  /// - [comCodes]: 공통코드
  static set setComCodes(Map<String, List<CommonCode>> comCodes) => _comCodes = comCodes;

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
  static CommonCode? getComCodeByKey(String id, String code) => _comCodeMap[id]?[code];

  /// 공통코드 이름 반환
  ///
  /// - [id]: id
  /// - [code]: code
  static String? getComCodeName(String id, String code) => getComCodeByKey(id, code)?.name;

  /// 드랍다운 셀 생성
  ///
  /// - [item]: 아이템 목록
  /// - [value]: 최초 값
  /// - [callback]: 아이템 선택 후 호출
  /// - [decoration]: 셀박스 데코레이션
  /// - [fontSize]: 폰트사이즈
  /// - [disabledText]: 비활성텍스트
  Widget makeCellWithDropdown({
      required List item,
      required String value,
      Function? callback,
      InputDecoration? decoration,
      double? fontSize,
      bool disabled = false
    }) {
    decoration ??= const InputDecoration();
    return DropdownButtonFormField2(
        style: fontSize != null ? TextStyle(fontSize: fontSize) : null,
        decoration: decoration,
        isExpanded: true,
        disabledHint: disabled ? Text(value) : null,
        onChanged: !disabled ? (item) {
          print(item);
          callback?.call(item);
        } : null,
        items: item.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        value: value
    );
  }

  /// input 데코레이션 생성
  InputDecoration makeInputDecoration({
      String? labelText,
      bool required = false,
    }) {
    return InputDecoration(
        labelStyle: labelText != null ? TextStyle(fontSize: 12, color: required ? Colors.red : Colors.grey) : null,
        labelText: labelText != null ? labelText + (required ? " *" : "") : null,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey,
              width: 1),
        ),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(
            color: Colors.grey,
            width: 1),
        ),
        isDense: true,
        contentPadding: EdgeInsets.all(12),
        counterText: ""
    );
  }

  /// 텍스트 셀 생성
  TextField makeTextCell({
    String? labelText,
    bool required = false,
    bool onlyNumber = false,
    int maxLength = 10,
    bool readOnly = false,
    int maxLines = 1,
    InputDecoration? decoration,
    double? fontSize,
    TextEditingController? controller
  }) {
    decoration ??= const InputDecoration();
    return TextField(
      style: fontSize != null ? TextStyle(fontSize: fontSize) : null,
      readOnly: readOnly,
      textInputAction: TextInputAction.newline,
      decoration: decoration,
      maxLength: maxLength,
      maxLines: maxLines,
      controller: controller,
      keyboardType: onlyNumber
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.multiline,
      inputFormatters: onlyNumber
          ? [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))]
          : [],
    );
  }

  /// 날짜 셀 생성
  TextField makeDateCell({
    required TextEditingController controller,
    required BuildContext context,
    required Function onSelected,
    bool readOnly = false,
    InputDecoration? decoration,
    double? fontSize
  }) {
    decoration ??= const InputDecoration();
    return TextField(
      style: fontSize != null ? TextStyle(fontSize: fontSize) : null,
      decoration: decoration,
      readOnly: readOnly,
      controller: controller,
      onTap: () async {
        // 1년전 까지 검색
        DateTime past = DateTime.now();
        past = past.subtract(const Duration(days: 365));
        // 시간 피처
        DateTime? now = await showDatePicker(
          context: context,
          firstDate: past,
          lastDate: DateTime.now(),
          initialDate: DateTime.now()
        );
        onSelected.call(now);
      },
    );
  }

  /// 시간 셀 생성
  ///
  /// - [controller]: 컨트롤러
  /// - [context]: 컨텍스트
  /// - [onSelected]: 선택변경시호출
  /// - [readOnly]: 텍스트수정불가여부
  /// - [decoration]: 데코레이션
  /// - [fontSize]: 폰트사이즈
  /// - [disabled]: 시간선택불가여부,true시날짜팝업열지않음
  TextField makeDatetimeCell({
    required TextEditingController controller,
    required BuildContext context,
    Function? onSelected,
    bool readOnly = false,
    InputDecoration? decoration,
    double? fontSize,
    bool disabled = false
  }) {
    decoration ??= const InputDecoration();
    return TextField(
        style: fontSize != null ? TextStyle(fontSize: fontSize) : null,
        decoration: decoration,
        readOnly: readOnly,
        controller: controller,
        onTap: () async {
          if (!disabled) {
            // 시간 피처
            DateTime? now = await showOmniDateTimePicker(
              context: context,
              // 최초 시간
              initialDate: DateTime.now(),
            );
            onSelected?.call(now);
          }
        },
    );
  }
}
