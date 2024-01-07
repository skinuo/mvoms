import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mvoms/utilities/auth_updater.dart';

import '../models/user.dart';

/// REST 요청 관리
class RestRepogitory {
  static String _ahtoToken = "";
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://localhost:8080",
    contentType: "application/json"
  ));

  /// 유저 정보 조회
  ///
  /// [id]로 유저정보를 반환한다.
  Future<String> getUser(String id) {
    return req<String>(get: true, uri: "/user/$id");
  }

  /// 로그인 처리
  Future<bool> login(String id, String password) async {
    String token = await req<String>(get: true, uri: "/login?id=$id&password=$password");
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
  /// [id]코드아이디로 공통코드를 조회한다.
  Future<dynamic> getComCode(String id) {
    return request(get: true, uri: "/code/$id");
  }

  Future<String> getIV() async {
    var res = await request(get: true, uri: "/auth-aes256-iv");
    return res.data;
  }

  Future<T> req<T>({required bool get, required String uri}) async {
      var res = _dio.get<T>(uri,
          options: Options(headers: {"mvoms.auth.token": _ahtoToken}));
      return res.then((response) {
        if (response.data == "auth-fail") {
          return Future.error(response);
        } else {
          return response.data as T;
        }
      }, onError: (error) {
        return Future.error(error);
      });
  }


  /// 요청 전송
  ///
  /// 비동기 메소드[future]의 요청 응답을 선처리 한다.
  /// 요청 오류를 한 곳에서 관리 한다.
  ///
  Future<dynamic> request<T>({required bool get, required String uri}) {
    _dio.get<User>(uri, options: Options(headers: {"mvoms.auth.token": _ahtoToken, "aa":"bb"}));

    if (get) {
      return _request(_dio.get(uri, options: Options(headers: {"mvoms.auth.token": _ahtoToken, "aa":"bb"})));
    } else {
      return _request(_dio.post("path"));
    }
  }
  Future<dynamic> _request(Future<Response<dynamic>> future) {
    return future.then((res) {
      if (res.statusCode != 200) {
        return Future.error(res);
      } else {
        return res;
      }
    }).catchError((error) {
      print(error);
      throw Exception(error);
    });
  }
}
