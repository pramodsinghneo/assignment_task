import 'package:flutter/material.dart';

class PickDate {
  static Future<DateTime?> datePick(BuildContext context) async {
    return showDatePicker(
        context: context,
        initialDate: DateTime(2018, 3, 5),
        firstDate: DateTime(1950),
        lastDate: DateTime(DateTime.now().year));
  }
}
