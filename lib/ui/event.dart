import 'package:flutter/material.dart';
import 'package:mvoms/ui/search.dart';

import '../utilities/common.dart';
import '../utilities/constants.dart';
import 'event_dialog.dart';

/// 이벤트 위젯 구현
class MVOMSEvent extends StatefulWidget {

  const MVOMSEvent({super.key});

  @override
  State<MVOMSEvent> createState() => _MVOMSEventState();
}

class _MVOMSEventState extends State<MVOMSEvent> with Common {
  late final int _newEventCount;
  late final int _notCompleteEventCount;
  late final String _eventCountValue;

  // 이벤트 목록
  late List<Map> _rows = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newEventCount = 0;
    _notCompleteEventCount = 0;
    _eventCountValue = "";
    _rows = getRow();
  }

  @override
  Widget build(BuildContext context) {
    print('event build!');
    return Container(
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
                  Text("$_newEventCount",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                  const Text("건/", style: TextStyle(fontSize: 12)),
                  const Text("미완료", style: TextStyle(fontSize: 12)),
                  Text("$_notCompleteEventCount",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                  const Text("건/", style: TextStyle(fontSize: 12)),
                  Text(_eventCountValue, style: const TextStyle(fontSize: 12)),
                ],
              )),
              SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {
                        showEventPop(context);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          Text("이벤트 추가",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ))),
            ],
          ),
          // 간격
          const SizedBox(height: 10),
          // 검색바
          const MVOMSSearch(),
          // 간격
          const SizedBox(height: 10),
          // 이벤트 테이블 헤더 (헤더 고정을 위해 분리)
          Row(
            children: [
              Expanded(
                child: Table(
                  border: TableBorder(
                      bottom: BorderSide(color: ConstantValues.kColorGray, width: 2)),
                  columnWidths: getEventHeaderColWidths(),
                  children: [
                    TableRow(children: [
                      makeEventHeaderCell("요약"),
                      makeEventHeaderCell("의뢰자"),
                      makeEventHeaderCell("의뢰자부서"),
                      makeEventHeaderCell("의뢰일시"),
                      makeEventHeaderCell("처리자"),
                      makeEventHeaderCell("상태")
                    ])
                  ],
                ),
              ),
            ],
          ),
          // 이벤트 테이블 목록
          Expanded(
              child: ListView.builder(
            itemCount: _rows.length,
            itemBuilder: (BuildContext context, int idx) {
              return Container(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: ConstantValues.kColorGray))),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 5,
                          child: SizedBox(child: Text("${_rows[idx]["c1"]}"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Center(child: Text("${_rows[idx]["c2"]}"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 3,
                          child: Center(child: Text("${_rows[idx]["c3"]}"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Center(child: Text("${_rows[idx]["c4"]}"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Center(child: Text("${_rows[idx]["c5"]}"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Center(child: Text("${_rows[idx]["c6"]}"))),
                    ],
                  ));
            },
          )),
          // 간격
          const SizedBox(height: 10),
          // 페이징
          Container(
            height: 50,
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //children: getPagination(),
            ),
          )
        ],
      ),
    );
  }

  /// 이벤트 등록 팝업을 보여준다.
  void showEventPop(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return AlertDialog(
            //contentTextStyle: TextStyle(fontSize: 13),
            backgroundColor: ConstantValues.kColorGray,
            surfaceTintColor: Colors.transparent,
            title: const Text("이벤트 등록"),
            content: const MvEventDialog(),
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

  /// 이벤트 테이블 컬럼 너비 객체를 반환한다.
  Map<int, TableColumnWidth> getEventHeaderColWidths() {
    return const <int, TableColumnWidth>{
      0: FlexColumnWidth(5),
      1: FlexColumnWidth(1),
      2: FlexColumnWidth(3),
      3: FlexColumnWidth(2),
      4: FlexColumnWidth(1),
      5: FlexColumnWidth(1),
    };
  }

  /// 이벤트 테이블 헤더 셀을 생성함
  ///
  /// [label]로 헤더 셀의 내용을 채운다.
  TableCell makeEventHeaderCell(String label) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ));
  }

  List<Map> getRow() {
    List<Map> row = [];
    for (var i = 0; i < 100; i++) {
      row.add({
        "index": i,
        "c1": "c1$i",
        "c2": "c2$i",
        "c3": "c3$i",
        "c4": "c4$i",
        "c5": "c5$i",
        "c6": "c6$i"
      });
    }
    return row;
  }
}
