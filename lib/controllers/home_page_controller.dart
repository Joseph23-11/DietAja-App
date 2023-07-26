import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

class HomePageController extends GetxController {
  final DateFormat dateFormat = DateFormat("dd MMM");
  final ValueNotifier<String> valDate = ValueNotifier("");

  @override
  void onInit() {
    super.onInit();
    valDate.value = dateFormat.format(DateTime.now());
  }

  void updateSelectedDate(DateTime selectedDate) {
    valDate.value = dateFormat.format(selectedDate);
  }
}
