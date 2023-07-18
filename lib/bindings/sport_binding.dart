import 'package:diet_app/controllers/sport_controller.dart';
import 'package:diet_app/controllers/sport_daily_controller.dart';
import 'package:diet_app/services/providers/sport_providers.dart';
import 'package:diet_app/services/repository/sport_repository.dart';
import 'package:get/get.dart';

class SportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SportRepository>(() => SportRepository(Get.find()));
    Get.lazyPut<SportProvider>(() => SportProvider(Get.find()));
    Get.lazyPut<SportController>(() => SportController(Get.find()));
    Get.lazyPut<SportDailyController>(() => SportDailyController(Get.find()));
  }
}
