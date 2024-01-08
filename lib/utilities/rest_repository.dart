import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mvoms/utilities/auth_updater.dart';

/// REST 요청 관리
class RestRepogitory {
  static String _ahtoToken = "";
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://localhost:8080",
    contentType: "application/json"
  ));

  /// 유저 정보 조회
  ///
  /// - [id]: 아이디
  Future<dynamic> getUser(String id) {
    return req(get: true, uri: "/user/$id");
  }

  /// 로그인 처리
  ///
  /// - [id]: 아이디
  /// - [password]: 비밀번호
  Future<bool> login(String id, String password) async {
    String token = await req(get: true, uri: "/login?id=$id&password=$password");
    if (token != "") {
      // 토큰 저장
      _ahtoToken = token;

      // 인증 갱신
      AuthUpdater.instance.token = _ahtoToken;
      AuthUpdater.instance.start();

      return true;
    } else {
      return false;
    }
  }

  /// 공통 코드 조회
  ///
  /// - [id]: 코드아이디
  Future<dynamic> getComCode(String id) {
    return req(get: true, uri: "/code/$id");
  }

  /// 암호화 초기 벡터
  Future<dynamic> getIV() {
    return req(get: true, uri: "/auth-aes256-iv");
  }

  Future<dynamic> mytest() {
    return req(get: true, uri:'/mytest');
  }

  Future<dynamic> getEventById(String evntId) {
    return req(get: true, uri:'/op-evnet/$evntId');
  }

  Future<dynamic> getEventList({
      required int page,
      int size = 10,
      String? sort,
      String? direction,
      String? title,
    }) {
    return req(get: true, uri:'/op-event/list?pg_page=$page&pg_size=$size');
  }

  /// 요청 전송
  ///
  /// - [get]: get방식여부
  /// - [uri]: 요청주소
  Future<dynamic> req({required bool get, required String uri}) async {
    late Future<Response<dynamic>> res;
    Options options = Options(headers: {"mvoms.auth.token": _ahtoToken});
    if (get) {
      // get 방식
      res = _dio.get(uri, options: options);
    } else {
      // post 방식
      res = _dio.post(uri, options: options);
    }
    return res.then((response) {
      // 인증오류
      if (response.data == "auth-fail") {
        return Future.error(response);
      } else {
        return response.data;
      }
    }, onError: (error) {
      return Future.error(error);
    });
  }
}
