import 'package:flutter/material.dart';
import 'package:get/get.dart';

dialog(String msg) {
  Get.dialog(AlertDialog(
    title: Text(
      msg,
      style: TextStyle(
        fontSize: 16,
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("OK"))
    ],
  ));
}

EdgeInsets submitBtnPadding() {
  return EdgeInsets.only(top: 18.0);
}

EdgeInsets inputDecPadding() {
  return EdgeInsets.fromLTRB(10, 0, 0, 0);
}

EdgeInsets buildDropDownWidgetContentPadding() {
  return EdgeInsets.fromLTRB(10, 0, 10, 0);
}

EdgeInsets buildDropDownWidgetPadding() {
  return EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0);
}

EdgeInsets buildSelectioWidgetPadding() {
  return EdgeInsets.only(top: 20.0, bottom: 10.0);
}

EdgeInsets buildDatePickerFieldPadding() {
  return EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0);
}

EdgeInsets datepickermargin() {
  return EdgeInsets.only(top: 2.0);
}

EdgeInsets formPadding() {
  return EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0);
}
