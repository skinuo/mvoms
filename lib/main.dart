import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mvoms/models/common_code.dart';
import 'package:mvoms/models/user.dart';
import 'package:mvoms/providers/global_provider.dart';
import 'package:mvoms/ui/event.dart';
import 'package:mvoms/ui/loading.dart';
import 'package:mvoms/utilities/auth_updater.dart';
import 'package:mvoms/utilities/global.dart';
import 'package:mvoms/utilities/constants.dart';
import 'package:mvoms/utilities/rest_repository.dart';
import 'package:provider/provider.dart';
import 'utilities/input_widget_maker.dart';
import 'ui/login.dart';
import 'dart:html';

/// MVOMS 메인 구현
void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MVOMSLoading()));
}

class MVOMSHome extends StatefulWidget {
  const MVOMSHome({super.key});

  @override
  State<MVOMSHome> createState() => _MVOMSHomeState();
}

class _MVOMSHomeState extends State<MVOMSHome> with InputWidgetMaker {
  // 요청 관리
  final _rest = RestRepogitory();

  // 세션 스토리지
  Storage _localStorage = window.localStorage;
  //static const _storage = FlutterSecureStorage();

  // 사용자 정보
  Map<String, dynamic> _userMap = {};

  // 사용자 정보 출력 텍스트
  String _userInfoValue = "...";

  // 공통코드
  final Map<String, List<CommonCode>> _comCodes = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('main init!');
      //initUser();
      print('comcode start');
      await initComCode();
      print('comcode end');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('main build!');

    return Container(
      color: Colors.black12,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              toolbarHeight: 30,
              backgroundColor: ConstantValues.kColorGray,
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
                  Flexible(
                      fit: FlexFit.tight, child: Center(child: Text("MVOMS"))),
                  // 사용자 정보 출력
                  Flexible(
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_userInfoValue,
                            style: const TextStyle(fontSize: 12)),
                        SizedBox(width: 10),
                        SizedBox(
                            child: TextButton(
                                onPressed: () {
                                  print("stop");
                                  AuthUpdater.instance.stop();
                                },
                                child: Text("로그아웃",
                                    style: TextStyle(fontSize: 12))))
                      ],
                    ),
                  )
                ],
              )),
          body: Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            color: ConstantValues.kColorGray,
            child: DefaultTextStyle.merge(
              // 하위 탭 폰트 사이즈 지정
              style: const TextStyle(fontSize: ConstantValues.kBodyFontSize),
              child: const TabBarView(children: [
                // 탭1
                const Text("home"),
                // 탭2
                MVOMSEvent(),
                // 탭3
                Text("b"),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  /// 사용자 정보를 출력한다.
/*
  void printUserInfo() async {
    String? userJson = await _storage.read(key: "user");
    if (userJson != null) {
      _userMap = json.decode(userJson);
      setState(() {
        _userInfoValue = "${_userMap["name"]}(${_userMap["id"]}), [기관자리]";
      });
    }
  }
*/

  /// 사용자 로그아웃
  /*void logout() {
    _storage.delete(key: "user");
    // 모든 페이지 제거 하고 이동
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MVOMSLogin()),
        (route) => false);
  }*/

  /// 공통코드 초기화
  Future initComCode() async {
    List<String> codeIds = [
      ConstantValues.kCodeState,
      ConstantValues.kCodeReqMethod,
      ConstantValues.kCodeReqType
    ];

    for (String id in codeIds) {
      var listJson = await _rest.getComCode(id);
      List<CommonCode> codes = [];
      for (var s in listJson as List) {
        CommonCode code = CommonCode.fromJson(s);
        codes.add(code);
      }
      Global.addComCode(id, codes);
    }
  }

  void initUser() {
    if (!_localStorage.containsKey("user")) {
      // 로그인페이지로 이동
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context)=> const MVOMSLogin()), (route) => false);
    }
  }
}
