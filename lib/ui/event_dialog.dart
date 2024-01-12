import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvoms/models/operation_event.dart';
import 'package:mvoms/models/target_system.dart';
import '../models/member.dart';
import '../utilities/global.dart';
import '../utilities/input_widget.dart';
import '../utilities/constants.dart';
import '../utilities/rest_repository.dart';
import 'member_dialog.dart';

/// 이벤트 다이얼로그 구현
class MVOMSEventDialog extends StatefulWidget {
  const MVOMSEventDialog({super.key, required this.readOnly, required this.title, this.evntId});

  // 이벤트 아이디
  final String? evntId;
  // 수정불가
  final bool readOnly;
  // 다이얼로그 타이틀
  final String title;

  @override
  State<MVOMSEventDialog> createState() => _MVOMSEventDialogState();
}

class _MVOMSEventDialogState extends State<MVOMSEventDialog> with InputWidget {

  final _rest = RestRepogitory();

  // 시스템 콤보박스 아이템
  final List<TargetSystem> _targetSystems = [];
  //final List<String> _systemDropdownItem = [];

  // 요청 경로 아이템
  late final List<String> _reqMethodDropdownItem;
  //String _reqMethodDropdownVal = "";

  // 요청 유형 아이템
  late final List<String> _reqTypeDropdownItem;
  //String _reqTypeDropdownVal = "";

  // 이벤트 객체
  OperationEvent _event = OperationEvent.create();

  // 이벤트 다이얼로그 버튼
  late final List<Widget> _actions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 드롭다운 아이템 세팅
    _reqMethodDropdownItem = getCodeList(ConstantValues.kCodeReqMethod);
    _reqTypeDropdownItem = getCodeList(ConstantValues.kCodeReqType);
    //_reqMethodDropdownVal = _reqMethodDropdownItem[0];
    //_reqTypeDropdownVal = _reqTypeDropdownItem[0];
    //_reqDatetimeValue = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 이벤트 정보 초기화
      await initEvent();

      // 시스템 조회
      var systems = await _rest.getAllTargetSystems();
      // 시스템 코드
      for(var sysJson in systems) {
        var system = TargetSystem.fromJson(sysJson);
        _targetSystems.add(system);
        //_systemDropdownItem.add(system.name);
      }
      setState(() {});
    });

    _actions.add(
      ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('취소'))
    );
    // 수정가능시 저장버튼 추가
    if (!widget.readOnly) {
      _actions.add(ElevatedButton(
          onPressed: () async {
            //Navigator.of(context).pop();
            saveEvent();
          },
          child: const Text('저장')));
    }
    print('readOnly: ${widget.readOnly}');
  }

  @override
  Widget build(BuildContext context) {
    // 이벤트 조회
    print('event_dialog build!');
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      title: Text(widget.title),
      content:
      Container(
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
                  child: const Text("의뢰자 정보", style: TextStyle(fontWeight: FontWeight.bold))
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        // 이름
                        Expanded(flex:1,
                          child: makeTextCell(
                          readOnly: true, required: true, decoration: makeInputDecoration(required: true, labelText: "이름"),
                          onTab:()=>showMemberPop(setRequester), controller: TextEditingController(text: _event.requester.name))),
                        const SizedBox(width: 15),
                        // 소속
                        Expanded(flex:2, child: makeTextCell(
                          readOnly: true, required: true, decoration: makeInputDecoration(required: true, labelText: "소속"),
                          onTab:()=>showMemberPop(setRequester), controller:
                            TextEditingController(text: _event.requester.department.name != "" ? "${_event.requester.department.name}, ${_event.requester.department.organization.name}" : ""))),
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
                  child: const Text("의뢰 정보", style: TextStyle(fontWeight: FontWeight.bold))
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
                              setState(() => _event.evntTime = value);
                            },
                            controller: TextEditingController(text: DateFormat('yyyy-MM-dd HH:mm:ss').format(_event.evntTime)),
                            context: context)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        // 처리자
                        Expanded(child:
                        makeTextCell(
                            readOnly: true, required: true,
                            decoration: makeInputDecoration(required: true, labelText: "처리자"),
                            onTab:()=>showMemberPop(setCharger),
                            controller: TextEditingController(text: _event.charger?.name))),
                        const SizedBox(width: 15),
                        // 시스템
                        Expanded(
                            child: makeCellWithDropdown(decoration: makeInputDecoration(required: true, labelText: "시스템", padding: 9),
                                item: [],
                                value: "",
                                onChanged: (){},
                                disabled: widget.readOnly)
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                            child: makeCellWithDropdown(decoration: makeInputDecoration(required: true, labelText: "요청유형", padding: 9),
                                item: [], value: "", onChanged: (){},
                                disabled: widget.readOnly)
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                            child: makeCellWithDropdown(decoration: makeInputDecoration(required: true, labelText: "요청경로", padding: 9),
                                item: [], value: "", onChanged: (){},
                                disabled: widget.readOnly)
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(child: makeTextCell(decoration: makeInputDecoration(labelText: "제목"),
                            controller: TextEditingController(text: _event.title),
                            maxLines: 2, maxLength: 100, readOnly: widget.readOnly)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                        children: [
                          Expanded(child: makeTextCell(decoration: makeInputDecoration(required: true, labelText: "요청내용"),
                              maxLines: 8, maxLength: 500, controller: TextEditingController(text: _event.evntDesc),
                              readOnly: widget.readOnly)),
                        ]
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(child: makeTextCell(decoration: makeInputDecoration(labelText: "첨부파일"))),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(child: makeTextCell(decoration: makeInputDecoration(labelText: "태그"),
                            readOnly: widget.readOnly)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
      ),
      actions: _actions,
    );
  }

  /// 멤버 조회 팝업 열기
  /// 
  /// - [callback]: 조회결과전달
  void showMemberPop(callback) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return const MVOMSMemberDialog();
        })
    ).then((member) {
      // 멤버 조회 완료
      setState(() {
        callback(member);
      });
    });
  }

  /// 요청자 쓰기
  void setRequester(Member member) {
    _event.requester = member;
  }

  /// 처리자 쓰기
  void setCharger(Member member) {
    _event.charger = member;
  }

  /// 이벤트 목록 조회
  Future initEvent() async {
    if (widget.evntId != null) {
      var eventMap = await _rest.getEventById(widget.evntId!);
        _event = OperationEvent.fromJson(eventMap);
    }
  }

  /// 코드목록반환
  List<String> getCodeList(String id) {
    var list = Global.getComCode(id).map((c) => c.name).toList();
    return list ?? [];
  }

  /// 이벤트 저장
  void saveEvent() {

  }
}
