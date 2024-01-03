import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

/// 이벤트 다이얼로그 구현
class MvEventDialog extends StatefulWidget {
  const MvEventDialog({super.key});

  @override
  State<MvEventDialog> createState() => _MvEventDialogState();
}

class _MvEventDialogState extends State<MvEventDialog> {
  // 요청 시간 위젯 값
  String _reqDatetimeValue = "";

  // 분류 콤보박스 아이템
  final List<String> _divDropdownItem = ["정보", "정보2", "정보3"];
  String _divDropDownVal = "";

  // 서비스 채널 아이템
  final List<String> _chanelDropdownItem = ["채널1", "채널2", "채널3"];
  String _chanelDropDownVal = "";

  // 처리 유형 아이템
  final List<String> _processTypeDropdownItem = ["유형1", "유형2", "유형3"];
  String _processTypeDropdownVal = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 분류 콤보박스 아이템
    _divDropDownVal = _divDropdownItem[0];
    // 서비스 채널 아이템
    _chanelDropDownVal = _chanelDropdownItem[0];
    // 처리 유형 아이템
    _processTypeDropdownVal = _processTypeDropdownItem[0];
    // 의뢰 시간
    _reqDatetimeValue = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 550,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              color: Colors.black26,
              child: const Text("의뢰자 정보"),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Flexible(child: Row(
                        children: [
                            Flexible(child: makeCell(labelText: "이름", required: true, maxLength: 5)),
                            SizedBox(child: ElevatedButton(onPressed: () { showGetUserPop(); },
                            child: const Text("조회"))),
                          ]
                        )
                      ),
                      const SizedBox(width: 10),
                      Flexible(child: makeCell(labelText: "소속", required: true))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(child: makeCell(labelText: "전화번호", onlyNumber: true, maxLength: 11)),
                      const SizedBox(width: 10),
                      Flexible(child: makeCell(labelText: "e-mail"))
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              color: Colors.black26,
              child: const Text("의뢰 정보"),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Flexible(fit: FlexFit.tight, child: makeCellWithReqDatetime("외뢰시간")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(child: Row(
                        children: [
                          Flexible(child: makeCell(labelText: "처리자", required: true)),
                          SizedBox(child: ElevatedButton(onPressed: () { showGetUserPop();  },
                              child: const Text("조회")))
                        ],
                      )),
                      const SizedBox(width: 10),
                      Flexible(
                          child: makeCellWithDropdown('분류', true, _divDropdownItem, _divDropDownVal, (value) {
                            _divDropDownVal = value;
                          })
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(child: makeCellWithDropdown("처리유형", true, _processTypeDropdownItem, _processTypeDropdownVal, (value) {
                        _processTypeDropdownVal = value;
                      })),
                      const SizedBox(width: 10),
                      Flexible(child: makeCellWithDropdown("서비스채널", true, _chanelDropdownItem, _chanelDropDownVal, (value) {
                        _chanelDropDownVal = value;
                      }))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(fit: FlexFit.tight, child: makeCell(labelText: "요약", maxLength: 100)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(fit: FlexFit.tight, child: makeCell(labelText: "요청내용", maxLength: 500, required: true, maxLines: 5)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(fit: FlexFit.tight, child: makeCell(labelText: "첨부파일")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(fit: FlexFit.tight, child: makeCell(labelText: "태그")),
                    ],
                  )
                ],
              ),
            ),
          ],
        )
      );
  }

  /// 데코레이션 생성
  InputDecoration makeInputDecoration(String labelText, bool required) {
    return InputDecoration(
        labelStyle: TextStyle(fontSize: 12, color: required ? Colors.red : Colors.grey),
        labelText: "$labelText" + (required ? " *" : ""),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey,
              width: 1),
        ),
        isDense: true,
        contentPadding: EdgeInsets.all(12),
        counterText: ""
    );
  }

  /// 드랍다운 셀 생성
  ///
  /// [labelText]라벨, [required]필수여부, [item]아이템목록, [value]초기값, [callback]선택콜백
  Widget makeCellWithDropdown(String labelText, bool required, List item, String value, Function callback) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2(
          decoration: makeInputDecoration(labelText, true),
          isExpanded: true,
          onChanged: (item) {
            print(item);
            callback.call(item);
          },
          items: item.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          value: value
      )
    );
  }

  /// 의뢰시간 셀 생성
  TextField makeCellWithReqDatetime(String labelText) {
    return TextField(
      decoration: makeInputDecoration(labelText, true),
      readOnly: true,
      controller: TextEditingController(text: _reqDatetimeValue),
      onTap: () async {
        DateTime? now = await showOmniDateTimePicker(
          context: context,
          // 최초 시간
          initialDate: DateTime.now(),
        );
        setState(() {
          // 시간 쓰기
          _reqDatetimeValue = DateFormat('yyyy-MM-dd HH:mm:ss').format(now!);
        });
      }
    );
  }

  /// 셀을 생성한다
  ///
  /// [labelText]라벨, [requried]필수여부, [onlyNumber]숫자여부, [maxLength]최대길이
  /// [readOnly]조회만가능여부, [maxLines]최대라인
  TextField makeCell({
    required String labelText,
    bool required = false,
    bool onlyNumber = false,
    int maxLength = 10,
    bool readOnly = false,
    int maxLines = 1
  }) {
    return TextField(
      readOnly: readOnly,
      textInputAction: TextInputAction.newline,
      decoration: makeInputDecoration(labelText, required),
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: onlyNumber
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.multiline,
      inputFormatters: onlyNumber
          ? [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))]
          : [],
    );
  }

  void showGetUserPop() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return AlertDialog(
            surfaceTintColor: Colors.transparent,
            title: const Text("사용자 조회"),
            content: Text("aaa"),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('취소')),
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('저장')),
            ],
          );
        }));
  }
}
