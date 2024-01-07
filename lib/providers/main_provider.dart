import 'package:flutter/cupertino.dart';

import '../models/common_code.dart';

/// 메인 프로바이더
class MainProvider extends ChangeNotifier{
  Map<String, List<CommonCode>> _codes = {};

  List<CommonCode>? getCodes(String id) {
    return _codes[id];
  }

  set codes(Map<String, List<CommonCode>> codes) {
    _codes = codes;
    notifyListeners();
  }
}
