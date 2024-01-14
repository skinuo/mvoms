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
      newOrg.name = _newItemVal;
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
        height: 360,
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                // 기관 필터
                Row(children: [
                    // 기관
                    Expanded(
                        child: DropdownSearch<Organization>(
                          dropdownDecoratorProps: (
                            const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            isDense: true,
                            contentPadding: EdgeInsets.all(0),
                          ))),
                          validator:(Organization? item) {
                            if (_org.name == "") {
                              return ConstantValues.kMessages["Required"];
                            } else {
                              return null;
                            }
                          },
                          dropdownBuilder: (context, selectedItem) {
                            return Stack(children: [
                              Center(child: Text(_org.name == "" ? "기관" : _org.name)),
                              Positioned(right: 0, child: InkWell(child: Text(_org.name == "" ? "" : "X"),
                                onTap:(){
                                  setState(() {
                                    // 초기화
                                    _dep = Department.create();
                                    _org = Organization.create();
                                    _readonlyOrg = true;
                                    _readonlyDep = true;
                                  });
                                }))
                            ]);
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
                              TextFieldProps(decoration: makeInputDecoration(),
                              style: const TextStyle(fontSize: ConstantValues.kDialogFontSize))
                            ),
                            itemBuilder: (BuildContext context, Organization org, bool isSelected) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(org.name, style: TextStyle(
                                      color: org.name == _newItemVal ? Colors.blue : Colors.black))),
                              );
                            },
                          ),
                        )
                    ),
                    const SizedBox(width: 10),
                    // 기관직접입력
                    Expanded(child: TextFormField(
                      readOnly: _readonlyOrg,
                      controller: TextEditingController(text: _org.name),
                      style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                      validator: (value) {
                        if (_org.name == _newItemVal) {
                          return "신규기관명을 입력해 주세요.";
                        } else {
                          return null;
                        }
                      },
                      decoration:
                        InputDecoration(
                        contentPadding: const EdgeInsets.all(13),
                        isDense: true,
                        filled: true,
                        fillColor: _readonlyOrg ? ConstantValues.kColorGray : Colors.white,
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
                    )),
                  ]),
                const SizedBox(height: 10),
                // 부서 필터
                Row(children: [
                  // 부서
                  Expanded(
                      child: DropdownSearch<Department>(
                        dropdownDecoratorProps: (
                          const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                              isDense: true,
                              contentPadding: EdgeInsets.all(3),
                            ))
                        ),
                        validator:(Department? item) {
                          if (_dep.name == "") {
                            return ConstantValues.kMessages["Required"];
                          } else {
                            return null;
                          }
                        },
                        dropdownBuilder: (context, selectedItem) {
                          return Stack(children: [
                            Center(child: Text(_dep.name == "" ? "부서" : _dep.name)),
                            Positioned(right: 0, child: InkWell(child: Text(_dep.name == "" ? "" : "X"),
                              onTap:(){
                                setState(() {
                                  _dep = Department.create();
                                });
                              }))
                          ]);
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
                          searchFieldProps: (TextFieldProps(decoration: makeInputDecoration())),
                          itemBuilder: (BuildContext context, Department department, bool isSelected) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(department.name, style:
                                  TextStyle(color: department.name == _newItemVal ? Colors.blue : Colors.black),)),
                            );
                          },
                        ),
                      )
                  ),
                  const SizedBox(width: 10),
                  // 부서직접입력
                  Expanded(child: TextFormField(
                    readOnly: _readonlyDep,
                    controller: TextEditingController(text: _dep.name),
                    style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                    validator: (value) {
                      if (_dep.name == _newItemVal) {
                        return "신규부서명을 입력해 주세요.";
                      } else {
                        return null;
                      }
                    },
                    decoration:
                    InputDecoration(
                        contentPadding: const EdgeInsets.all(13),
                        isDense: true,
                        filled: true,
                        fillColor: _readonlyDep ? ConstantValues.kColorGray : Colors.white,
                        border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
                  )),
                ]),
                const SizedBox(height: 10),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ConstantValues.kColorBlue),
                    child: const Text("요청자", style: TextStyle(fontWeight: FontWeight.bold))
                ),
                const SizedBox(height: 10),
                SizedBox(child:
                  TextFormField(
                    validator: (value) {
                      if (value!.replaceAll(" ", "") == "") {
                        return ConstantValues.kMessages["Required"];
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                    decoration: makeInputDecoration(labelText: "이름", required: true),
                    controller: TextEditingController(text: _member.name),
                    onChanged: (value) {
                      _member.name = value;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(child:
                  TextField(
                    style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                    decoration: makeInputDecoration(labelText: "mail"),
                    controller: TextEditingController(text: _member.email),
                    maxLength: 50,
                    onChanged: (value) {
                      _member.email = value;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(child:
                  TextField(
                    style: const TextStyle(fontSize: ConstantValues.kDialogFontSize),
                    decoration: makeInputDecoration(labelText: "전화번호"),
                    controller: TextEditingController(text: _member.phone),
                    maxLength: 13,
                    onChanged: (value) {
                      _member.phone = value;
                    },
                  ),
                )
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
            // 기관, 부서, 멤버 합치기
            if (_formKey.currentState!.validate()) {
              _dep.organization = _org;
              _member.department = _dep;
              Navigator.pop(context, _member);
            } else {
              print('error');
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
      department.name = _newItemVal;
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
    _departmentList.clear();
    // 부서 직접입력
    var newDep = Department.create();
    newDep.name = "신규";
    newDep.id = _newItemId;
    _departmentList.add(newDep);

    // 기관직접입력 여부
    if (org.id == _newItemId) {
      // 직접입력
      _org.name = "신규";
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
