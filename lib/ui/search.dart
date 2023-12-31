import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvoms/models/operation_event_search_condition.dart';
import 'package:mvoms/utilities/auth_updater.dart';
import 'package:mvoms/utilities/global.dart';

import '../models/common_code.dart';
import '../utilities/input_widget.dart';
import '../utilities/constants.dart';

/// 검색 위젯 구현
class MVOMSSearch extends StatefulWidget {
  const MVOMSSearch({super.key});

  @override
  State<MVOMSSearch> createState() => _MVOMSSearchState();
}

class _MVOMSSearchState extends State<MVOMSSearch> with InputWidget {

  // 검색조건
  OperationEventSearchCondition _cond = OperationEventSearchCondition();

  // 발생일시
  String _evntTimeStart = "";
  String _evntTimeEnd = "";
  // 종결일시
  String _closeTimeStart = "";
  String _closeTimeEnd = "";

  // 상태 코드
  late final List<String> _stateCodeNames;
  String _stateCodeName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stateCodeNames = Global.getComCode(ConstantValues.kCodeState).map((c) => c.name).toList();
    _stateCodeName = _stateCodeNames[0];
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
                            width: 60,
                            child: const Text("검색어", style: TextStyle(fontWeight: FontWeight.bold))
                        ),
                        SizedBox(
                            width: 250,
                            child: makeTextCell(
                              controller: TextEditingController(text: _cond.titleLike),
                              maxLength: 50,
                              decoration: makeInputDecoration(),
                              fontSize: ConstantValues.kBodyFontSize,
                              onChanged: (v) {
                                _cond.titleLike = v;
                              }
                            )),
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(value: false, onChanged: (value){}),
                              const Text("제목"),
                              Checkbox(value: true, onChanged: (value){}),
                              const Text("내용"),
                              Checkbox(value: true, onChanged: (value){}),
                              const Text("처리자"),
                              Checkbox(value: true, onChanged: (value){}),
                              const Text("의뢰자"),
                              Checkbox(value: true, onChanged: (value){}),
                              const Text("의뢰부서"),
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: const Text("상태", style: TextStyle(fontWeight: FontWeight.bold))
                        ),
                        SizedBox(
                          width: 200,
                          child: makeCellWithDropdown(
                              item: _stateCodeNames,
                              value: _stateCodeName,
                              decoration: makeInputDecoration(),
                              fontSize: ConstantValues.kBodyFontSize,
                              callback: (){}),
                        )
                      ],
                    ),
                    // 간격
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: const Text("발생일시", style: TextStyle(fontWeight: FontWeight.bold))
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  child: makeDateCell(
                                      context: context,
                                      controller: TextEditingController(text: _evntTimeStart),
                                      onSelected: (value) {
                                        setState(() {
                                          _evntTimeStart = DateFormat('yyyy-MM-dd').format(value);
                                        });
                                      },
                                      readOnly: true,
                                      decoration: makeInputDecoration(),
                                      fontSize: ConstantValues.kBodyFontSize
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
                                      controller: TextEditingController(text: _evntTimeEnd),
                                      onSelected: (value) {
                                        setState(() {
                                          _evntTimeEnd = DateFormat('yyyy-MM-dd').format(value);
                                        });
                                      },
                                      readOnly: true,
                                      decoration: makeInputDecoration(),
                                      fontSize: ConstantValues.kBodyFontSize
                                  )
                              ),
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: const Text("종결일시", style: TextStyle(fontWeight: FontWeight.bold))
                        ),
                        Expanded(
                            child: Row(children: [
                              Expanded(
                                  child: makeDateCell(
                                      context: context,
                                      controller: TextEditingController(text: _closeTimeStart),
                                      onSelected: (value) {
                                        setState(() {
                                          _closeTimeStart = DateFormat('yyyy-MM-dd').format(value);
                                        });
                                      },
                                      readOnly: true,
                                      decoration: makeInputDecoration(),
                                      fontSize: ConstantValues.kBodyFontSize
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
                                      controller: TextEditingController(text: _closeTimeEnd),
                                      onSelected: (value) {
                                        setState(() {
                                          _closeTimeEnd = DateFormat('yyyy-MM-dd').format(value);
                                        });
                                      },
                                      readOnly: true,
                                      decoration: makeInputDecoration(),
                                      fontSize: ConstantValues.kBodyFontSize
                                  )
                              )
                            ],
                            )
                        ),
                        // 간격
                        const SizedBox(width: 10),
                        // 검색 버튼
                        SizedBox(
                            width: 80,
                            child: ElevatedButton(
                              onPressed: (){
                                print('검색!');
                                print(_cond.titleLike);
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
