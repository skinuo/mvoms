import 'package:freezed_annotation/freezed_annotation.dart';
part 'common_code.freezed.dart';
part 'common_code.g.dart';

/// 공통 코드 관리
@freezed
class CommonCode with _$CommonCode {
  factory CommonCode({
    required String id,
    required String code,
    required String name,
    String? desc,
    required int orderSeq,
    required String registerId,
    required DateTime registerTime,
    required String useYn,
    required String editorId,
    required DateTime editTime,
  }) = _CommonCode;

  factory CommonCode.fromJson(Map<String, dynamic> json) => _$CommonCodeFromJson(json);
}
