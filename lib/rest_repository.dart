import 'package:dio/dio.dart';

/// REST 요청 관리
class RestRepogitory {
  static final _dio = Dio(BaseOptions(
    baseUrl: "http://localhost:8080",
    headers: {"Content-Type": "application/json"},
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 5000),
  ));

  /// 유저 정보 조회
  ///
  /// [id]로 유저정보를 반환한다.
  Future<dynamic> getUser(String id) {
    // TODO.. 비밀번호 암호화 하여 전송하기
    return request(_dio.get("/user/$id"));
  }

  /// 공통 코드 조회
  ///
  /// [id]코드아이디로 공통코드를 조회한다.
  Future<dynamic> getComCode(String id) {
    return request(_dio.get("/code/$id"));
  }

  /// 요청 전송
  ///
  /// 비동기 메소드[future]의 요청 응답을 선처리 한다.
  /// 요청 오류를 한 곳에서 관리 한다.
  Future<dynamic> request(Future<Response<dynamic>> future) {
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
