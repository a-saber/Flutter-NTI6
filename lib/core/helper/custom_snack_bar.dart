import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum SnackBarState { success, error, warning , info}
abstract class CustomSnackBar {
  static void showSnackBar(String message, SnackBarState state) {
    Color backgroundColor;
    switch (state) {
      case SnackBarState.success:
        backgroundColor = Colors.green;
      case SnackBarState.error:
        backgroundColor = Colors.red;
      case SnackBarState.warning:
        backgroundColor = Colors.yellow;
      case SnackBarState.info:
        backgroundColor = Colors.blue;
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
