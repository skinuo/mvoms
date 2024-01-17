import 'package:flutter/material.dart';
import 'package:mvoms/models/pagination.dart';
import 'package:mvoms/ui/organization_search.dart';
import 'package:mvoms/utilities/constants.dart';

import 'package:mvoms/utilities/input_widget.dart';
import 'package:mvoms/utilities/rest_repository.dart';
import 'package:mvoms/models/organization.dart';

class MVOMSOrganization extends StatefulWidget {
  const MVOMSOrganization({super.key});


  @override
  State<MVOMSOrganization> createState() => _MVOMSOrganizationState();
}

class _MVOMSOrganizationState extends State<MVOMSOrganization> with InputWidget {

  // int _newOrganizationCount = 0;
  // int _notCompleteOrganizationCount = 0;
  String _organizationCountValue = "";
  final _rest = RestRepogitory();

  // 이벤트 목록
  late List<Organization> _rows = [];

  // 페이지 버튼
  late List<Widget> _pageButtons = [];

  // 현재 페이지 번호
  int _curPageNo = 0;
  // 레코드 수
  final int _recordSize = 1;
  // 페이지 수
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();

    // 조직 목록 가져오기
    getOrganizationList();
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
            // 헤더
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
                          color: Colors.blue,
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

                                              const SizedBox(height: 10),

                                              OrganizationSearch(searchFunc: getOrganizationList),

                                              const SizedBox(height: 10),

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
                                                            makeOrganizationHeaderCell("id"),
                                                            makeOrganizationHeaderCell("이름"),
                                                            makeOrganizationHeaderCell("이메일"),
                                                            makeOrganizationHeaderCell("번호"),
                                                          ]
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),

                                             // 기관 리스트 뷰
                                             Expanded(
                                               child:  ListView.builder(
                                                 itemCount: _rows.length,
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
                                                             child: Text("${_rows[idx].id}"),
                                                           ),
                                                         ),
                                                         Expanded(
                                                           flex: 1,
                                                           child: Center(
                                                             child: Text("${_rows[idx].name}"),
                                                           ),
                                                         ),Expanded(
                                                           flex: 1,
                                                           child: Center(
                                                             child: Text(_rows[idx].email ?? ''),
                                                           ),
                                                         ),Expanded(
                                                           flex: 1,
                                                           child: Center(
                                                             child: Text(_rows[idx].phone ?? ''),
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
                                                  children: _pageButtons,
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
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.blue, // Adjust color for better visibility
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text("asd"),
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
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: Colors.red,
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

  Map<int, TableColumnWidth> getOrganizationHeaderColWidths() {
    return const <int, TableColumnWidth>{
      0: FlexColumnWidth(1),
      1: FlexColumnWidth(1),
      2: FlexColumnWidth(1),
      3: FlexColumnWidth(1),
    };
  }

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

  /// 조직 목록 조회
  void getOrganizationList({int page = 0, String? keyword}) async{
    // 현재 페이지 저장
    _curPageNo = page;

    var resMap = await _rest.searchOrganization(page : page, size:_recordSize, keyword: keyword);
    print(resMap);
    setState(() {
      // 목록 업데이트
      _rows.clear();

      for(var content in resMap['content']) {
        Organization organization = Organization.fromJson(content);
        _rows.add(organization);
      }
      // 페이징 생성
      Pagination pg = Pagination.fromJson(resMap);
      _pageButtons = makePageButtons(pg, _pageSize, (pageNum){getOrganizationList(page:pageNum);});
      // 건수
      _organizationCountValue = "${pg.totalElements}";
    });
  }

}