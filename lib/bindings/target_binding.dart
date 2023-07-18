import 'package:diet_app/controllers/perubahan_berat_controller.dart';
import 'package:diet_app/controllers/target_controller.dart';
import 'package:get/get.dart';

class TargetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TargetController>(() => TargetController(Get.find()));
    Get.lazyPut<PerubahanBeratController>(
        () => PerubahanBeratController(Get.find()));
  }
}
