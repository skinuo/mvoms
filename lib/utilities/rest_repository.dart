import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mvoms/models/operation_event.dart';
import 'package:mvoms/utilities/auth_updater.dart';
import 'package:mvoms/utilities/constants.dart';

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

  /// 상세 이벤트 조회
  ///
  /// - [evntId]: 이벤트아이디
  Future<dynamic> getEventById(String evntId) {
    return req(get: true, uri:'/op-evnet/$evntId');
  }

  /// 이벤트 목록 조회
  Future<dynamic> getEventList({
      required int page,
      int size = 10,
      String? sort,
      String? direction,
      String? title,
    }) {
    return req(get: true, uri:'/op-event/list?pg_page=$page&pg_size=$size');
  }

  /// 이벤트 등록
  ///
  /// - [event]: 이벤트
  Future<dynamic> addEvent({required OperationEvent event}) {
    return req(get: false, uri:'/op-event', data:event);
  }

  /// 기관 모든 목록 조회
  Future<dynamic> getAllOrganizations() {
    return req(get: true, uri:'/org/org/list/all');
  }

  /// 조직원 검색 요청 수행
  ///
  /// - [orgId]: 기관아이디
  /// - [depId]: 부서아이디
  /// - [keyword]: 키워드
  Future<dynamic> searchMembers({required int page, required int size, String? orgId, String? depId, String? keyword}) {
    return req(get: true, uri:'/org/mmbr/search?page=$page&size=$size&'
        'orgId=${orgId??''}&depId=${depId??''}&keyword=${keyword??''}');
  }

  /// 모든 대상 시스템 목록 조회
  Future<dynamic> getAllTargetSystems() {
    return req(get: true, uri:'/org/system/all');
  }

  /// 기관 ID로 부서목록 조회
  Future<dynamic> getDepartmentsByOrgId(String orgId) {
    return req(get: true, uri:'/org/dept/list-by-org/$orgId');
  }

  /// 요청 전송
  ///
  /// - [get]: get방식여부
  /// - [uri]: 요청주소
  Future<dynamic> req({required bool get, required String uri, Object? data}) async {
    late Future<Response<dynamic>> res;
    Options options = Options(headers: {"mvoms.auth.token": _ahtoToken});
    if (get) {
      // get 방식
      res = _dio.get(uri, options: options);
    } else {
      // post 방식
      res = _dio.post(uri, options: options, data: data);
    }
    return res.then((response) {
      // TODO.. 상태코드별 오류 처리
      if (response.statusCode != 200) {
        print("${ConstantValues.kHttpStatus[response.statusCode]}");
        return Future.error(response);
      } else {
        return response.data;
      }
    }, onError: (error) {
      return Future.error(error);
    });
  }
}
