import 'package:freezed_annotation/freezed_annotation.dart';
part 'pagination.freezed.dart';
part 'pagination.g.dart';

/// 페이징 관리
@freezed
class Pagination with _$Pagination {
  factory Pagination({
    required int totalPages,
    required int totalElements,
    required int size,
    required int number,
    required int numberOfElements,
    required bool first,
    required bool last,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
}