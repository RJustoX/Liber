import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static Future<void> _baseToast(
    String message, {
    Color backgroundColor = Colors.blue,
  }) async {
    await Fluttertoast.cancel();

    Fluttertoast.showToast(
      msg: message,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static void info(String message) {
    _baseToast(
      message,
      backgroundColor: Colors.black.withOpacity(0.8),
    );
  }

  static void success(String message) {
    _baseToast(
      message,
      backgroundColor: Colors.blue.withOpacity(0.9),
    );
  }

  static void error(String message) {
    _baseToast(
      message,
      backgroundColor: Colors.red.withOpacity(0.9),
    );
  }
}
