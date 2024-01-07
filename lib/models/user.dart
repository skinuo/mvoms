import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

/// 사용자 관리
@freezed
class User with _$User {
  factory User({
  required String id,
  required String name,
  String? email,
  String? phone,
  required String usrTypeCd,
  required String password
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}