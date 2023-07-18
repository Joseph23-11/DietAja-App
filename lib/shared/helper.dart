import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Future showCustomSnackbar(
    BuildContext context, String message, Color bgColor) async {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: bgColor,
    duration: const Duration(seconds: 2),
  ).show(Get.context!);
}
