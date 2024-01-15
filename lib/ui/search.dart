import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvoms/models/common_code.dart';
import 'package:mvoms/models/operation_event_search_condition.dart';
import 'package:mvoms/utilities/global.dart';

import '../utilities/input_widget.dart';
import '../utilities/constants.dart';

/// 검색 위젯 구현
class MVOMSSearch extends StatefulWidget {
  // 검색함수
  final Function searchFunc;
  const MVOMSSearch({super.key, required this.searchFunc});

  @override
  State<MVOMSSearch> createState() => _MVOMSSearchState();
}

class _MVOMSSearchState extends State<MVOMSSearch> with InputWidget {
  // 검색조건
  final OperationEventSearchCondition _cond = OperationEventSearchCondition();
  // 상태 코드
  List<CommonCode> _stateCodes = Global.getComCode(ConstantValues.kCodeState);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 상태 코드 기본
    var newCode = CommonCode.create();
    newCode.name = "선택";
    _stateCodes = [newCode,..._stateCodes];
  }

  @override
  Widget build(BuildContext context) {
    print('search build!');
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ConstantValues.kColorBlue
        ),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          backgroundColor: ConstantValues.kColorBlue01,
          title: const Text("검색", style: TextStyle(fontSize: 13)),
          children: [
            // 검색조건
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 70,
                          child: const Text("검색어", style: TextStyle(fontWeight: FontWeight.bold))
                        ),
                        Expanded(
                          child: makeTextCell(
                            controller: TextEditingController(text: _cond.keyword),
                            maxLength: 50,
                            decoration: makeInputDecoration(),
                            onChanged: (v) {
                              _cond.keyword = v;
                            }
                          )
                        ),
                        const SizedBox(width: 80),
                        // 검색어 체크박스
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ListTileTheme(
                                  horizontalTitleGap: 5,
                                  child: CheckboxListTile(
                                    controlAffinity: ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text("제목", style: TextStyle(fontSize: ConstantValues.kBodyFontSize)),
                                    value: _cond.checkedTitle,
                                    onChanged: (value){
                                      setState(()=>_cond.checkedTitle = value!);
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTileTheme(
                                  horizontalTitleGap: 5,
                                  child: CheckboxListTile(
                                    controlAffinity: ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text("내용", style: TextStyle(fontSize: ConstantValues.kBodyFontSize)),
                                    value: _cond.checkedDesc,
                                    onChanged: (value){
                                      setState(()=>_cond.checkedDesc = value!);
                                    }
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTileTheme(
                                  horizontalTitleGap: 5,
                                  child: CheckboxListTile(
                                    controlAffinity: ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text("처리자", style: TextStyle(fontSize: ConstantValues.kBodyFontSize)),
                                    value: _cond.checkedCharger,
                                    onChanged: (value){
                                      setState(()=>_cond.checkedCharger = value!);
                                    }
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTileTheme(
                                  horizontalTitleGap: 5,
                                  child: CheckboxListTile(
                                    controlAffinity: ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text("의뢰자", style: TextStyle(fontSize: ConstantValues.kBodyFontSize)),
                                    value: _cond.checkedRequester,
                                    onChanged: (value){
                                      setState(()=>_cond.checkedRequester = value!);
                                    }
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTileTheme(
                                  horizontalTitleGap: 5,
                                  child: CheckboxListTile(
                                    controlAffinity: ListTileControlAffinity.leading,
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text("의뢰부서", style: TextStyle(fontSize: ConstantValues.kBodyFontSize)),
                                    value: _cond.checkedRequesterDepartment,
                                    onChanged: (value){
                                      setState(()=>_cond.checkedRequesterDepartment = value!);
                                    }
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    // 간격
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 70,
                          child: const Text("발생일시", style: TextStyle(fontWeight: FontWeight.bold))
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              // 발생시작
                              Expanded(
                                child: makeDateCell(
                                  context: context,
                                  controller: TextEditingController(text: _cond.evntTimeStart != null ? DateFormat('yyyy-MM-dd').format(_cond.evntTimeStart!) : ""),
                                  onSelected: (value) {
                                    setState(() => _cond.evntTimeStart = value);
                                  },
                                  lastDate: _cond.evntTimeEnd,
                                  readOnly: true,
                                  decoration: makeInputDecoration(),
                                )
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 20,
                                child: const Text("~")
                              ),
                              // 발생종료
                              Expanded(
                                child: makeDateCell(
                                  context: context,
                                  controller: TextEditingController(text: _cond.evntTimeEnd != null ? DateFormat('yyyy-MM-dd').format(_cond.evntTimeEnd!) : ""),
                                  onSelected: (value) {
                                    setState(() => _cond.evntTimeEnd = value);
                                  },
                                  firstDate: _cond.evntTimeStart,
                                  readOnly: true,
                                  decoration: makeInputDecoration(),
                                )
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 70,
                          child: const Text("종결일시", style: TextStyle(fontWeight: FontWeight.bold))
                        ),
                        Expanded(
                          child: Row(children: [
                            Expanded(
                              child: makeDateCell(
                                context: context,
                                controller: TextEditingController(text: _cond.closeTimeStart != null ? DateFormat('yyyy-MM-dd').format(_cond.closeTimeStart!) : ""),
                                onSelected: (value) {
                                  setState(() {
                                    _cond.closeTimeStart = value;
                                  });
                                },
                                readOnly: true,
                                decoration: makeInputDecoration(),
                              )
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 20,
                              child: const Text("~")
                            ),
                            Expanded(
                              child: makeDateCell(
                                context: context,
                                controller: TextEditingController(text: _cond.closeTimeEnd != null ? DateFormat('yyyy-MM-dd').format(_cond.closeTimeEnd!) : ""),
                                onSelected: (value) {
                                  setState(() {
                                    _cond.closeTimeEnd = value;
                                  });
                                },
                                readOnly: true,
                                decoration: makeInputDecoration(),
                              )
                            )
                          ])
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 70,
                          child: const Text("상태", style: TextStyle(fontWeight: FontWeight.bold))
                        ),
                        Expanded(
                          child: DropdownButtonFormField2<CommonCode>(
                            decoration: makeInputDecoration(padding: 9),
                            style: const TextStyle(fontSize: ConstantValues.kBodyFontSize),
                            isExpanded: true,
                            hint: Text("선택")
                            ,onChanged: (CommonCode? value) {
                              _cond.stateCd = value?.code;
                            },
                            items: _stateCodes.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item.name),
                              );
                            }).toList(),
                            value: _stateCodes[0]
                          )
                        ),
                        // 간격
                        const SizedBox(width: 10),
                        // 검색 버튼
                        SizedBox(
                          width: 80,
                          child: ElevatedButton(
                            onPressed: (){
                              print(_cond);
                              widget.searchFunc.call(page:0, cond:_cond);
                            },
                            child: const Text("검색"),
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
