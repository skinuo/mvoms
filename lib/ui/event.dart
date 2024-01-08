import 'package:flutter/material.dart';
import 'package:mvoms/models/operation_event.dart';
import 'package:mvoms/models/pagination.dart';
import 'package:mvoms/ui/search.dart';

import '../utilities/common.dart';
import '../utilities/constants.dart';
import '../utilities/rest_repository.dart';
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
  final _rest = new RestRepogitory();

  // 이벤트 목록
  late List<OperationEvent> _rows = [];

  // 페이지 버튼
  late List<Widget> _pageButtons = [];

  // 현재 페이지 번호
  int _curPageNo = 0;
  int _recordSize = 10;
  int _pageSize = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 이벤트 목록 가져오기
    getEventList();

    _newEventCount = 0;
    _notCompleteEventCount = 0;
    _eventCountValue = "";
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
                      bottom: BorderSide(
                          color: ConstantValues.kColorGray, width: 2)),
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
                  border: Border(bottom:BorderSide(color: ConstantValues.kColorGray))),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 5,
                          child: SizedBox(child: Text("${getRowNum(idx)}, ${_rows[idx].title}",
                            overflow: TextOverflow.ellipsis,))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Center(child: Text("-"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 3,
                          child: Center(child: Text("-"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Center(child: Text("${_rows[idx].evntTime}"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Center(child: Text("-"))),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Center(child: Text("${_rows[idx].stateCd}"))),
                    ],
                  ));
            },
          )),
          // 페이징
          Container(
            height: 50,
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _pageButtons,
            ),
          )
        ],
      ),
    );
  }

  int getRowNum(int idx) => _recordSize * (_curPageNo+1) - _recordSize + idx + 1;

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
  /// - [label]: 셀 내용
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

  /// 이벤트 목록 조회
  ///
  /// - [page]: 조회 페이지 번호, 0부터 시작
  void getEventList({int page = 0}) async {
    // 현재 페이지 저장
    _curPageNo = page;
    print("목록 조회: $page");
    // 목록 조회
    var resMap = await _rest.getEventList(page: page, size: _recordSize);

    setState(() {
      // 목록 업데이트
      _rows.clear();
      for (var content in resMap['content']) {
        OperationEvent event = OperationEvent.fromJson(content);
        _rows.add(event);
      }
      // 페이징 생성
      makePagination(resMap);
    });
  }

  /// 페이지버튼 생성
  ///
  /// - [resMap]: 응답받은 페이지 Map 객체
  void makePagination(Map<String, dynamic> resMap) {
    Pagination pg = Pagination.fromJson(resMap);
    print(pg.toJson());

    // 초기화 후 추가
    _pageButtons.clear();

    // 버튼 생성
    int firstPage = (pg.number ~/ _pageSize);
    int lastPage = firstPage;
    firstPage = pg.number >= _pageSize ? firstPage * _pageSize : firstPage;
    // prev

    print('firstPage: $firstPage');
    for (int i = 0; i < _pageSize; i++) {
      int pageNum = firstPage + i;
      // 현재 페이지 여부
      bool curr = pageNum == pg.number;
      _pageButtons.add(makePageButton((pageNum+1).toString(), pageNum, curr));
      // 마지막 페이지
      lastPage = pageNum;
    }
    // next
    if (lastPage+1 <= pg.totalPages) {
      _pageButtons.add(makePageButton(">", lastPage+1, false));
    }
  }

  Widget makePageButton(String pageTxt, int pageNum, bool bold) {
    return Flexible(
      child: TextButton(
          child: Text(pageTxt, style: TextStyle(
              fontWeight: bold ? FontWeight.bold: FontWeight.normal)),
          onPressed: () {
            // 목록 요청
            getEventList(page: pageNum);
          }
      ),
    );
  }
}
