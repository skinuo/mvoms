import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvoms/models/department.dart';
import 'package:mvoms/models/operation_event.dart';
import 'package:mvoms/models/organization.dart';
import 'package:mvoms/models/pagination.dart';
import 'package:mvoms/ui/search.dart';

import '../models/member.dart';
import '../utilities/global.dart';
import '../utilities/input_widget.dart';
import '../utilities/constants.dart';
import '../utilities/rest_repository.dart';
import 'event_dialog.dart';

/// 이벤트 위젯 구현
class MVOMSEvent extends StatefulWidget {
  const MVOMSEvent({super.key});

  @override
  State<MVOMSEvent> createState() => _MVOMSEventState();
}

class _MVOMSEventState extends State<MVOMSEvent> with InputWidget {
  int _newEventCount = 0;
  int _notCompleteEventCount = 0;
  String _eventCountValue = "";
  final _rest = RestRepogitory();

  // 이벤트 목록
  late List<OperationEvent> _rows = [];

  // 페이지 버튼
  late List<Widget> _pageButtons = [];

  // 현재 페이지 번호
  int _curPageNo = 0;
  final int _recordSize = 25;
  final int _pageSize = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 이벤트 목록 가져오기
    getEventList();
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
                        showEventPop(context, "이벤트 추가", false);
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
                  border: const TableBorder(
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
                decoration: const BoxDecoration(
                  border: Border(bottom:BorderSide(color: ConstantValues.kColorGray))),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: SizedBox(
                            child: InkWell(
                              onTap: (){
                                showEventPop(context, "이벤트 상세 조회", true, _rows[idx].evntId);
                              },
                              child: Text("${getRowNum(idx)}, ${_rows[idx].title}",
                                overflow: TextOverflow.ellipsis,
                              ),
                          ))),
                      const Expanded(
                          flex: 1,
                          child: Center(child: Text("-"))),
                      const Expanded(
                          flex: 3,
                          child: Center(child: Text("-"))),
                      Expanded(
                          flex: 2,
                          child: Center(child: Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(_rows[idx].evntTime)))),
                      Expanded(
                          flex: 1,
                          child: Center(child: Text(_rows[idx].charger == null ? "" : _rows[idx].charger!.name))),
                      Expanded(
                          flex: 1,
                          child: Center(child: Text(Global.getComCodeName(ConstantValues.kCodeState, _rows[idx].stateCd)!))),
                    ],
                  ));
            },
          )),
          // 페이징
          SizedBox(
            height: 50,
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
    // 건수
    _eventCountValue = "전체 ${pg.totalElements}건";
    print(pg.toJson());

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
            getEventList(page: pageNum);
          }
      ),
    );
  }

  /// 이벤트 팝업 열기
  /// 
  /// - [context]: 부모컨텍스트
  /// - [title]: 팝업타이틀
  /// - [readOnly]: 조회만가능
  /// - [evntId]: 이벤트아이디(상세조회시사용)
  void showEventPop(BuildContext context, String title, bool readOnly, [String? evntId]) {
    List<Widget> actions = [
      ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('취소'))
    ];
    // 수정가능시 저장버튼 추가
    if (!readOnly) {
      actions.add(ElevatedButton(
        onPressed: () async {
          var now = DateTime.now();
          var userId = "tester";
          /*var event = OperationEvent(title: "test", stateCd:"REQ", evntDesc:"tt", evntTime:now, registerId: userId,
            registerTime:now, useYn:"Y", editorId: userId, editTime: now, requester: Member(
                id: userId, name: userId, department: Department(
                    id: "", name: "", registerId: "", registerTime: now, organization: Organization(
                      id: "", name: "", registerId: userId, registerTime: now, useYn: "Y", editorId: userId, editTime: now
                    ), useYn: 'Y', editorId: userId, editTime: now
                ), registerId: userId, registerTime: now, useYn: "Y", editorId: userId, editTime: now
              ),
            reqMthdCd: "PHONE", reqTpCd: "REQ_REG");
          print(event);*/
          //await _rest.addEvent(event: event);
          Navigator.of(context).pop();
        },
        child: const Text('저장')));
    }
    
    // 다이얼로그호출
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return AlertDialog(
            surfaceTintColor: Colors.transparent,
            title: Text(title),
            content: MVOMSEventDialog(evntId: evntId, readOnly: readOnly),
            actions: actions,
          );
        }));
  }
}
