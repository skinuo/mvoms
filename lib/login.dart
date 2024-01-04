import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mvoms/user.dart';
import 'package:mvoms/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mvoms/rest_repository.dart';

/// 로그인 화면 구현
/// @since 2024.01.01
class MvLogin extends StatefulWidget {
  const MvLogin({super.key});

  @override
  State<MvLogin> createState() => _MvLoginState();
}

class _MvLoginState extends State<MvLogin> {
  // 아이디
  String _id = "";
  // 비밀번호
  String _password = "";
  // 폼 유효성 검사를 위한 키
  final _formKey = GlobalKey<FormState>();
  // 세션 스토리지
  static final _storage = new FlutterSecureStorage();
  final _rest = new RestRepogitory();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      goToHome();

      /*var user = await _storage.read(key: "user");
      if (user != null) {
        // 세션 정보가 있으면, 메인페이지로 바로 이동
        goToHome();
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          width: double.infinity,
          color: const Color.fromRGBO(235, 235, 235, 1),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    )
                  ),
                  alignment: Alignment.center,
                  width: 300,
                  height: 40,
                  child: const Text('로그인'),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: Colors.white,
                  width: 300,
                  child: Row(
                    children: [
                      const SizedBox(child: Text("아이디")),
                      const SizedBox(width: 10),
                      Flexible(child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          return validValue("아이디", value);
                        },
                        onChanged: (value) => _id = value.toString()),
                      ),
                    ],
                  )
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        )
                    ),
                    width: 300,
                    child: Row(
                      children: [
                        const SizedBox(child: Text("비밀번호")),
                        const SizedBox(width: 10),
                        Flexible(child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            return validValue("비밀번호", value);
                          },
                          onChanged: (value) => _password = value.toString()))
                      ],
                    )
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    width: 300,
                    child: ElevatedButton(
                      onPressed:() => login(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.all(20)
                      ),
                      child: const Text("로그인",style: TextStyle(color: Colors.white)),
                    )
                )
              ]
            ),
          ),
        ),
      )
    );
  }

  /// 로그인 입력 값을 검사한다.
  ///
  /// [label]은 타이틀 명, [value]는 입력 값이다.
  String? validValue(String label, String? value) {
    if (value == null || value.isEmpty || value.contains(" ")) {
      return '$label는 공백을 포함할 수 없습니다.';
    } else {
      return null;
    }
  }

  /// 로그인을 수행한다.
  void login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // 유저 조회
      /*var res = await _rest.getUser(_id);
      if (res.data == null || res.data == "") {
        print("사용자 검색 실패");
      } else {
        //var user = User.fromJson(res.data);
        var userJson = json.encode(res.data);
        // 세션 쓰기
        await _storage.write(key: "user", value: userJson);
        // 메인 홈으로 이동
        goToHome();
      }*/
      goToHome();
    } else {
      print("오류있어서 로그인 수행 안함");
    }
  }

  /// 메인 페이지로 이동한다.
  void goToHome() {
    // 모든 페이지 제거 하고 이동
    Navigator.pushAndRemoveUntil(context, 
        MaterialPageRoute(builder: (context)=> const MvHome()), (route) => false);
  }
}
