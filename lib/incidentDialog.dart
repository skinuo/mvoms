import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

/// 인시던스 다이얼로그 구현
/// @since 2023.12.30.
class MvIncidentDialog extends StatefulWidget {
  const MvIncidentDialog({super.key});

  @override
  State<MvIncidentDialog> createState() => _MvIncidentDialogState();
}

class _MvIncidentDialogState extends State<MvIncidentDialog> {
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
    return SizedBox(
      width: 550,
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [Icon(Icons.add), Text("의뢰자 정보")],
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("*", style: TextStyle(color: Colors.red)),
                      Text("필수입력 항목 입니다.")
                    ],
                  ))
            ],
          ),
          SizedBox(
              width: double.infinity,
              child: Table(
                border: const TableBorder(
                  top: BorderSide(color: Colors.black12),
                  bottom: BorderSide(color: Colors.black12),
                  horizontalInside: BorderSide(color: Colors.black12),
                  verticalInside: BorderSide(color: Colors.black12),
                ),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(100),
                  1: FlexColumnWidth(1),
                  2: FixedColumnWidth(100),
                  3: FlexColumnWidth(1)
                },
                children: [
                  TableRow(
                      children: [
                        makeHeaderCell("이름", true),
                        makeBodyCell("이름", 10),
                        makeHeaderCell("소속", true),
                        makeBodyCell("소속"),
                      ],
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(235, 235, 235, 1))),
                  TableRow(
                      children: [
                        makeHeaderCell("전화번호"),
                        makeBodyCell("전화번호", 11, true),
                        makeHeaderCell("e-mail"),
                        makeBodyCell("e-mail", 50),
                      ],
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(235, 235, 235, 1)))
                ],
              )),
          const Row(
            children: [
              Icon(Icons.add),
              Text("의뢰 정보"),
            ],
          ),
          SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Table(
                    border: const TableBorder(
                      top: BorderSide(color: Colors.black12),
                      bottom: BorderSide(color: Colors.black12),
                      horizontalInside: BorderSide(color: Colors.black12),
                      verticalInside: BorderSide(color: Colors.black12),
                    ),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(100),
                      1: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                          children: [
                            makeHeaderCell("의뢰일시", true),
                            // 의뢰일시 타임 피커
                            makeReqTimedateCell(),
                          ],
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(235, 235, 235, 1)))
                    ],
                  ),
                  Table(
                    border: const TableBorder(
                      //top: BorderSide(color: Colors.black12),
                      bottom: BorderSide(color: Colors.black12),
                      horizontalInside: BorderSide(color: Colors.black12),
                      verticalInside: BorderSide(color: Colors.black12),
                    ),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(100),
                      1: FlexColumnWidth(1),
                      2: FixedColumnWidth(100),
                      3: FlexColumnWidth(1)
                    },
                    children: [
                      TableRow(
                          children: [
                            makeHeaderCell("처리자", true),
                            makeBodyCell("처리자", 10),
                            makeHeaderCell("분류", true),
                            makeBodyDropdownCell(_divDropdownItem, _divDropDownVal,
                                (value) => _divDropDownVal = value)
                          ],
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(235, 235, 235, 1))),
                      TableRow(
                          children: [
                            makeHeaderCell("처리유형", true),
                            makeBodyDropdownCell(_processTypeDropdownItem, _processTypeDropdownVal,
                                (value) => _processTypeDropdownVal = value),
                            makeHeaderCell("서비스채널", true),
                            makeBodyDropdownCell(_chanelDropdownItem, _chanelDropDownVal,
                                (value) => _chanelDropDownVal = value)
                            // makeBodyCell("서비스채널", 5),
                          ],
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(235, 235, 235, 1)))
                    ],
                  ),
                  Table(
                    border: const TableBorder(
                      //top: BorderSide(color: Colors.black12),
                      bottom: BorderSide(color: Colors.black12),
                      horizontalInside: BorderSide(color: Colors.black12),
                      verticalInside: BorderSide(color: Colors.black12),
                    ),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(100),
                      1: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                          children: [
                            makeHeaderCell("요약"),
                            makeBodyCell("요약", 500),
                          ],
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(235, 235, 235, 1))),
                      TableRow(
                          children: [
                            makeHeaderCell("요청내역", true),
                            makeBodyContCell("요청내역", 500),
                          ],
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(235, 235, 235, 1))),
                      TableRow(
                          children: [
                            makeHeaderCell("첨부파일"),
                            makeBodyCell("첨부파일", 50),
                          ],
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(235, 235, 235, 1))),
                      TableRow(
                          children: [
                            makeHeaderCell("태그(Tag)"),
                            makeBodyCell("태그", 10),
                          ],
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(235, 235, 235, 1)))
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }

  /// 인시던스 입력 다이얼로그 헤더 셀 생성
  /// @param label 라벨
  /// @param requried 필수입력항목여부
  TableCell makeHeaderCell(String label, [bool required = false]) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              children: [
                Text(label),
                required
                    ? const Text("*", style: TextStyle(color: Colors.red))
                    : const Text("")
              ],
            )));
  }

  /// 입력 데코레이션 반환
  InputDecoration getInputDecoration() {
    return const InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.all(10),
        counterText: "");
  }

  /// 인시던스 입력 다이얼로그 텍스트 셀 생성
  /// @label 라벨
  /// @maxLength 최대 입력 사이즈
  /// @onlyNumber 숫자만 입력
  TableCell makeBodyCell(String label,
      [int maxLength = 100, bool onlyNumber = false]) {
    return TableCell(
        child: TextField(
            decoration: getInputDecoration(),
            keyboardType: onlyNumber
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.none,
            maxLength: maxLength,
            inputFormatters: onlyNumber
                ? [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))]
                : []));
  }

  /// 인시던스 드롭다운 셀 생성
  /// @param items 옵션 목록
  TableCell makeBodyDropdownCell(List<String> items, String initVal, Function func) {
    return TableCell(
      child: Container(
        height: 37,
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        decoration: const BoxDecoration(color: Colors.white),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            //underline: SizedBox.shrink(),
            isExpanded: false,
            value: initVal,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                func.call(value);
              });
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 140,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      ),
    );
  }

  /// 요청내역 셀 생성
  TableCell makeBodyContCell(String label, [int maxLength = 100]) {
    return TableCell(
        child: SizedBox(
          child: TextField(
          maxLines: 4, decoration: getInputDecoration(), maxLength: maxLength),
    ));
  }

  /// 인시던스 의뢰일시 datetime 셀 생성
  TableCell makeReqTimedateCell() {
    return TableCell(
      child: TextField(
          decoration: getInputDecoration(),
          readOnly: true,
          controller: TextEditingController(text: _reqDatetimeValue),
          onTap: () async {
            DateTime? now = await showOmniDateTimePicker(
              context: context,
              initialDate: DateTime.now(),
            );
            setState(() {
              // 시간 쓰기
              _reqDatetimeValue = DateFormat('yyyy-MM-dd HH:mm:ss').format(now!);
            });
          }),
    );
  }
}
