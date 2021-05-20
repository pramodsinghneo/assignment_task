import 'package:assignment_task/presentation/survey_page/survey_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constant {
  static sizedBox(double height) {
    return SizedBox(height: height);
  }

  static String? phoneNumberValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter phone number";
    } else if (value.length < 10) {
      return "Please enter proper phone number";
    } else {}
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter email id";
    } else if (!value.trim().contains("@")) {
      return "Please enter proper email id";
    } else {}
  }

  static String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return "Please fill the field";
    }
  }

  static String? numberValidator(String? value) {
    if (value!.isEmpty) {
      return "Please fill the field";
    } else if (value.length > 3) {
      return "Please enter proper value";
    }
  }

  static String? dropDownValidator(Item? value) {
    if (value!.id == -1) {
      return "Please fill the field";
    }
  }

  static showToast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 12.0);
  }
}
