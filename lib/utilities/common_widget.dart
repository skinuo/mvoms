import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../models/pagination.dart';
import 'constants.dart';

/// 메시지 타입
enum MessageLevel {error, info, question}

/// 공통 입력 위젯 생성 mixin
class CommonWidget {
  // 인스턴스화 하지 않음
  CommonWidget._();
  
  /// 드랍다운 셀 생성
  ///
  /// - [item]: 아이템 목록
  /// - [value]: 최초 값
  /// - [callback]: 아이템 선택 후 호출
  /// - [decoration]: 셀박스 데코레이션
  /// - [fontSize]: 폰트사이즈
  /// - [disabledText]: 비활성텍스트
  static Widget makeCellWithDropdown({
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
  static InputDecoration makeInputDecoration({
      String? labelText,
      bool required = false,
      double padding = 13
    }) {
    return InputDecoration(
        labelStyle: labelText != null ? TextStyle(fontSize: 12, color: required ? Colors.red : Colors.grey) : null,
        labelText: labelText != null ? labelText + (required ? " *" : "") : null,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey,
              width: 1),
        ),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            color: Colors.blue.shade800,
            width: 2),
        ),
        isDense: true,
        contentPadding: EdgeInsets.all(padding),
        counterText: ""
    );
  }

  /// 텍스트 셀 생성
  static TextField makeTextCell({
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
    Function? onTab,
    FocusNode? focusNode,
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
      focusNode: focusNode != null ? focusNode : null,
    );
  }

  /// 날짜 셀 생성
  static TextField makeDateCell({
    required TextEditingController controller,
    required BuildContext context,
    required Function onSelected,
    bool readOnly = false,
    InputDecoration? decoration,
    double fontSize = ConstantValues.kBodyFontSize,
    DateTime? firstDate,
    DateTime? lastDate
  }) {
    decoration ??= const InputDecoration();
    return TextField(
      style: TextStyle(fontSize: fontSize),
      decoration: decoration,
      readOnly: readOnly,
      controller: controller,
      onTap: () async {
        // 시작일
        if (firstDate == null) {
          // 1년전 까지 검색
          DateTime past = DateTime.now();
          firstDate = past.subtract(const Duration(days: 365));
        }
        // 종료일
        lastDate ??= DateTime.now();
        // 시간 피처
        DateTime? now = await showDatePicker(
          context: context,
          firstDate: firstDate!,
          lastDate: lastDate!,
          //initialDate: DateTime.now()
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
  static TextField makeDatetimeCell({
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

  /// 페이지 버튼 목록 생성
  /// 
  /// - [pg]: 페이징객체
  /// - [pageSize]: 페이지사이즈
  /// - [pageFunc]: 버튼클릭시 이벤트
  static List<Widget> makePageButtons(Pagination pg, int pageSize, Function pageFunc) {
    List<Widget> pageButtons = [];

    // 버튼 생성
    int firstPage = (pg.number ~/ pageSize) * pageSize;
    int lastPage = firstPage;
    // 이전으로
    if (pg.number >= pageSize) {
      pageButtons.add(makePageButton("<<", firstPage-pageSize, false, pageFunc));
      pageButtons.add(makePageButton("<", pg.number-1, false, pageFunc));
    }
    for (int i = 0; i < pageSize; i++) {
      int pageNum = firstPage + i;
      if (pageNum >= pg.totalPages) {
        // 최대 페이지 도달, 다음페이지 없음
        lastPage = -1;
        break;
      }
      // 현재 페이지 여부
      bool curr = pageNum == pg.number;
      pageButtons.add(makePageButton((pageNum+1).toString(), pageNum, curr, pageFunc));
      // 마지막 페이지
      lastPage = pageNum;
    }
    // 다음으로
    if (lastPage > -1 && lastPage+1 < pg.totalPages) {
      pageButtons.add(makePageButton(">", pg.number+1, false, pageFunc));
      pageButtons.add(makePageButton(">>", lastPage+1, false, pageFunc));
    }
    return pageButtons;
  }

  /// 페이징 버튼 생성
  /// 
  /// - [pageTxt]: 버튼텍스트
  /// - [pageNum]: 버튼번호
  /// - [highlighting]: 강조여부
  /// - [onPressed]: 버튼클릭이벤트
  static Widget makePageButton(String pageTxt, int pageNum, bool highlighting, Function onPressed) {
    return Flexible(
      child: TextButton(
          child: Text(pageTxt, style: TextStyle(
              decoration: highlighting ? TextDecoration.underline : null,
              fontWeight: highlighting ? FontWeight.bold: FontWeight.normal)),
          onPressed: () {
            onPressed(pageNum);
          }
      ),
    );
  }

  /// 타이틀 위젯 생성
  static Widget makeWidgetTitle(String title, bool required) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(required ? "*" : "", style: const TextStyle(color: Colors.red)),
            Text(title, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        )
    );
  }

  /// 다이얼로그 입력 공통 데코레이션
  static InputDecoration makeDecoration({Icon? icon, String? hintText}) {
    return InputDecoration(
        filled: true,
        fillColor: ConstantValues.kColorGray,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: ConstantValues.kColorGray,
              width: 1),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(13),
        counterText: "",
        hintText: hintText,
        prefixIcon: icon
    );
  }

  /// 메시지 박스 출력
  ///
  /// - [context]: 컨텍스트
  /// - [messageLevel]: 레벨
  /// - [message]: 메시지
  /// - [buttons]: 버튼목록
  static Future showMessageBox(
      BuildContext context,
      MessageLevel messageLevel,
      String message,
      Map<String,Function?> buttons) {
    List<Widget> actions = [];
    buttons.forEach((buttonVal, func) {
      actions.add(ElevatedButton(
        child: Text(buttonVal),
        onPressed: () {
          Navigator.pop(context);
          func?.call();
        }
      ));
    });

    // 타이틀
    String title;
    // 아이콘
    Icon icon;
    switch(messageLevel) {
      case MessageLevel.info:
        title = ConstantValues.kMessageInfo;
        icon = const Icon(Icons.check, color:Colors.green);
      case MessageLevel.error:
        title = ConstantValues.kMessageError;
        icon = const Icon(Icons.error_outline, color:Colors.red);
      case MessageLevel.question:
        icon = const Icon(Icons.question_mark, color:Colors.red);
    }

    return showDialog(
        context: context,
        builder: ((txt) {
          return AlertDialog(
            alignment: Alignment.center,
            content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: icon,
                  ),
                  Text(message, textAlign: TextAlign.center),
                ],
            ),
            actions: actions
          );
        })
    ).then((value) {
      return value;
    });
  }
}

