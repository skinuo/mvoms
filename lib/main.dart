import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'eventDialog.dart';
import 'login.dart';

/// MVOMS 메인 구현
void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      useMaterial3: true,
    ),
    debugShowCheckedModeBanner: false,
    home: const MvLogin()));
}

class MvHome extends StatefulWidget {
  const MvHome({super.key});
  // 메인 컬러 지정
  static const Color themeColorGray = Color.fromRGBO(235, 235, 235, 1);

  @override
  State<MvHome> createState() => _MvHomeState();
}

class _MvHomeState extends State<MvHome> {
  final _themeColorGray = MvHome.themeColorGray;
  // 세션 스토리지
  static final _storage = new FlutterSecureStorage();
  // 사용자 정보
  Map<String, dynamic> _userMap = {};
  // 사용자 정보 출력 텍스트
  String _userInfoValue = "...";
  // 이벤트 목록
  List<Map> _rows = [];
  // 이벤트 목록 개수 표시
  String _eventCountValue = "...";
  int _newEventCount = 0;
  int _notCompleteEventCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 사용자 정보 로드
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      printUserInfo();
    });

    // 이벤트 목록 불러오기
    _rows = getRow();
    // 개수 표시
    _eventCountValue = "전체 ${_rows.length} 건";
    _newEventCount = 0;
    _notCompleteEventCount = 0;
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
            backgroundColor: _themeColorGray,
            centerTitle: true,
            // 탭바 구성
            bottom: const TabBar(tabs: [
              Tab(text: "home"),
              Tab(text: "이벤트"),
              Tab(icon: Icon(Icons.star))
            ]),
            title: Row(
              children: [
                Flexible(fit: FlexFit.tight, child: Center(child: new Text(""))),
                Flexible(fit: FlexFit.tight, child: Center(child: new Text("MVOMS"))),
                // 사용자 정보 출력
                Flexible(fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Text(_userInfoValue, style: const TextStyle(fontSize: 12)),
                      Text(_userInfoValue, style: const TextStyle(fontSize: 12)),
                      SizedBox(width: 10),
                      SizedBox(child:TextButton(
                          onPressed: () {
                            logout();
                          },
                          child: Text("로그아웃", style: TextStyle(fontSize: 12),))
                      )
                    ],
                  ),
                )
              ],
            )
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            color: _themeColorGray,
            child: DefaultTextStyle.merge(
              // 하위 탭 폰트 사이즈 지정
              style: const TextStyle(fontSize: 12),
              child: TabBarView(children: [
                // 탭1
                //const Text("home"),
                // 탭2
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
                                Text("$_newEventCount", style:
                                  const TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold)),
                                const Text("건/", style: TextStyle(fontSize: 12)),
                                const Text("미완료", style: TextStyle(fontSize: 12)),
                                Text("$_notCompleteEventCount", style:
                                  const TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold)),
                                const Text("건/", style: TextStyle(fontSize: 12)),
                                Text(_eventCountValue, style: const TextStyle(fontSize: 12)),
                              ],
                            )
                          ),
                          SizedBox(
                            width: 150,
                            child: TextButton(
                              onPressed: () {
                                showEventPop(context);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  Text("이벤트 추가", style: TextStyle(fontWeight: FontWeight.bold))
                                ],
                              ))),
                        ],
                      ),
                      // 검색 창
                      Container(
                        child: ExpansionTile(
                          title: Text("검색"),
                          children: [
                            Text("보이냥")
                          ],
                      )),
                      // 이벤트 테이블 헤더 (헤더 고정을 위해 분리)
                      Row(
                        children: [
                          Expanded(
                            child: Table(
                              border: TableBorder(bottom:
                                BorderSide(color: _themeColorGray, width: 2)),
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
                              padding: const EdgeInsets.only(top:3, bottom: 3),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _themeColorGray))),
                              child: Row(
                                children: [
                                  Flexible(fit: FlexFit.tight, flex: 5, child: SizedBox(child: Text("${_rows[idx]["c1"]}"))),
                                  Flexible(fit: FlexFit.tight, flex: 1, child: Center(child: Text("${_rows[idx]["c2"]}"))),
                                  Flexible(fit: FlexFit.tight, flex: 3, child: Center(child: Text("${_rows[idx]["c3"]}"))),
                                  Flexible(fit: FlexFit.tight, flex: 2, child: Center(child: Text("${_rows[idx]["c4"]}"))),
                                  Flexible(fit: FlexFit.tight, flex: 1, child: Center(child: Text("${_rows[idx]["c5"]}"))),
                                  Flexible(fit: FlexFit.tight, flex: 1, child: Center(child: Text("${_rows[idx]["c6"]}"))),
                                ],
                              )
                            );
                          },
                        )
                      ),
                      // 간격
                      const SizedBox(height: 10),
                      // 페이징
                      Container(
                        height: 50,
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: getPagination(),
                        ),
                      )
                    ],
                  ),
                ),
                // 탭3
                const Text("b"),
                const Text("home"),
              ]),
            ),
          ),
        ),
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
            backgroundColor: _themeColorGray,
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

  /// 이벤트 동적 테이블 로우를 반환한다.
  List<Map> getRow() {
    List<Map> row = [];
    for (var i = 0; i < 100; i++) {
      row.add({"index":i, "c1":"c1$i", "c2":"c2$i", "c3":"c3$i", "c4":"c4$i", "c5":"c5$i", "c6":"c6$i"});
    }
    return row;
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

  /// 사용자 정보를 출력한다.
  void printUserInfo() async {
    String? userJson = await _storage.read(key: "user");
    if (userJson != null) {
      _userMap = json.decode(userJson);
      setState(() {
        _userInfoValue = "${_userMap["name"]}(${_userMap["id"]}), [기관자리]";
      });
    }
  }

  /// 사용자 로그아웃
  void logout() {
    _storage.delete(key: "user");
    // 모든 페이지 제거 하고 이동
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)=> const MvLogin()), (route) => false);
  }

  List<Widget> getPagination() {
    List<Widget> lst = [];
    for(int i = 0; i<10; i++) {
      lst.add(TextButton(onPressed: (){}, child: Text((i+1).toString())));
    }
    return lst;
  }
}
