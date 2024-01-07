import 'dart:async';

/// 인증 토큰 갱신기
class AuthUpdater {
  // 토큰
  String token = "";
  // 갱신주기(초)
  int term = 10;
  // 멈출지 여부
  bool _willStop = false;

  // 싱글톤
  AuthUpdater._privateConstructor();
  static final AuthUpdater instance = AuthUpdater._privateConstructor();

  /// 갱신기 동작 실행
  void start() {
    _update();
  }

  /// 갱신기 동작 중지
  void stop() {
    _willStop = true;
  }

  /// 인증 갱신
  void _update() async {
    print('call.... ${DateTime.now()}, token:$token');
    Timer(Duration(seconds: term), (){
      if (!_willStop) {
        _update();
      } else {
        _willStop = false;
      }
    });
  }
}