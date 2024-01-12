import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:mvoms/models/department.dart';
import 'package:mvoms/models/member.dart';
import 'package:mvoms/models/organization.dart';
import 'package:mvoms/models/pagination.dart';
import 'package:mvoms/utilities/input_widget.dart';

import '../utilities/constants.dart';
import '../utilities/global.dart';
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

  // 부서 목록
  List<Department> _departmentList = [];
  Department _dep = Department.create();

  // 조직원 목록
  List<Member> _memberList = [];

  // 페이징
  List<Widget> _pageButtons = [];
  final int _pageSize = 10;

  // 조직원
  //Member _member = Member.create();

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
          //_orgNames.add(org.name);
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
              Expanded(
                  child: DropdownSearch<Organization>(
                    dropdownDecoratorProps: (const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(enabledBorder: UnderlineInputBorder()))),
                    dropdownBuilder: (context, selectedItem) {
                      return TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(text: _dep.organization.name),
                          decoration: const InputDecoration(
                              labelText: "기관", //enabledBorder: InputBorder.none,
                              //border: UnderlineInputBorder(borderSide: BorderSide.none),
                              border: InputBorder.none,
                              labelStyle: TextStyle(fontSize: ConstantValues.kBodyFontSize)));
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
                          controller: TextEditingController(text: _dep.name),
                          decoration: const InputDecoration(  labelText: "부서", //enabledBorder: InputBorder.none,
                              border: UnderlineInputBorder(borderSide: BorderSide.none),
                              labelStyle: TextStyle(fontSize: ConstantValues.kBodyFontSize)));
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
                  )),
              // 검색어
              Expanded(child:
              TextField(decoration: makeInputDecoration(),
                style: TextStyle(fontSize: ConstantValues.kBodyFontSize),
                textInputAction: TextInputAction.go,
                onSubmitted: (value) async {
                  submitByKeyword(value);
                },
              ))
            ]),
            const SizedBox(height: 10),
            // 결과 출력
            Expanded(child:
            ListView.builder(
              itemCount: _memberList.length,
              itemBuilder: (BuildContext context, int idx) {
                return Container(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    decoration: const BoxDecoration(
                        border: Border(bottom:BorderSide(color: ConstantValues.kColorGray))),
                    child: Row(
                      children: [
                        // 기관
                        Expanded(child: Text(_memberList[idx].department.organization.name)),
                        // 부서
                        Expanded(child: Text(_memberList[idx].department.name)),
                        // 멤버
                        Expanded(child: InkWell(child: Text(_memberList[idx].name), onTap: () {
                          onSelectMember(_memberList[idx]);
                        })),
                      ],
                    ));
              },
            )),
            const SizedBox(height: 10),
            // 결과 출력
            SizedBox(
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
                      onPressed: () => Navigator.pop(context, 'cccc'),
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
    ).then((value) {
      print('get new member dialog: $value');
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
      _dep.organization.name = org.name;
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
    setState(() {
      // 부서명
      _dep.name = dep.name;
    });
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
    String? orgId = _dep.organization.id;
    String? depId = _dep.id;

    // 목록 초기화
    _memberList.clear();

    // 조직원 조회
    var resJson = await _rest.searchMembers(orgId: orgId, depId: depId,
        keyword: _keyword, page: page, size: _pageSize);
    if (resJson['content'].length > 0) {
      for (var json in resJson['content']) {
        _memberList.add(Member.fromJson(json));
      }
    }

    // 페이징
    var pg = Pagination.fromJson(resJson);
    makePagination(pg);
    setState(() { });
  }

  /// 조직원 목록에서 선택함
  ///
  /// - [member]: 선택 조직원
  void onSelectMember(Member member) {
    // 다이얼로그 끄기
    Navigator.pop(context, member);
  }

  void makePagination(Pagination pg) {
    print(pg.toString());

    // 초기화 후 추가
    _pageButtons.clear();

    // 버튼 생성
    int firstPage = (pg.number ~/ _pageSize) * _pageSize;
    int lastPage = firstPage;
    // 이전으로
    if (pg.number >= _pageSize) {
      _pageButtons.add(makePageButton("<<", firstPage-_pageSize, false));
      _pageButtons.add(makePageButton("<", pg.number-1, false));
    }
    for (int i = 0; i < _pageSize; i++) {
      int pageNum = firstPage + i;
      if (pageNum >= pg.totalPages) {
        // 최대 페이지 도달, 다음페이지 없음
        lastPage = -1;
        break;
      }
      // 현재 페이지 여부
      bool curr = pageNum == pg.number;
      _pageButtons.add(makePageButton((pageNum+1).toString(), pageNum, curr));
      // 마지막 페이지
      lastPage = pageNum;
    }
    // 다음으로
    if (lastPage > -1 && lastPage+1 <= pg.totalPages) {
      _pageButtons.add(makePageButton(">", pg.number+1, false));
      _pageButtons.add(makePageButton(">>", lastPage+1, false));
    }
  }

  /// 페이지 버튼 생성
  ///
  /// - [pageTxt]: 페이지텍스트
  /// - [pageNum]: 페이지번호
  /// - [highlighting]: 강조여부
  Widget makePageButton(String pageTxt, int pageNum, bool highlighting) {
    return Flexible(
      child: TextButton(
          child: Text(pageTxt, style: TextStyle(
              decoration: highlighting ? TextDecoration.underline : null,
              fontWeight: highlighting ? FontWeight.bold: FontWeight.normal)),
          onPressed: () {
            // 목록 요청
            getMembers(page: pageNum);
          }
      ),
    );
  }
}

