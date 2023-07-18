import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePageController extends GetxController {
  final DateFormat dateFormat = DateFormat("dd MMM");
  final ValueNotifier<String> valDate = ValueNotifier("");

  @override
  void onInit() {
    super.onInit();

    valDate.value = dateFormat.format(DateTime.now());
  }
}
