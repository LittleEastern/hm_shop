import 'package:flutter/material.dart';

class ToastUtils {
  // 阀门控制
  static bool showLoading = false;
  static void showToast(BuildContext context, String msg) {
    if(showLoading) return;
    showLoading = true;
    Future.delayed(Duration(seconds: 3), () {
      showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(40)),
        duration: Duration(seconds: 3),
        content: Text(msg, textAlign: TextAlign.center),
      ),
    );
  }
}