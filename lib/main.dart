import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mvoms/models/common_code.dart';
import 'package:mvoms/models/member.dart';
import 'package:mvoms/ui/event.dart';
import 'package:mvoms/utilities/auth_updater.dart';
import 'package:mvoms/utilities/global.dart';
import 'package:mvoms/utilities/constants.dart';
import 'package:mvoms/utilities/rest_repository.dart';
import 'utilities/input_widget.dart';
import 'ui/login.dart';
import 'dart:html';

/// MVOMS 메인 구현
void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      // 언어 설정
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('ko', 'KR')
      ],
      locale: const Locale('ko'),
      debugShowCheckedModeBanner: false,
      home: const MVOMSMain()));
}

class MVOMSMain extends StatefulWidget {
  const MVOMSMain({super.key});

  @override
  State<MVOMSMain> createState() => _MVOMSMainState();
}

class _MVOMSMainState extends State<MVOMSMain> with InputWidget {
  // 요청 관리
  final _rest = RestRepogitory();
  // 세션 스토리지
  final Storage _localStorage = window.localStorage;
  // 사용자 정보 출력 텍스트
  String _userInfoValue = "...";
  // 메인 로드 여부
  bool loaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('main init!');
      // 초기화
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('main build!');
    if (!loaded) {
      print('main not loaded!');
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      print('main loaded!');
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
                    const Flexible(fit: FlexFit.tight, child: Center(child: Text(""))),
                    const Flexible(
                        fit: FlexFit.tight, child: Center(child: Text("MVOMS"))),
                    // 사용자 정보 출력
                    Flexible(
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_userInfoValue, style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 10),
                          SizedBox(
                            child: TextButton(
                              onPressed: () {
                                print("stop");
                                logout();

                              },
                              child: const Text("로그아웃", style: TextStyle(fontSize: 12)))
                          )
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
                  Text("home"),
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
  }

  /// 사용자 정보를 출력한다.

  void printUserInfo(Member member) async {
      setState(() {
        _userInfoValue = "${member.name} (${member.id}, ${member.department.name})";
      });
  }


  /// 사용자 로그아웃
  void logout() {
    // 인증 갱신 스톱
    AuthUpdater.instance.stop();
    // 스토리지에서 제거
    _localStorage.remove("user");
    // 모든 페이지 제거 하고 이동
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MVOMSLogin()),
        (route) => false);
  }

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

  void init() async {
    if (!_localStorage.containsKey("user")) {
      // 로그인페이지로 이동
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context)=> const MVOMSLogin()), (route) => false);
    } else {
      // 공통 코드 세팅
      await initComCode();

      // 스토리지에서 사용자 정보 가져오기
      var userJson = _localStorage["user"];
      var m = json.decode(userJson!);

      Global.user = Member.fromJson(m);
      print(Global.user.toString());
      // 사용자 정보 출력
      printUserInfo(Global.user);

      // 로딩바 걷고 메인 보이기
      setState(() {
        loaded = true;
      });
    }
  }
}
