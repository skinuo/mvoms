import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mvoms/utilities/global.dart';
part 'common_code.freezed.dart';
part 'common_code.g.dart';

/// 공통 코드 관리
@unfreezed
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

  factory CommonCode.create() => CommonCode(id: "", code: "", name: "", orderSeq: 0,
      registerId: Global.user.id!, registerTime: DateTime.now(), useYn: "Y", editorId: Global.user.id!,
      editTime: DateTime.now());

  factory CommonCode.fromJson(Map<String, dynamic> json) => _$CommonCodeFromJson(json);
}
