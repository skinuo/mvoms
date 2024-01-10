import 'package:flutter/material.dart';
import 'package:mvoms/models/department.dart';
import 'package:mvoms/models/organization.dart';
import 'package:mvoms/utilities/input_widget.dart';

import '../utilities/constants.dart';
import '../utilities/rest_repository.dart';

/// 멤버 관리 다이얼로그
class MVOMSMemberDialog extends StatefulWidget {
  const MVOMSMemberDialog({super.key});

  @override
  State<MVOMSMemberDialog> createState() => _MVOMSMemberDialogState();
}

class _MVOMSMemberDialogState extends State<MVOMSMemberDialog> with InputWidget {
  final _rest = RestRepogitory();
  // 기관
  final List<Organization> _orgList = [];
  final List<String> _orgNames = ["전체"];
  String _orgName = "";
  // 부서
  List<Department> _departmentList = [];
  List<String> _departmentNames = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _orgName = _orgNames[0];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 기관목록
      var orgJsons = await _rest.getAllOrganizations();

      setState(() {
        for (var json in orgJsons) {
          var org = Organization.fromJson(json);
          _orgList.add(org);
          _orgNames.add(org.name);
        }
        _orgName =_orgNames[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('user_dialog build!');
    return Container(
      width: 550,
      height: 500,
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
              child: const Text("의뢰자 정보")
          ),
          SizedBox(height: 10),
          // 필터
          Row(children: [
            // 기관
            Expanded(child: makeCellWithDropdown(
                item: _orgNames,
                value: _orgName,
                decoration: makeInputDecoration(labelText: "기관", padding: 9),
                onChanged:() {
                  //_rest.getDepartmentsByOrgId()
                }
            )),
            // 부서
            Expanded(child: makeCellWithDropdown(
                item: ["부서"], value: "부서",
                decoration: makeInputDecoration(labelText: "부서", padding: 9),
                onChanged:() {
                  searchUser();
                })),
            // 검색어
            Expanded(child:
              TextField(decoration: makeInputDecoration(),
                style: TextStyle(fontSize: ConstantValues.kBodyFontSize),
                textInputAction: TextInputAction.go,
                onSubmitted: (value) async {
                  searchUser();
                },
              ))
          ]),
          SizedBox(height: 10),
          Expanded(child:
            Container(
            color: Colors.yellow
          ))
        ],
      ),
    );
  }

  /// 사용자 검색
  void searchUser() {

  }
}

