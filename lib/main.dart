import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'incidentDialog.dart';
import 'login.dart';

/// MVOMS 메인 구현
/// @since 2023.12.30.
void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      useMaterial3: true,
    ),
    //home: const MvHome()));
    debugShowCheckedModeBanner: false,
    home: const MvLogin()));
}

class MvHome extends StatefulWidget {
  const MvHome({super.key});

  @override
  State<MvHome> createState() => _MvHomeState();
}

class _MvHomeState extends State<MvHome> {
  // 세션 스토리지
  static final _storage = new FlutterSecureStorage();
  // 사용자 정보
  Map<String, dynamic> _userMap = {};
  // 사용자 정보 출력 텍스트
  String _userInfoValue = "...";
  // 인시던스 목록
  List<TableRow> _rows = [];
  // 인시던스 목록 개수 표시
  String _incidentCountValue = "...";
  int _newIncidentCount = 0;
  int _notCompleteIncidentCount = 0;

  // 최초 한번 실행
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 사용자 정보 로드
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? userJson = await _storage.read(key: "user");
      if (userJson != null) {
        _userMap = json.decode(userJson);
        _userInfoValue = "${_userMap["userNm"]}(${_userMap["userId"]}), ${_userMap["instt"]}";
      }
    });

    // 인시던스 목록 불러오기
    _rows = getRow();
    // 개수 표시
    _incidentCountValue = "전체 ${_rows.length} 건";
    _newIncidentCount = 0;
    _notCompleteIncidentCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 30,
            backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(text: "home"),
              Tab(text: "incident"),
              Tab(icon: Icon(Icons.star))
            ]),
            title: Row(
              children: [
                Flexible(fit: FlexFit.tight, child: Center(child: new Text(""))),
                Flexible(fit: FlexFit.tight, child: Center(child: new Text("MVOMS"))),
                // 사용자 정보 출력
                Flexible(fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(_userInfoValue, style: const TextStyle(fontSize: 12)),
                  ))
              ],
            )
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            color: const Color.fromRGBO(235, 235, 235, 1),
            child: TabBarView(children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Text("신규", style: TextStyle(fontSize: 12)),
                              Text("$_newIncidentCount", style:
                                const TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold)),
                              const Text("건/", style: TextStyle(fontSize: 12)),
                              const Text("미완료", style: TextStyle(fontSize: 12)),
                              Text("$_notCompleteIncidentCount", style:
                                const TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold)),
                              const Text("건/", style: TextStyle(fontSize: 12)),
                              Text(_incidentCountValue, style: const TextStyle(fontSize: 12)),
                            ],
                          )
                        ),
                        SizedBox(
                          width: 150,
                          child: TextButton(
                            onPressed: () {
                              showIncidentPop(context);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add),
                                Text("인시던스 추가", style: TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ))),
                      ],
                    ),
                    // 간격
                    const SizedBox(
                      height: 20,
                    ),
                    // 인시던스 테이블 헤더 (헤더 고정을 위해 분리)
                    Row(
                      children: [
                        Expanded(
                          child: Table(
                            border: const TableBorder(bottom:
                              BorderSide(color: Color.fromRGBO(235, 235, 235, 1), width: 2)),
                            columnWidths: getIncidentColumnWidths(),
                            children: [
                              TableRow(children: [
                                makeIncidentHeaderCell("요약"),
                                makeIncidentHeaderCell("의뢰자"),
                                makeIncidentHeaderCell("의뢰자부서"),
                                makeIncidentHeaderCell("의뢰일시"),
                                makeIncidentHeaderCell("처리자"),
                                makeIncidentHeaderCell("상태")
                              ])
                            ],
                          ),
                        ),
                      ],
                    ),
                    // 인시던스 테이블 목록
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Table(
                          border: const TableBorder(
                            verticalInside: BorderSide(color: Colors.black12),
                            horizontalInside: BorderSide(color: Colors.black12)),
                          columnWidths: getIncidentColumnWidths(),
                          children: _rows,
                        )
                      ),
                    ),
                  ],
                ),
              ),
              const Text("b"),
              const Text("home"),
            ]),
          ),
        ),
      ),
    );
  }

  /// 인스던스 추가 팝업 열기
  /// @since 2023.12.30.
  void showIncidentPop(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return AlertDialog(
            //contentTextStyle: TextStyle(fontSize: 13),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            title: const Text("인시던트 등록"),
            content: const MvIncidentDialog(),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('취소')),
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('저장')),
            ],
          );
        }));
  }

  /// 인시던스 동적 테이블 로우 반환
  /// @since 2023.12.30.
  List<TableRow> getRow() {
    List<TableRow> row = [];
    for (var i = 0; i < 1000; i++) {
      row.add(TableRow(children: [
        makeIncidentBodyCell("aa ${i.toString()}", TextAlign.left),
        makeIncidentBodyCell("bb ${i.toString()}"),
        makeIncidentBodyCell("cc ${i.toString()}"),
        makeIncidentBodyCell("dd ${i.toString()}"),
        makeIncidentBodyCell("ee ${i.toString()}"),
        makeIncidentBodyCell("ff ${i.toString()}"),
      ]));
    }
    return row;
  }

  /// 인시던스 테이블 바디 셀 생성
  /// @param label 라벨
  /// @param align 정렬
  /// @since 2023.12.30.
  TableCell makeIncidentBodyCell(String label,
      [TextAlign align = TextAlign.center]) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(label, textAlign: align)));
  }

  /// 임시던스 테이블 헤더 셀 생성
  /// @param label 라벨
  /// @since 2023.12.30.
  TableCell makeIncidentHeaderCell(String label) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ));
  }

  /// 인시던스 테이블 컬럼 너비 반환
  /// @since 2023.12.30.
  Map<int, TableColumnWidth> getIncidentColumnWidths() {
    return const <int, TableColumnWidth>{
      0: FlexColumnWidth(5),
      1: FlexColumnWidth(1),
      2: FlexColumnWidth(3),
      3: FlexColumnWidth(2),
      4: FlexColumnWidth(1),
      5: FlexColumnWidth(1),
    };
  }
}
