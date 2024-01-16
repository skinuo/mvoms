import 'package:flutter/material.dart';

import 'package:mvoms/utilities/input_widget.dart';
import 'package:mvoms/utilities/rest_repository.dart';
import 'package:mvoms/models/organization.dart';

class MVOMSOrganization extends StatefulWidget {
  const MVOMSOrganization({super.key});
  
  @override
  State<MVOMSOrganization> createState() => _MVOMSOrganizationState();
}

class _MVOMSOrganizationState extends State<MVOMSOrganization> with InputWidget {

  int _newOrganizationCount = 0;
  int _notCompleteOrganizationCount = 0;
  String _organizationCountValue = "";
  final _rest = RestRepogitory();

  // 이벤트 목록
  late List<Organization> _rows = [];

  // 페이지 버튼
  late List<Widget> _pageButtons = [];

  // 현재 페이지 번호
  int _curPageNo = 0;
  // 레코드 수
  final int _recordSize = 25;
  // 페이지 수
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();

    // TODO: 조직 목록 가져오기
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Column(
        children: [
          // 헤더
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Text("신규")
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );

  }
  
}