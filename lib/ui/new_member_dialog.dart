import 'package:flutter/cupertino.dart';
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
  // 부서
  List<Department> _departmentList = [];

  // 신규 멤버
  final _member = Member.create();
  Department _dep = Department.create();
  Organization _org = Organization.create();

  // 기관직접입력여부
  bool _readonlyOrg = true;
  // 부서직접입력여부
  bool _readonlyDep = true;
  // 직접입력아이템아이디
  final _newItemId = "new";
  final _newItemVal = "신규";

  // 유효성검증
  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 기관직접입력
      var newOrg = Organization.create();
      newOrg.id = _newItemId;
      _orgList.add(newOrg);

      // 기관목록
      var orgJsons = await _rest.getAllOrganizations();
      for (var json in orgJsons) {
        _orgList.add(Organization.fromJson(json));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('new_user_dialog build!');
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      title: const Text("조직원 신규"),
      content: Container(
        width: 400,
        height: 400,
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
                  child: const Text("신규 입력")
                ),
                // 기관 필터
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(children: [
                          // 기관
                          Expanded(
                            child: Column(
                              children: [
                                makeWidgetTitle("기관", true),
                                const SizedBox(height: 3),
                                DropdownSearch<Organization>(
                                  dropdownDecoratorProps: (
                                      DropDownDecoratorProps(dropdownSearchDecoration: makeDecoration())
                                  ),
                                  validator:(Organization? item) => _org.name == "" ? ConstantValues.kMessageRequired : null,
                                  dropdownBuilder: (context, selectedItem) {
                                    return Center(child: Text(_org.name == "" ? "선택" : _org.name,
                                      style: const TextStyle(fontSize: ConstantValues.kDialogFontSize)));
                                  },
                                  items: _orgList,
                                  filterFn: (instance, filter) {
                                    return instance.name.contains(filter);
                                  },
                                  onChanged: (a) {
                                    onChangedByOrg(a);
                                  },
                                  popupProps: PopupProps.menu(
                                    isFilterOnline: true,
                                    showSearchBox: true,
                                    searchFieldProps: (
                                      TextFieldProps(decoration: makeDecoration(),
                                      style: const TextStyle(fontSize: ConstantValues.kDialogFontSize))
                                    ),
                                    itemBuilder: (BuildContext context, Organization org, bool isSelected) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          // 신규 여부에 따른 위젯 생성
                                          // 신규 입력 위젯은 힌트 텍스트를 출력하기 위해 텍스트 필드로 생성. 기본 텍스트는 신규입력명을 받음
                                          child: org.id == _newItemId
                                            ? TextFormField(
                                              controller: TextEditingController(text: org.name),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                                              decoration: InputDecoration(
                                                  hintText: _newItemVal,
                                                  hintStyle: const TextStyle(color: Colors.blue),
                                                  border: InputBorder.none,
                                                  isDense: true,
                                                  contentPadding: EdgeInsets.zero
                                              ))
                                            : Text(org.name, style: const TextStyle(fontSize: ConstantValues.kDialogFontSize))
                                        )
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          ),
                          // 기관직접입력
                          _readonlyOrg ? const SizedBox.shrink()
                          : Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    makeWidgetTitle("신규기관", true),
                                    const SizedBox(height: 3),
                                    TextFormField(
                                      controller: TextEditingController(text: _org.name),
                                      style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                                      onChanged: (v) {
                                        _org.name = v;
                                      },
                                      validator: (value) => _org.name.replaceAll(" ", "").isEmpty ? ConstantValues.kMessageRequired : null,
                                      decoration: makeDecoration()
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ]
                      ),
                      // 부서
                      Row(children: [
                        // 부서
                        Expanded(
                            child: Column(
                              children: [
                                makeWidgetTitle("부서", true),
                                const SizedBox(height: 3),
                                DropdownSearch<Department>(
                                  dropdownDecoratorProps: (
                                      DropDownDecoratorProps(dropdownSearchDecoration: makeDecoration())
                                  ),
                                  validator:(Department? item) => _dep.name == "" ? ConstantValues.kMessageRequired : null,
                                  dropdownBuilder: (context, selectedItem) {
                                    return Center(child: Text(_dep.name == "" ? "선택" : _dep.name,
                                      style: const TextStyle(fontSize: ConstantValues.kDialogFontSize)));
                                  },
                                  items: _departmentList,
                                  filterFn: (instance, filter) {
                                    return instance.name.contains(filter);
                                  },
                                  onChanged: (department) {
                                    // 부서콤보박스변경
                                    onChangedByDep(department);
                                  },
                                  popupProps: PopupProps.menu(
                                    isFilterOnline: true,
                                    showSearchBox: true,
                                    searchFieldProps: (TextFieldProps(
                                      decoration: makeDecoration(),
                                      style: const TextStyle(fontSize: ConstantValues.kDialogFontSize))),
                                    itemBuilder: (BuildContext context, Department department, bool isSelected) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          // 신규 여부에 따른 위젯 생성
                                          // 신규 입력 위젯은 힌트 텍스트를 출력하기 위해 텍스트 필드로 생성. 기본 텍스트는 신규입력명을 받음
                                          child: department.id == _newItemId
                                            ? TextFormField(
                                              controller: TextEditingController(text: department.name),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                                              decoration: InputDecoration(
                                                  hintText: _newItemVal,
                                                  hintStyle: const TextStyle(color: Colors.blue),
                                                  border: InputBorder.none,
                                                  isDense: true,
                                                  contentPadding: EdgeInsets.zero
                                              ))
                                            : Text(department.name, style: const TextStyle(fontSize: ConstantValues.kDialogFontSize))
                                        )
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                        ),
                        // 부서직접입력
                        _readonlyDep ? const SizedBox.shrink()
                        : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                makeWidgetTitle("신규부서", true),
                                const SizedBox(height: 3),
                                TextFormField(
                                  controller: TextEditingController(text: _dep.name),
                                  onChanged: (v) {
                                    _dep.name = v;
                                  },
                                  style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                                  validator: (value) => _dep.name.replaceAll(" ", "").isEmpty ? ConstantValues.kMessageRequired : null,
                                  decoration: makeDecoration(),
                                ),
                              ],
                            ),
                          )
                        )]
                      ),
                      // 이름
                      SizedBox(child:
                        Column(
                          children: [
                            makeWidgetTitle("이름", true),
                            const SizedBox(height: 3),
                            TextFormField(
                              validator: (value) => value!.replaceAll(" ", "") == "" ? ConstantValues.kMessageRequired : null,
                              maxLength: 10,
                              style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                              decoration: makeDecoration(),
                              controller: TextEditingController(text: _member.name),
                              onChanged: (value) {
                                _member.name = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      // 메일
                      SizedBox(child:
                        Column(
                          children: [
                            makeWidgetTitle("mail", false),
                            const SizedBox(height: 3),
                            TextField(
                              style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                              decoration: makeDecoration(),
                              controller: TextEditingController(text: _member.email),
                              maxLength: 50,
                              onChanged: (value) {
                                _member.email = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      // 전화번호
                      SizedBox(child:
                        Column(
                          children: [
                            makeWidgetTitle("전화번호", false),
                            const SizedBox(height: 3),
                            TextField(
                              style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                              decoration: makeDecoration(),
                              controller: TextEditingController(text: _member.phone),
                              maxLength: 13,
                              onChanged: (value) {
                                _member.phone = value;
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소')),
        ElevatedButton(
          onPressed: (){
            if (_formKey.currentState!.validate()) {
              // 새 아이디를 받기위해 신규아이디 초기화
              if (_org.id == _newItemId) _org.id = null;
              if (_dep.id == _newItemId) _dep.id = null;
              // 기관, 부서, 멤버 합치기
              _dep.organization = _org;
              _member.department = _dep;
              Navigator.pop(context, _member);
            } else {
              print('validation fail');
            }
          },
          child: const Text('저장')),
      ],
    );
  }

  /// 부서 콤보박스 변경
  ///
  /// - [department]: 부서객체
  void onChangedByDep(department) {
    // 부서 입력
    _dep = department;

    // 부서직접입력 여부
    if (department.id == _newItemId) {
      _readonlyDep = false;
    } else {
      _readonlyDep = true;
    }
    setState(() { });
  }

  /// 기관 콤보박스 변경
  ///
  /// - [org]: 기관객체
  void onChangedByOrg(org) async {
    // 기관 입력
    _org = org;
    // 부서 초기화
    _dep = Department.create();
    _departmentList.clear();
    // 부서 직접입력
    var newDep = Department.create();
    newDep.id = _newItemId;
    _departmentList.add(newDep);

    // 기관직접입력 여부
    if (org.id == _newItemId) {
      // 직접입력
      _readonlyOrg = false;
    } else {
      _readonlyOrg = true;

      // 부서 조회
      var jsonList = await _rest.getDepartmentsByOrgId(org.id);
      // 부서 입력
      for (var json in jsonList) {
        var department = Department.fromJson(json);
        _departmentList.add(department);
      }
    }
    setState(() { });
  }
}
