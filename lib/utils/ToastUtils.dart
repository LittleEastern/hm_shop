import 'package:flutter/material.dart';

class ToastUtils {
  static void showToast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
        duration: Duration(seconds: 5),
        content: Text(msg, textAlign: TextAlign.center),
      ),
    );
  }
}