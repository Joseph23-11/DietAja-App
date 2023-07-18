import 'package:diet_app/controllers/breakfast_controller.dart';
import 'package:diet_app/controllers/dinner_controller.dart';
import 'package:diet_app/controllers/lunch_controller.dart';
import 'package:diet_app/controllers/makanan_controller.dart';
import 'package:diet_app/controllers/snack_controller.dart';
import 'package:diet_app/services/providers/makanan_provider.dart';
import 'package:diet_app/services/repository/makanan_repository.dart';
import 'package:get/get.dart';

class MakananBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MakananRepository>(() => MakananRepository(Get.find()));
    Get.lazyPut<MakananProvider>(() => MakananProvider(Get.find()));
    Get.lazyPut<MakananController>(() => MakananController(Get.find()));
    Get.lazyPut<BreakfastController>(() => BreakfastController(Get.find()));
    Get.lazyPut<LunchController>(() => LunchController(Get.find()));
    Get.lazyPut<DinnerController>(() => DinnerController(Get.find()));
    Get.lazyPut<SnackController>(() => SnackController(Get.find()));
  }
}
