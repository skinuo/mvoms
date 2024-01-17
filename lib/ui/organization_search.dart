import 'package:flutter/material.dart';
import 'package:mvoms/utilities/constants.dart';
import 'package:mvoms/utilities/input_widget.dart';

class OrganizationSearch extends StatefulWidget {

  final Function searchFunc;
  const OrganizationSearch({super.key, required this.searchFunc});

  @override
  State<StatefulWidget> createState() => _OrganizationSearchState();
}

class _OrganizationSearchState extends State<OrganizationSearch> with InputWidget {

  // 검색 키워드
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return // 검색 창
      Container(
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
                                      controller: TextEditingController(text: keyword),
                                      maxLength: 50,
                                      decoration: makeInputDecoration(),
                                      onChanged: (v){
                                        keyword = v;
                                      }
                                  )
                              ),
                              SizedBox(
                                width: 80,
                                child: ElevatedButton(
                                  onPressed: (){
                                    widget.searchFunc.call(page:0, keyword:keyword);
                                  },
                                  child: const Text("검색"),
                                ),
                              )
                            ]
                        )
                      ],
                    )
                )
            )
          ],
        ),
      );
  }}