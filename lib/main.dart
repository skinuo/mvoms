import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mvoms/common_code.dart';
import 'package:mvoms/event.dart';
import 'package:mvoms/rest_repository.dart';
import 'common.dart';
import 'constants.dart';
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

  @override
  State<MvHome> createState() => _MvHomeState();
}

class _MvHomeState extends State<MvHome> with Common {
  // 요청 관리
  final _rest = RestRepogitory();
  // 세션 스토리지
  static const _storage = FlutterSecureStorage();
  // 사용자 정보
  Map<String, dynamic> _userMap = {};

  // 사용자 정보 출력 텍스트
  String _userInfoValue = "...";
  // 공통코드
  final Map<String, List<CommonCode>> _comCodes = {};

  // 페이지 로드 시, 최초 한번 실행
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 사용자 정보 로드
      //printUserInfo();
      initComCode();
    });

    // 공통 코드 초기화
    //initComCode();
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
            backgroundColor: kColorGray,
            centerTitle: true,
            // 탭바 구성
            bottom: const TabBar(tabs: [
              Tab(text: "home"),
              Tab(text: "이벤트"),
              Tab(icon: Icon(Icons.star))
            ]),
            title: Row(
              children: [
                Flexible(fit: FlexFit.tight, child: Center(child: Text(""))),
                Flexible(fit: FlexFit.tight, child: Center(child: Text("MVOMS"))),
                // 사용자 정보 출력
                Flexible(fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(_userInfoValue, style: const TextStyle(fontSize: 12)),
                      SizedBox(width: 10),
                      SizedBox(child:TextButton(
                          onPressed: () {
                            logout();
                          },
                          child: Text("로그아웃", style: TextStyle(fontSize: 12)))
                      )
                    ],
                  ),
                )
              ],
            )
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            color: kColorGray,
            child: DefaultTextStyle.merge(
              // 하위 탭 폰트 사이즈 지정
              style: const TextStyle(fontSize: kBodyFontSize),
              child: const TabBarView(children: [
                // 탭1
                //const Text("home"),
                // 탭2
                MVOMSEvent(),
                // 탭3
                Text("b"),
                Text("home"),
              ]),
            ),
          ),
        ),
      ),
    );
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

  /// 공통코드 초기화
  void initComCode() async {
    var res = await _rest.getComCode('state_cd');
    List<CommonCode> state = [];
    for (var s in res.data as List) {
      CommonCode code = CommonCode.fromJson(s);
      state.add(code);
    }
    Common.comCodes['state_cd'] = state;
  }
}
