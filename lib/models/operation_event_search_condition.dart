/// 이벤트 검색 관리
class OperationEventSearchCondition {
    /** 제목 유사검색 조건 */
    String? titleLike;
    /** 이벤트 설명 유사검색 조건 */
    String? evntDescLike;
    /** 상태 코드 */
    String? stateCd;
    /** 발생일시 시작 */
    DateTime? evntTimeStart;
    /** 발생일시 끝 */
    DateTime? evntTimeEnd;
    /** 종결일시 시작 */
    DateTime? closeTimeStart;
    /** 종결일시 끝 */
    DateTime? closeTimeEnd;
    /** 의뢰자명 유사검색 */
    String? requesterNameLike;
    /** 처리자명 유사검색 */
    String? chargerNameLike;
    
    bool checkedTitle = true;
    bool checkedDesc = true;
    bool checkedCharger = true;
    bool checkedRequester = true;
    bool checkedRequesterDepartment = true;
    String? keyword;
}