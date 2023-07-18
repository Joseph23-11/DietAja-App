import 'package:diet_app/controllers/daily_diet_controller.dart';
import 'package:diet_app/services/providers/daily_diet_provider.dart';
import 'package:diet_app/services/repository/daily_diet_repository.dart';
import 'package:get/get.dart';

class DailyDietBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyDietRepository>(() => DailyDietRepository(Get.find()));
    Get.lazyPut<DailyDietProvider>(() => DailyDietProvider(Get.find()));
    Get.lazyPut<DailyDietController>(() => DailyDietController(Get.find()));
  }
}
