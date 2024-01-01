import 'package:flutter/material.dart';
import 'package:mvoms/main.dart';

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
                        onSaved: (value) => _id = value as String),
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
                          onSaved: (value) => _password = value as String))
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

  /// 로그인 입력값 검사
  /// @label 라벨
  /// @value 입력값
  /// @since 2024.01.01.
  String? validValue(String label, String? value) {
    if (value == null || value.isEmpty || value.contains(" ")) {
      return '$label는 공백을 포함할 수 없습니다.';
    } else return null;
  }

  /// 로그인 수행
  /// @context context
  /// @since 2024.01.01.
  void login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MvHome()));
    } else {
      print("오류");
    }
  }
}
