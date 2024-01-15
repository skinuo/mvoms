import 'dart:async';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mvoms/models/operation_event.dart';
import 'package:mvoms/models/operation_event_search_condition.dart';
import 'package:mvoms/utilities/auth_updater.dart';
import 'package:mvoms/utilities/constants.dart';

// http 요청 유형
enum HttpMethodType {get, post, put}

/// REST 요청 관리
class RestRepogitory {
  // 요청 DIO 객체 생성
  static String _ahtoToken = "";
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://localhost:8080",
    contentType: "application/json"
  ));

  /// 멤버 정보 조회
  ///
  /// - [id]: 아이디
  Future<dynamic> getMember(String id) {
    return req(uri: "/org/mmbr/$id");
  }

  /// 로그인 처리
  ///
  /// - [id]: 아이디
  /// - [password]: 비밀번호
  Future<bool> login(String id, String password) async {
    String token = await req(uri: "/login?id=$id&password=$password");
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
    return req(uri: "/code/$id");
  }

  /// 암호화 초기 벡터 문자열 조회
  Future<dynamic> getIV() {
    return req(uri: "/auth-aes256-iv");
  }

  /// 상세 이벤트 조회
  ///
  /// - [evntId]: 이벤트아이디
  Future<dynamic> getEventById(String evntId) {
    return req(uri:'/op-evnet/$evntId');
  }

  /// 이벤트 목록 조회
  ///
  /// - [page]:
  /// - [size]:
  /// - [sort]:
  /// - [direction]:
  /// - [title]:
  Future<dynamic> getEventList({
      required int page,
      int size = 10,
      String? sort,
      String? direction,
      OperationEventSearchCondition? cond
    }) {
    var uri = '/op-event/list?pg_page=$page&pg_size=$size';
    // 키워드로 검색
    if (cond?.keyword != null && cond?.keyword?.replaceAll(" ", "") != "") {
      // 제목
      if (cond?.checkedTitle == true) {
        uri += "&titleLike=${cond?.keyword}";
      }
      // 설명
      if (cond?.checkedDesc == true) {
        uri += "&evntDescLike=${cond?.keyword}";
      }
      // 처리자
      if (cond?.checkedCharger == true) {
        uri += "&requesterNameLike=${cond?.keyword}";
      }
      // 의뢰자
      if (cond?.checkedRequester == true) {
        uri += "&chargerNameLike=${cond?.keyword}";
      }
    }
    // 발생일시
    if (cond?.evntTimeStart != null) {
      uri += "&evntTimeStart=${DateFormat("yyyy-MM-dd HH:mm:ss").format(cond!.evntTimeStart!)}";
    }
    if (cond?.evntTimeEnd != null) {
      uri += "&evntTimeEnd=${DateFormat("yyyy-MM-dd HH:mm:ss").format(cond!.evntTimeEnd!)}";
    }
    // 종결일시
    if (cond?.closeTimeStart != null) {
      uri += "&evntTimeStart=${DateFormat("yyyy-MM-dd HH:mm:ss").format(cond!.closeTimeStart!)}";
    }
    if (cond?.closeTimeEnd != null) {
      uri += "&evntTimeEnd=${DateFormat("yyyy-MM-dd HH:mm:ss").format(cond!.closeTimeEnd!)}";
    }
    // 상태코드
    if (cond?.stateCd != null && cond?.stateCd != "") {
      uri += "&stateCd=${cond?.stateCd}";
    }
    print("검색 : $uri");
    return req(uri: uri);
  }

  /// 이벤트 등록
  ///
  /// - [event]: 이벤트
  Future<dynamic> addEvent(OperationEvent event) {
   /* //print(event.toString());
    print(event.evntTime);
    print(event.evntTime.isUtc);
    event.evntTime = event.evntTime.toUtc();
    //print(event.evntTime.timeZoneName);
    print(event.evntTime.isUtc);
    print(event.evntTime);*/
    return req(methodType: HttpMethodType.post, uri:'/op-event', data:event);
  }

  /// 이벤트 수정
  ///
  /// - [event]: 이벤트
  Future<dynamic> updateEvent(OperationEvent event) {
    return req(methodType: HttpMethodType.put, uri:'/op-event/${event.evntId}', data:event);
  }

  /// 기관 모든 목록 조회
  Future<dynamic> getAllOrganizations() {
    return req(uri:'/org/org/list/all');
  }

  /// 조직원 검색 요청 수행
  ///
  /// - [orgId]: 기관아이디
  /// - [depId]: 부서아이디
  /// - [keyword]: 키워드
  Future<dynamic> searchMembers({required int page, required int size, String? orgId, String? depId, String? keyword}) {
    return req(uri:'/org/mmbr/search?page=$page&size=$size&'
        'orgId=${orgId??''}&depId=${depId??''}&keyword=${keyword??''}');
  }

  /// 모든 대상 시스템 목록 조회
  Future<dynamic> getAllTargetSystems() {
    return req(uri:'/org/system/all');
  }

  /// 기관 ID로 부서목록 조회
  ///
  /// - [orgId]: 기관아이디
  Future<dynamic> getDepartmentsByOrgId(String orgId) {
    return req(uri:'/org/dept/list-by-org/$orgId');
  }

  /// 요청 전송
  ///
  /// - [methodType]: http요청방식
  /// - [uri]: 요청주소
  /// - [data]: body데이터
  Future<dynamic> req({
      HttpMethodType methodType = HttpMethodType.get,
      required String uri,
      Object? data}) async {
    // 응답결과
    late Future<Response<dynamic>> res;
    // 토큰을 물고 요청
    Options options = Options(headers: {ConstantValues.kAuthToken: _ahtoToken});

    // 요청 메소드별 처리
    switch (methodType) {
      case HttpMethodType.get:
        res = _dio.get(uri, options: options);
        break;
      case HttpMethodType.post:
        res = _dio.post(uri, options: options, data: data);
        break;
      case HttpMethodType.put:
        res = _dio.put(uri, options: options, data: data);
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
