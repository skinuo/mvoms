import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:mvoms/models/department.dart';
import 'package:mvoms/models/member.dart';
import 'package:mvoms/models/organization.dart';
import 'package:mvoms/models/pagination.dart';
import 'package:mvoms/utilities/input_widget.dart';

import '../utilities/constants.dart';
import '../utilities/rest_repository.dart';
import 'new_member_dialog.dart';

/// 멤버 관리 다이얼로그
class MVOMSMemberDialog extends StatefulWidget {
  const MVOMSMemberDialog({super.key});

  @override
  State<MVOMSMemberDialog> createState() => MVOMSMemberDialogState();
}

class MVOMSMemberDialogState extends State<MVOMSMemberDialog> with InputWidget {
  final _rest = RestRepogitory();
  // 기관 목록
  final List<Organization> _orgList = [];
  Organization _org = Organization.create();

  // 부서 목록
  List<Department> _departmentList = [];
  Department _dep = Department.create();

  // 조직원 목록
  List<Member> _memberList = [];

  // 페이징
  List<Widget> _pageButtons = [];
  final int _recordSize = 10;
  final int _pageSize = 5;

  // 검색어
  String _keyword = "";

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
    print('user_dialog build!');
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      title: const Text("조직원 조회"),
      content: Container(
        width: 550,
        height: 450,
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
                child: const Text("조직원 조회")
            ),
            // 필터
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Row(children: [
                // 기관
                Expanded(
                  child: DropdownSearch<Organization>(
                    dropdownDecoratorProps: (
                      const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                        ))
                    ),
                    dropdownBuilder: (context, selectedItem) {
                      return Stack(children: [
                        Center(child: Text(_org.name == "" ? "기관" : _org.name, textAlign: TextAlign.center)),
                        Positioned(right: 0, child: InkWell(child: Text(_org.name == "" ? "" : "X"),
                          onTap:(){
                            setState(() {
                              _dep = Department.create();
                              _org = Organization.create();
                            });
                          }))
                        ],
                      );
                    },
                    items: _orgList,
                    filterFn: (instance, filter) {
                      return instance.name.contains(filter);
                    },
                    onChanged: (org) {
                      onChangedByOrg(org);
                    },
                    popupProps: PopupProps.menu(
                      isFilterOnline: true,
                      showSearchBox: true,
                      searchFieldProps: (TextFieldProps(decoration: makeInputDecoration())),
                      itemBuilder: (BuildContext context, Organization org, bool isSelected) {
                        return Center(
                          child: Padding(padding: EdgeInsets.all(5), child: Text(org.name)),
                        );
                      },
                    ),
                  )),
                const SizedBox(width: 5),
                // 부서
                Expanded(
                    child: DropdownSearch<Department>(
                      dropdownDecoratorProps: (
                        const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                          ))
                      ),
                      dropdownBuilder: (context, selectedItem) {
                        return Stack(children: [
                          Center(child: Text(_dep.name == "" ? "부서" : _dep.name, textAlign: TextAlign.center)),
                          Positioned(right: 0, child: InkWell(child: Text(_dep.name == "" ? "" : "X", textAlign: TextAlign.right),
                            onTap:(){
                              setState(()=>_dep = Department.create());
                            }))
                        ]);
                      },
                      items: _departmentList,
                      filterFn: (instance, filter) {
                        return instance.name.contains(filter);
                      },
                      onChanged: (dep) {
                        onChangedByDep(dep);
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
                    ))
                ,
                const SizedBox(width: 5),
                // 검색어
                Expanded(
                  child:
                  TextField(
                    style: TextStyle(fontSize: ConstantValues.kDialogFontSize),
                    decoration: makeInputDecoration(labelText: "키워드"),
                    textInputAction: TextInputAction.go,
                    maxLength: 10,
                    onSubmitted: (value) async {
                      submitByKeyword(value);
                    },
                  )
                )
              ]),
            ),
            const SizedBox(height: 10),
            // 결과 출력
            Expanded(
              child:SizedBox(
                child:
                _memberList.length > 0 ?
                  ListView.builder(
                    itemCount: _memberList.length,
                    itemBuilder: (BuildContext context, int idx) {
                      return Container(
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          decoration: const BoxDecoration(
                              border: Border(bottom:BorderSide(color: ConstantValues.kColorGray))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // 기관
                              Expanded(child: Center(child: Text(_memberList[idx].department.organization.name))),
                              // 부서
                              Expanded(child: Center(child: Text(_memberList[idx].department.name))),
                              // 멤버
                              Expanded(child: Center(
                                child: InkWell(child: Text(_memberList[idx].name), onTap: (){
                                  onSelectedMember(_memberList[idx]);
                                }),
                              )),
                            ],
                          ));
                    },
                  ) : const Text("조회된 데이터가 없습니다."),
              )
            ),
            const SizedBox(height: 10),
            // 페이징
            Container(
              height: 40,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _pageButtons,
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: ()=> showNewMemberPop(),
                        child: const Text('신규')),
                  ],
                )),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('취소'))
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 신규 멤버 추가 팝업 열기
  void showNewMemberPop() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return const MVOMSNewMemberDialog();
        })
    ).then((newMember) {
      if (newMember != null) {
        print('get new member dialog: $newMember');
        // 새 멤버 반환
        onSelectedMember(newMember);
      }
    });
  }

  /// 기관 콤보박스 선택 변경
  ///
  /// - [org]: 기관객체
  void onChangedByOrg(org) async {
    // 부서 조회
    var jsonList = await _rest.getDepartmentsByOrgId(org.id);
    setState(() {
      // 기관명
      _org = org;
      // 부서 초기화
      _departmentList.clear();
      // 부서 입력
      for (var json in jsonList) {
        var department = Department.fromJson(json);
        _departmentList.add(department);
      }
    });
  }

  /// 부서 콤보박스 선택 변경
  ///
  /// - [dep]: 부서객체
  void onChangedByDep(dep) {
    _dep = dep;
  }

  /// 키워드로 검색
  ///
  /// - [keyword]: 검색어
  void submitByKeyword(keyword) {
    // 검색어 저장
    _keyword = keyword;
    // 검색
    getMembers();
  }

  /// 조직원 검색
  ///
  /// - [keyword]: 검색어
  void getMembers({int page = 0}) async {
    String? orgId = _org.id;
    String? depId = _dep.id;

    // 목록 초기화
    _memberList.clear();

    // 조직원 조회
    var resJson = await _rest.searchMembers(orgId: orgId, depId: depId,
        keyword: _keyword, page: page, size: _recordSize);
    if (resJson['content'].length > 0) {
      for (var json in resJson['content']) {
        _memberList.add(Member.fromJson(json));
      }
      // 페이징
      var pg = Pagination.fromJson(resJson);
      _pageButtons = makePageButtons(pg, _pageSize, (pageNum){
        getMembers(page: pageNum);
      });
    } else {
      // 결과 없음
      print('none');
    }

    setState(() { });
  }

  /// 조직원 목록에서 선택함
  ///
  /// - [member]: 선택 조직원
  void onSelectedMember(Member member) {
    // 다이얼로그창 닫기
    Navigator.pop(context, member);
  }
}

