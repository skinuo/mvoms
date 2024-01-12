import 'package:flutter/material.dart';
import 'package:mvoms/models/department.dart';
import 'package:mvoms/models/organization.dart';
import 'package:mvoms/utilities/input_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../models/member.dart';
import '../utilities/constants.dart';
import '../utilities/rest_repository.dart';

/// 신규 멤버 관리 다이얼로그
class MVOMSNewMemberDialog extends StatefulWidget {
  const MVOMSNewMemberDialog({super.key});

  @override
  State<MVOMSNewMemberDialog> createState() => _MVOMSNewMemberDialogState();
}

class _MVOMSNewMemberDialogState extends State<MVOMSNewMemberDialog> with InputWidget {
  final _rest = RestRepogitory();

  // 기관
  final List<Organization> _orgList = [];
  String _orgName = "";

  // 부서
  List<Department> _departmentList = [];
  String _departmentName = "";

  Organization org = Organization(id: "", name: "", registerId: "", registerTime: DateTime.now(), useYn: "", editorId: "", editTime: DateTime.now());
  
  // 신규 멤버
  //Member2 member = Member2();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 기관목록
      var orgJsons = await _rest.getAllOrganizations();
      setState(() {
        for (var json in orgJsons) {
          var org = Organization.fromJson(json);
          _orgList.add(org);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('new_user_dialog build!');
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      title: const Text("조직원 신규"),
      content: Container(
        width: 550,
        height: 350,
        color: Colors.white,
        child: Column(
          children: [
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ConstantValues.kColorBlue),
                child: const Text("기관 및 부서", style: TextStyle(fontWeight: FontWeight.bold))),
            const SizedBox(height: 10),
            // 필터
            Row(children: [
              // 기관
              Expanded(
                  child: DropdownSearch<Organization>(
                    dropdownDecoratorProps: (const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(enabledBorder: UnderlineInputBorder()))),
                    dropdownBuilder: (context, selectedItem) {
                      return TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(text: _orgName),
                          decoration: const InputDecoration(
                              labelText: "기관", //enabledBorder: InputBorder.none,
                              border: UnderlineInputBorder(borderSide: BorderSide.none),
                              labelStyle: TextStyle(fontSize: ConstantValues.kBodyFontSize)));
                    },
                    items: _orgList,
                    filterFn: (instance, filter) {
                      return instance.name.contains(filter);
                    },
                    onChanged: (a) {
                      searchDepartment(a);
                    },
                    popupProps: PopupProps.menu(
                      isFilterOnline: true,
                      showSearchBox: true,
                      searchFieldProps: (TextFieldProps(decoration: makeInputDecoration())),
                      itemBuilder: (BuildContext context, Organization org, bool isSelected) {
                        return Center(
                          child: Padding(
                              padding: EdgeInsets.all(5), child: Text(org.name)),
                        );
                      },
                    ),
                  )),
              const SizedBox(width: 15),
              // 부서
              Expanded(
                  child: DropdownSearch<Department>(
                    dropdownDecoratorProps: (const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(enabledBorder: UnderlineInputBorder()))),
                    dropdownBuilder: (context, selectedItem) {
                      return TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(text: _departmentName),
                          decoration: const InputDecoration(  labelText: "부서", //enabledBorder: InputBorder.none,
                              border: UnderlineInputBorder(borderSide: BorderSide.none),
                              labelStyle: TextStyle(fontSize: ConstantValues.kBodyFontSize)));
                    },
                    items: _departmentList,
                    filterFn: (instance, filter) {
                      return instance.name.contains(filter);
                    },
                    onChanged: (a) {
                      setState(() {
                        _departmentName = a!.name;
                      });
                    },
                    popupProps: PopupProps.menu(
                      isFilterOnline: true,
                      showSearchBox: true,
                      searchFieldProps:
                      (TextFieldProps(decoration: makeInputDecoration())),
                      itemBuilder: (BuildContext context, Department department, bool isSelected) {
                        return Center(
                          child: Padding( padding: EdgeInsets.all(5), child: Text(department.name)),
                        );
                      },
                    ),
                  )),
            ]),
            const SizedBox(height: 20),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ConstantValues.kColorBlue),
                child: const Text("요청자", style: TextStyle(fontWeight: FontWeight.bold))
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                  child: Column(
                    children: [
                      SizedBox(child:
                        TextField(
                          decoration:makeInputDecoration(labelText: "이름", required: true),
                          controller: TextEditingController(text: org.name),
                          onChanged: (value) {
                            org.name = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(child: makeTextCell(decoration: makeInputDecoration(labelText: "mail"), maxLength: 50)),
                      const SizedBox(height: 10),
                      SizedBox(child: makeTextCell(decoration: makeInputDecoration(labelText: "전화번호"), maxLength: 11, onlyNumber: true))
                    ],
                  )
              ),
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context, 'cccc'),
          child: const Text('취소')),
        ElevatedButton(
          onPressed: (){
            // 신규 조직원
            setState(() { });
            print('orgname: ${org.toString()}');
            //Navigator.pop(context, member.name);
          },
          child: const Text('저장')),
      ],
    );
  }

  /// 부서를 검색
  ///
  /// - [org]: 기관객체
  void searchDepartment(org) async {
    // 부서 조회
    var jsonList = await _rest.getDepartmentsByOrgId(org.id);
    setState(() {
      _orgName = org.name;
      // 부서 초기화
      _departmentList.clear();
      // 부서 입력
      for (var json in jsonList) {
        var department = Department.fromJson(json);
        _departmentList.add(department);
      }
    });
  }
}
