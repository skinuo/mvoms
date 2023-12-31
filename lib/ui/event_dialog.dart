import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvoms/models/operation_event.dart';
import '../utilities/global.dart';
import '../utilities/input_widget.dart';
import '../utilities/constants.dart';
import '../utilities/rest_repository.dart';

/// 이벤트 다이얼로그 구현
class MvEventDialog extends StatefulWidget {
  const MvEventDialog({super.key, required this.readOnly, this.evntId});

  // 이벤트 아이디
  final String? evntId;
  // 수정불가
  final bool readOnly;

  @override
  State<MvEventDialog> createState() => _MvEventDialogState();
}

class _MvEventDialogState extends State<MvEventDialog> with InputWidget {

  final _rest = RestRepogitory();

  // 요청 시간 위젯 값
  String _reqDatetimeValue = "";

  // 시스템 콤보박스 아이템
  List<String> _systemDropdownItem = ["정보", "정보2", "정보3"];
  String _systemDropdownVal = "";

  // 요청 경로 아이템
  late final List<String> _reqMethodDropdownItem;
  String _reqMethodDropdownVal = "";

  // 요청 유형 아이템
  late final List<String> _reqTypeDropdownItem;
  String _reqTypeDropdownVal = "";

  // 이벤트 객체 (상세조회시 사용)
  OperationEvent? _event;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 초기값
    _reqMethodDropdownItem = getCodeList(ConstantValues.kCodeReqMethod);
    _reqTypeDropdownItem = getCodeList(ConstantValues.kCodeReqType);

    _systemDropdownVal = _systemDropdownItem[0];
    _reqMethodDropdownVal = _reqMethodDropdownItem[0];
    _reqTypeDropdownVal = _reqTypeDropdownItem[0];
    _reqDatetimeValue = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print('readOnly: ${widget.readOnly}');
    // 이벤트 정보 초기화
    initEvent();
  }

  @override
  Widget build(BuildContext context) {
    // 이벤트 조회
    print('event_dialog build!');
    return Container(
        width: 550,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ConstantValues.kColorBlue
              ),
              child: const Text("의뢰자 정보")
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(child: makeTextCell(readOnly: true, required: true,
                          decoration: makeInputDecoration(required: true, labelText: "이름"), fontSize:ConstantValues.kBodyFontSize)),
                      const SizedBox(width: 15),
                      Expanded(child: makeTextCell(readOnly: true, required: true,
                          decoration: makeInputDecoration(required: true, labelText: "소속"), fontSize:ConstantValues.kBodyFontSize)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ConstantValues.kColorBlue
                ),
                child: const Text("의뢰 정보")
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(child:
                        makeDatetimeCell(
                          readOnly: true,
                          disabled: widget.readOnly,
                          decoration: makeInputDecoration(required: true, labelText: "의뢰시간"),
                          onSelected: (value) {
                            setState(() {
                              _reqDatetimeValue = DateFormat('yyyy-MM-dd HH:mm:ss').format(value);
                            });
                          },
                          controller: TextEditingController(text: _reqDatetimeValue),
                          context: context,
                          fontSize:ConstantValues.kBodyFontSize)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: makeTextCell(readOnly: true, required: true,
                          decoration: makeInputDecoration(required: true, labelText: "처리자"),
                          fontSize:ConstantValues.kBodyFontSize, controller: TextEditingController(text: _event?.charger?.name))),
                      const SizedBox(width: 15),
                      Expanded(
                        child: makeCellWithDropdown(decoration: makeInputDecoration(required: true, labelText: "시스템"),
                          item: _systemDropdownItem, value: _systemDropdownVal, callback: (){}, fontSize:ConstantValues.kBodyFontSize,
                          disabled: widget.readOnly)
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                          child: makeCellWithDropdown(decoration: makeInputDecoration(required: true, labelText: "요청유형"),
                            item: _reqTypeDropdownItem, value: _reqTypeDropdownVal, callback: (){}, fontSize:ConstantValues.kBodyFontSize,
                            disabled: widget.readOnly)
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: makeCellWithDropdown(decoration: makeInputDecoration(required: true, labelText: "요청경로"),
                            item: _reqMethodDropdownItem, value: _reqMethodDropdownVal, callback: (){}, fontSize:ConstantValues.kBodyFontSize,
                            disabled: widget.readOnly)
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: makeTextCell(decoration: makeInputDecoration(labelText: "제목"),
                          controller: TextEditingController(text: _event?.title), fontSize:ConstantValues.kBodyFontSize,
                          maxLines: 2, maxLength: 100, readOnly: widget.readOnly)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: makeTextCell(decoration: makeInputDecoration(required: true, labelText: "요청내용"),
                          maxLines: 8, maxLength: 500, controller: TextEditingController(text: _event?.evntDesc),
                          fontSize:ConstantValues.kBodyFontSize, readOnly: widget.readOnly)),
                    ]
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: makeTextCell(decoration: makeInputDecoration(labelText: "첨부파일"), fontSize:ConstantValues.kBodyFontSize)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: makeTextCell(decoration: makeInputDecoration(labelText: "태그"),
                          fontSize:ConstantValues.kBodyFontSize, readOnly: widget.readOnly)),
                    ],
                  )
                ],
              ),
            ),
          ],
        )
    );
  }

  void showUserPop() {
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

  /// 이벤트 조회
  void initEvent() async {
    if (widget.evntId != null) {
      var eventMap = await _rest.getEventById(widget.evntId!);
      setState(() {
        _event = OperationEvent.fromJson(eventMap);
      });
    }
  }

  List<String> getCodeList(String id) {
    var list = Global.getComCode(id)?.map((c) => c.name).toList();
    return list ?? [];
  }
}
