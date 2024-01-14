import 'package:dropdown_button2/dropdown_button2.dart';
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
  // 요청 경로 아이템
  late final _reqMethods = Global.getComCode(ConstantValues.kCodeReqMethod);
  // 요청 유형 아이템
  late final _reqTypes = Global.getComCode(ConstantValues.kCodeReqType);
  // 이벤트 객체
  OperationEvent _event = OperationEvent.create();
  // 이벤트 다이얼로그 버튼
  late final List<Widget> _actions = [];
  // 유효성검증
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 시스템 조회
      var systems = await _rest.getAllTargetSystems();
      for(var sysJson in systems) {
        var system = TargetSystem.fromJson(sysJson);
        _targetSystems.add(system);
      }

      // 이벤트 아이디 있으면 상세조회 하여 세팅
      if (widget.evntId != null) {
        var eventMap = await _rest.getEventById(widget.evntId!);
        _event = OperationEvent.fromJson(eventMap);
      } else {
        // 초기값
        _event.targetSystem = _targetSystems[0];
        _event.reqTpCd = _reqTypes[0].code;
        _event.reqMthdCd = _reqMethods[0].code;
      }

      setState(() {});
    });

    // 다이얼로그 버튼 생성
    _actions.add(
      ElevatedButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('취소'))
    );
    // 수정 가능시 저장버튼 추가
    if (!widget.readOnly) {
      _actions.add(ElevatedButton(
          onPressed: () async {
            saveEvent();
          },
          child: const Text('저장')));
    }
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
          width: 500,
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ConstantValues.kColorBlue
                      ),
                      child: const Text("요청자 정보", style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            // 이름
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                                readOnly: true,
                                decoration: makeInputDecoration(labelText: "요청자", required: true),
                                controller: TextEditingController(text: _event.requester.name !=  "" ? "${_event.requester.name} (${_event.requester.department.name}, ${_event.requester.department.organization.name})" : ""),
                                onTap: widget.readOnly ? null : ()=>showMemberPop(setRequester),
                                validator: (value) {
                                  if (_event.requester.name.replaceAll(" ", "") == "") {
                                    return ConstantValues.kMessages["Required"];
                                  }
                                  return null;
                                }
                              )
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ConstantValues.kColorBlue
                      ),
                      child: const Text("요청 정보", style: TextStyle(fontWeight: FontWeight.bold))
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
                                fontSize: ConstantValues.kDialogFontSize,
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
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            // 처리자
                            Expanded(child:
                              TextFormField(
                                  style: TextStyle(fontSize: ConstantValues.kDialogFontSize),
                                  readOnly: true,
                                  decoration: makeInputDecoration(labelText: "처리자", required: true),
                                  controller: TextEditingController(text: _event.charger != null ? "${_event.charger?.name}" : ""),
                                  onTap: widget.readOnly ? null : ()=>showMemberPop(setCharger),
                                  validator: (value) {
                                    if (_event.charger == null) {
                                      return ConstantValues.kMessages["Required"];
                                    }
                                    return null;
                                  }
                              )
                            ),
                            const SizedBox(width: 10),
                            // 시스템
                            Expanded(
                              child: makeDropdown("시스템", _targetSystems, widget.readOnly, (_targetSystems.isNotEmpty ? _targetSystems[0]: ""), (targetSystem){
                                _event.targetSystem = targetSystem;
                              })
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: makeDropdown("요청유형", _reqTypes, widget.readOnly, _reqTypes[0], (value){
                                _event.reqTpCd = value.code;
                              })),
                            const SizedBox(width: 15),
                            Expanded(child: makeDropdown("요청경로", _reqMethods, widget.readOnly, _reqMethods[0], (value){
                                _event.reqMthdCd = value.code;
                              })
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child:
                              TextFormField(
                                style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                                readOnly: widget.readOnly,
                                decoration: makeInputDecoration(labelText: "제목", required: true),
                                controller: TextEditingController(text: _event.title),
                                maxLength: 100,
                                onChanged: (value) {
                                  _event.title = value;
                                },
                                validator: (value) {
                                  if (_event.title.isEmpty) {
                                    return ConstantValues.kMessages["Required"];
                                  }
                                  return null;
                                }
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                            children: [
                              Expanded(child:
                                TextFormField(
                                    readOnly: widget.readOnly,
                                    style: TextStyle(fontSize: ConstantValues.kDialogFontSize),
                                    decoration: makeInputDecoration(labelText: "내용", required: true),
                                    controller: TextEditingController(text: _event.evntDesc),
                                    maxLines: 8, maxLength: 500,
                                    onChanged: (value) {
                                      _event.evntDesc = value;
                                    },
                                    validator: (value) {
                                      if (_event.evntDesc.isEmpty) {
                                        return ConstantValues.kMessages["Required"];
                                      }
                                      return null;
                                    }
                                )
                              ),
                            ]
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: makeTextCell(decoration: makeInputDecoration(labelText: "첨부파일"))),
                          ],
                        ),
                        const SizedBox(height: 10),
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
              ),
            ),
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
      if (member != null) {
        callback(member);
      }
    });
  }

  /// 요청자 쓰기
  void setRequester(Member member) {
    setState(() {
      _event.requester = member;
    });
  }

  /// 처리자 쓰기
  void setCharger(Member member) {
    setState(() {
      _event.charger = member;
    });
  }

  /// 드랍다운 위젯 생성
  DropdownButtonFormField2 makeDropdown(String label, List item, bool readOnly, dynamic value, Function? onChanged) {
    return DropdownButtonFormField2(
        decoration: makeInputDecoration(required: true, labelText: label),
        style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
        isExpanded: true,
        onChanged: readOnly ? null : (value) {
          onChanged!.call(value);
        },
        items: item.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item.name),
          );
        }).toList(),
        value: value
    );
  }

  /// 이벤트 저장
  void saveEvent() async {
    // 입력값 검증
    if (_formKey.currentState!.validate()) {
      if (widget.evntId != null) {
        // 이벤트 수정
        _rest.updateEvent(_event);
      } else {
        // 이벤트 저장
        _rest.addEvent(_event)
        .then((value) {
          // 성공
          Navigator.pop(context, true);
        }).catchError((err) {
          // 오류
          print(err);
        });
      }
    }
  }
}
