import 'package:flutter/material.dart';
import 'package:mvoms/models/department.dart';
import 'package:mvoms/models/pagination.dart';
import 'package:mvoms/ui/organization_search.dart';
import 'package:mvoms/utilities/constants.dart';

import 'package:mvoms/utilities/input_widget.dart';
import 'package:mvoms/utilities/rest_repository.dart';
import 'package:mvoms/models/organization.dart';

/// 조직 위젯 구현
class MVOMSOrganization extends StatefulWidget {
  const MVOMSOrganization({super.key});

  @override
  State<MVOMSOrganization> createState() => _MVOMSOrganizationState();
}

class _MVOMSOrganizationState extends State<MVOMSOrganization> with InputWidget {

  // 기관 총 개수
  int _organizationCountValue = 0;

  // 부서 총 개수

  // REST 요청 관리
  final _rest = RestRepogitory();

  // 기관 목록
  late List<Organization> _orgRows = [];

  // 부서 목록
  late List<Department> _deptRows = [];

  // 기관 페이지 버튼
  late List<Widget> _orgPageButtons = [];
  
  // 부서 페이지 버튼
  late List<Widget> _deptPageButtons = [];

  // 현재 기관 페이지 번호
  int _organizationCurPageNo = 0;

  // 현재 부서 페이지 번호
  int _departmentCurPageNo = 0;

  // 현재 조직원 페이지 번호
  int _memberCurPageNo = 0;

  // 레코드 수
  final int _recordSize = 10;
  // 페이지 수
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();

    // 기관 목록 가져오기
    getOrganizationList();

    // 부서 목록 가져오기
    getDepartmentList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.red,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.white, // Adjust color for better visibility
                                        child: Align(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Text("총", style: TextStyle(fontSize: 12)),
                                                  Text(
                                                    "${_organizationCountValue}",
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.red,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  const Text("건", style: TextStyle(fontSize: 12)),
                                                  Spacer(),
                                                  SizedBox(
                                                    width: 150,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        // TODO: 기관 탭
                                                      },
                                                      child: const Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(Icons.add),
                                                          Text("기관 추가")
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              // 간격
                                              const SizedBox(height: 10),

                                              // 기관 검색 창
                                              OrganizationSearch(searchFunc: getOrganizationList),

                                              // 간격
                                              const SizedBox(height: 10),

                                              // 기관 목록 헤더
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Table(
                                                      border: const TableBorder(
                                                        bottom: BorderSide(
                                                          color: ConstantValues.kColorGray, width: 2
                                                        )
                                                      ),
                                                      columnWidths: getOrganizationHeaderColWidths(),
                                                      children: [
                                                        TableRow(
                                                          children: [
                                                            makeOrganizationHeaderCell("아이디"),
                                                            makeOrganizationHeaderCell("기관명"),
                                                            makeOrganizationHeaderCell("이메일"),
                                                            makeOrganizationHeaderCell("번호"),
                                                          ]
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),

                                             // 기관 목록
                                             Expanded(
                                               child:  ListView.builder(
                                                 itemCount: _orgRows.length,
                                                 itemBuilder: (BuildContext context, int idx) {
                                                   return Container(
                                                     padding: const EdgeInsets.only(top: 3, bottom: 3),
                                                     decoration: const BoxDecoration(
                                                         border: Border(bottom:BorderSide(color: ConstantValues.kColorGray))),
                                                     child: Row(
                                                       children: [
                                                         Expanded(
                                                           flex: 1,
                                                           child: Center(
                                                             child: Text("${_orgRows[idx].id}"),
                                                           ),
                                                         ),
                                                         Expanded(
                                                           flex: 1,
                                                           child: Center(
                                                             child: Text(_orgRows[idx].name),
                                                           ),
                                                         ),Expanded(
                                                           flex: 2,
                                                           child: Center(
                                                             child: Text(_orgRows[idx].email ?? '-'),
                                                           ),
                                                         ),Expanded(
                                                           flex: 1,
                                                           child: Center(
                                                             child: Text(_orgRows[idx].phone ?? '-'),
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                   );
                                                 },
                                               ),
                                             ),

                                              // 페이지
                                              SizedBox(
                                                height: 50,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: _orgPageButtons,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // 부서
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        color: Colors.white, // Adjust color for better visibility
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Text("총", style: TextStyle(fontSize: 12)),
                                                  const Text("0", style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold
                                                  )),
                                                  const Text("건", style: TextStyle(fontSize: 12)),
                                                  Spacer(),
                                                  SizedBox(
                                                    width: 150,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        // TODO: 부서 상세 정보 탭
                                                      },
                                                      child: const Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(Icons.add),
                                                          Text("부서 추가")
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),

                                              // 간격
                                              const SizedBox(height: 10),

                                              // 기관 검색 창
                                              OrganizationSearch(searchFunc: getOrganizationList),

                                              // 간격
                                              const SizedBox(height: 10),

                                              // 부서 목록 헤더
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Table(
                                                      border: const TableBorder(
                                                        bottom: BorderSide(
                                                          color: ConstantValues.kColorGray
                                                        )
                                                      ),
                                                      columnWidths: getDepartmentHeaderColWidths(),
                                                      children: [
                                                        TableRow(
                                                          children: [
                                                            makeDepartmentHeaderCell("아이디"),
                                                            makeDepartmentHeaderCell("부서"),
                                                            makeDepartmentHeaderCell("상급 부서"),
                                                            makeDepartmentHeaderCell("관리자"),
                                                          ]
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),

                                              // 부서 목록
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount: _deptRows.length,
                                                  itemBuilder: (BuildContext context, int idx) {
                                                    return Container(
                                                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                                                      decoration: const BoxDecoration(
                                                          border: Border(bottom:BorderSide(color: ConstantValues.kColorGray))),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                              child: Text("${_deptRows[idx].id}"),
                                                            ),
                                                          ),

                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                              child: Text(_deptRows[idx].name),
                                                            ),
                                                          ),

                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                              child: Text(_deptRows[idx].superDepartment?.name ?? ''),
                                                            ),
                                                          ),

                                                          Expanded(
                                                            flex: 1,
                                                            child: Center(
                                                              child: Text(_deptRows[idx].member?.name ?? ''),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),

                                              SizedBox(
                                                height: 50,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: _deptPageButtons,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 조직원
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

  }

  /// 기관 목록 헤더 간격 조정
  Map<int, TableColumnWidth> getOrganizationHeaderColWidths() {
    return const <int, TableColumnWidth> {
      // 아이디
      0: FlexColumnWidth(1),
      // 기관명
      1: FlexColumnWidth(1),
      // 이메일
      2: FlexColumnWidth(2),
      // 번호
      3: FlexColumnWidth(1),
    };
  }

  /// 부서 목록 헤더 간격 조정
  Map<int, TableColumnWidth> getDepartmentHeaderColWidths() {
    return const <int, TableColumnWidth> {
      // 아이디
      0: FlexColumnWidth(1),
      // 부서명
      1: FlexColumnWidth(1),
      // 상급 부서 명
      2: FlexColumnWidth(1),
      // 관리자
      3: FlexColumnWidth(1),
    };
  }

  /// 기관 목록 헤더 생성
  ///
  /// - [label]: 셀 내용
  TableCell makeOrganizationHeaderCell(String label) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ));
  }

  /// 부서 목록 헤더 생성
  ///
  /// - [label]: 셀 내용
  TableCell makeDepartmentHeaderCell(String label) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  /// 기관 목록 조회
  ///
  /// - [page]: 조회된 페이지 번호, 0 부터 시작
  /// - [keyword]: 검색 조건 키워드
  void getOrganizationList({int page = 0, String? keyword}) async {
    // 현재 페이지 저장
    _organizationCurPageNo = page;

    var resMap = await _rest.searchOrganization(page : page, size:_recordSize, keyword: keyword);

    setState(() {
      // 목록 업데이트
      _orgRows.clear();

      for(var content in resMap['content']) {
        Organization organization = Organization.fromJson(content);
        _orgRows.add(organization);
      }
      // 페이징 생성
      Pagination pg = Pagination.fromJson(resMap);
      _orgPageButtons = makePageButtons(pg, _pageSize, (pageNum){getOrganizationList(page:pageNum);});
      // 건수
      _organizationCountValue = pg.totalElements;
    });
  }

  /// 부서 목록 조회
  ///
  void getDepartmentList({int page = 0}) async {
    // 현재 페이지 저장
    _departmentCurPageNo = page;

    // 부서 기본 생성
    var resMap = await _rest.searchDepartment(page: page, size: _recordSize);

    setState(() {
      // 목록 업데이트
      _deptRows.clear();

      for(var content in resMap['content']) {
        Department department = Department.fromJson(content);
        _deptRows.add(department);
      }

      // 페이징 생성
      Pagination pg = Pagination.fromJson(resMap);
      _deptPageButtons = makePageButtons(pg, _pageSize, (pageNum){getDepartmentList(page:pageNum);});
      // 건수
    });
  }
}