import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import 'constants.dart';

/// 공통 입력 위젯 생성 mixin
mixin InputWidget {
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
      Function? onChanged,
      InputDecoration? decoration,
      double fontSize = ConstantValues.kBodyFontSize,
      bool disabled = false
    }) {
    decoration ??= const InputDecoration();
    return DropdownButtonFormField2(
        style: TextStyle(fontSize: fontSize),
        decoration: decoration,
        isExpanded: true,
        disabledHint: disabled ? Text(value) : null,
        onChanged: !disabled ? (item) {
          onChanged?.call(item);
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
      double padding = 12
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
        contentPadding: EdgeInsets.all(padding),
        counterText: ""
    );
  }

  /// 텍스트 셀 생성
  TextField makeTextCell({
    String? labelText,
    bool required = false,
    bool onlyNumber = false,
    int maxLength = 100,
    bool readOnly = false,
    int maxLines = 1,
    InputDecoration? decoration,
    double fontSize = ConstantValues.kBodyFontSize,
    TextEditingController? controller,
    Function? onChanged,
    Function? onTab
  }) {
    decoration ??= const InputDecoration();
    return TextField(
      style: TextStyle(fontSize: fontSize),
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
      onChanged:(value) => onChanged?.call(value),
      onTap:() => onTab?.call(),
    );
  }

  /// 날짜 셀 생성
  TextField makeDateCell({
    required TextEditingController controller,
    required BuildContext context,
    required Function onSelected,
    bool readOnly = false,
    InputDecoration? decoration,
    double fontSize = ConstantValues.kBodyFontSize
  }) {
    decoration ??= const InputDecoration();
    return TextField(
      style: TextStyle(fontSize: fontSize),
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
    double fontSize = ConstantValues.kBodyFontSize,
    bool disabled = false
  }) {
    decoration ??= const InputDecoration();
    return TextField(
        style: TextStyle(fontSize: fontSize),
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
