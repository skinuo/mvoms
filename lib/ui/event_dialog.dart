import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvoms/models/operation_event.dart';
import 'package:mvoms/models/target_system.dart';
import 'package:mvoms/utilities/input_widget.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../models/member.dart';
import '../utilities/global.dart';
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
  // 처리 상태 아이템
  late final _reqStates = Global.getComCode(ConstantValues.kCodeState);
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
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1
                        )
                      )
                    ),
                    child: const Text("요청자 정보"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 요청자
                        Column(
                          children: [
                            makeWidgetTitle("요청자", true),
                            const SizedBox(height: 3),
                            TextFormField(
                              style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                              readOnly: true,
                              controller: TextEditingController(text: _event.requester.name !=  "" ? "${_event.requester.name} (${_event.requester.department.name}, ${_event.requester.department.organization.name})" : ""),
                              onTap: widget.readOnly ? null : ()=>showMemberPop(setRequester),
                              validator: (value) {
                                if (_event.requester.name.replaceAll(" ", "") == "") {
                                  return ConstantValues.kMessageRequired;
                                }
                                return null;
                              },
                              decoration: makeDecoration(icon: const Icon(Icons.account_circle, color: Colors.grey)),
                            ),
                          ],
                        ),
                        // 요청일시
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  makeWidgetTitle("요청일시", true),
                                  const SizedBox(height: 3),
                                  TextFormField(
                                    style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                                    readOnly: true,
                                    controller: TextEditingController(text: DateFormat('yyyy-MM-dd HH:mm:ss').format(_event.evntTime)),
                                    onTap: !widget.readOnly ? () async {
                                      // 시간 피처
                                      DateTime? now = await showOmniDateTimePicker(
                                        context: context,
                                        // 최초 시간
                                        initialDate: DateTime.now(),
                                      );
                                      setState(() => _event.evntTime = now!);
                                    } : null,
                                    decoration: makeDecoration(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            // 처리상태
                            Expanded(
                              child: Column(
                                children: [
                                  makeWidgetTitle("처리상태", true),
                                  const SizedBox(height: 3),
                                  makeDropdown(_reqStates, widget.readOnly, (value) {
                                    _event.stateCd = value!;
                                  }, _reqStates[0])
                                  ,
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            // 처리자
                            Expanded(
                              child: Column(
                                children: [
                                  makeWidgetTitle("처리자", true),
                                  const SizedBox(height: 3),
                                  TextFormField(
                                    style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                                    readOnly: true,
                                    controller: TextEditingController(text: _event.charger != null ? "${_event.charger?.name}" : ""),
                                    onTap: widget.readOnly ? null : ()=>showMemberPop(setCharger),
                                    validator: (value) {
                                      if (_event.charger == null) {
                                        return ConstantValues.kMessageRequired;
                                      }
                                      return null;
                                    },
                                    decoration: makeDecoration(icon: const Icon(Icons.account_circle, color: Colors.grey)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            // 시스템
                            Expanded(
                              child: Column(
                                children: [
                                  makeWidgetTitle("시스템", true),
                                  const SizedBox(height: 3),
                                  makeDropdown(_targetSystems, widget.readOnly, (value) {
                                    _event.targetSystem = value!;
                                  }, _targetSystems.isNotEmpty ? _targetSystems[0] : "")
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            // 요청유형
                            Expanded(
                              child: Column(
                                children: [
                                  makeWidgetTitle("요청유형", true),
                                  const SizedBox(height: 3),
                                  makeDropdown(_reqTypes, widget.readOnly, (value) {
                                    _event.reqTpCd = value!.code;
                                  }, _reqTypes[0])
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            // 요청경로
                            Expanded(
                              child: Column(
                                children: [
                                  makeWidgetTitle("요청경로", true),
                                  const SizedBox(height: 3),
                                  makeDropdown(_reqMethods, widget.readOnly, (value) {
                                    _event.reqMthdCd = value!.code;
                                  }, _reqMethods[0])
                                ],
                              ),
                            ),
                          ],
                        ),
                        // 제목
                        Column(
                          children: [
                            makeWidgetTitle("제목", true),
                            const SizedBox(height: 3),
                            TextFormField(
                              readOnly: widget.readOnly,
                              style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                              controller: TextEditingController(text: _event.title),
                              maxLength: 100,
                              onChanged: (value) {
                                _event.title = value;
                              },
                              validator: (value) {
                                if (_event.title.isEmpty) {
                                  return ConstantValues.kMessageRequired;
                                }
                                return null;
                              },
                              decoration: makeDecoration(),
                            ),
                          ],
                        ),Column(
                          children: [
                            makeWidgetTitle("내용", true),
                            const SizedBox(height: 3),
                            TextFormField(
                              readOnly: widget.readOnly,
                              style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                              controller: TextEditingController(text: _event.evntDesc),
                              maxLines: 5, maxLength: 500,
                              onChanged: (value) {
                                _event.evntDesc = value;
                              },
                              validator: (value) {
                                if (_event.evntDesc.isEmpty) {
                                  return ConstantValues.kMessageRequired;
                                }
                                return null;
                              },
                              decoration: makeDecoration(),
                            ),
                          ],
                        ),
                        // 첨부파일
                        Column(
                          children: [
                            makeWidgetTitle("첨부파일", false),
                            const SizedBox(height: 3),
                            TextFormField(
                              style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                              controller: TextEditingController(text: _event.evntDesc),
                              maxLength: 100,
                              decoration: makeDecoration(),
                            ),
                          ],
                        ),
                        // 태그
                        Column(
                          children: [
                            makeWidgetTitle("태그", false),
                            const SizedBox(height: 3),
                            TextFormField(
                              style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                              controller: TextEditingController(text: _event.evntDesc),
                              maxLength: 100,
                              decoration: makeDecoration(),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      ),
      actions: _actions,
    );
  }

  /// 드랍다운 위젯 생성
  DropdownButtonFormField2 makeDropdown(List items, bool readonly, Function onChanged, Object value) {
    return DropdownButtonFormField2(
      style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
      decoration: makeDecoration(),
      isExpanded: true,
      onChanged: !readonly ? (value) {
        onChanged.call(value);
      } : null,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item.name),
        );
      }).toList(),
      value: value
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

  /// 이벤트 저장
  void saveEvent() async {
    // 입력값 검증
    if (_formKey.currentState!.validate()) {
      if (widget.evntId != null) {
        // 이벤트 수정
        _rest.updateEvent(_event)
        .then((value) {
          // 메시지 박스 출력
          showMessageBox(context, MessageLevel.info, ConstantValues.kMessageSaved, {
            ConstantValues.kMessageOk: ()=> Navigator.pop(context, true)
          });
        }).catchError((err) {
          showMessageBox(context, MessageLevel.error, "${ConstantValues.kMessageErrored}[$err]", {
            ConstantValues.kMessageOk: null
          });
          print(err);
        });
      } else {
        // 이벤트 저장
        _rest.addEvent(_event)
        .then((value) {
          // 메시지 박스 출력
          showMessageBox(context, MessageLevel.info, ConstantValues.kMessageSaved, {
            ConstantValues.kMessageOk: ()=> Navigator.pop(context, true)
          });
        }).catchError((err) {
          // 메시지 박스 출력
          showMessageBox(context, MessageLevel.error, "${ConstantValues.kMessageErrored}[$err]", {
            ConstantValues.kMessageOk: null
          });
          print(err);
        });
      }
    }
  }

  void test(){
    print('a');
  }
}
