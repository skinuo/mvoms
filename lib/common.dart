import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

mixin Common {
  Widget makeCellWithDropdown(String labelText, bool required, List item, String value, Function callback) {
    return DropdownButtonHideUnderline(
        child: DropdownButtonFormField2(
            decoration: makeInputDecoration(labelText, true),
            isExpanded: true,
            onChanged: (item) {
              print(item);
              callback.call(item);
            },
            items: item.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            value: value
        )
    );
  }

  /// 데코레이션 생성
  InputDecoration makeInputDecoration(String labelText, bool required) {
    return InputDecoration(
        labelStyle: TextStyle(fontSize: 12, color: required ? Colors.red : Colors.grey),
        labelText: "$labelText" + (required ? " *" : ""),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey,
              width: 1),
        ),
        isDense: true,
        contentPadding: EdgeInsets.all(12),
        counterText: ""
    );
  }
}