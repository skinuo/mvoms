import 'package:flutter/material.dart';
import 'package:mvoms/utilities/auth_updater.dart';

import '../models/common_code.dart';
import '../utilities/common.dart';
import '../utilities/constants.dart';

/// 검색 위젯 구현
class MVOMSSearch extends StatefulWidget {
  const MVOMSSearch({super.key});

  @override
  State<MVOMSSearch> createState() => _MVOMSSearchState();
}

class _MVOMSSearchState extends State<MVOMSSearch> with Common {
  // 발생일시
  String _evntTimeStart = "";
  String _evntTimeEnd = "";
  // 종결일시
  String _closeTimeStart = "";
  String _closeTimeEnd = "";

  // 공통코드
  // 상태 코드
  final List<CommonCode> _stateCodes = [];
  final List<String> _stateCodeNms = [];

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
                            child: makeTextCell(maxLength: 50, decoration: makeInputDecoration(), fontSize: ConstantValues.kBodyFontSize)),
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
                              item: _stateCodeNms,
                              value: _stateCodeNms.isNotEmpty ? _stateCodeNms[0]! : "",
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
                                          _evntTimeStart = value.toString();
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
                                          _evntTimeEnd = value.toString();
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
                                          _closeTimeStart = value.toString();
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
                                          _closeTimeEnd = value.toString();
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
