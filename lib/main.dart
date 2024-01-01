import 'package:flutter/material.dart';
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
    home: const MvLogin()));
}

class MvHome extends StatefulWidget {
  const MvHome({super.key});

  @override
  State<MvHome> createState() => _MvHomeState();
}

class _MvHomeState extends State<MvHome> {
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
            title: const Text("MVOMS", style: TextStyle(fontSize: 20)),
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
                        const Expanded(
                          child: Text(""),
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
                                    Text(
                                      "인시던스 추가",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
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
                        ),
                      ],
                    ),
                    // 인시던스 테이블 목록
                    Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Table(
                            //border: TableBorder.all(color: Colors.black12),
                            border: const TableBorder(
                                top: BorderSide(color: Colors.black12),
                                verticalInside:
                                    BorderSide(color: Colors.black12),
                                horizontalInside:
                                    BorderSide(color: Colors.black12)),
                            columnWidths: getIncidentColumnWidths(),
                            children: getRow(),
                          )),
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
    for (var i = 0; i < 40; i++) {
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
        child: Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold)));
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
