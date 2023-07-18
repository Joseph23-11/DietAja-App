import 'package:diet_app/controllers/perubahan_berat_controller.dart';
import 'package:diet_app/services/providers/perubahan_berat_provider.dart';
import 'package:diet_app/services/repository/perubahan_berat_repository.dart';
import 'package:get/get.dart';

class PerubahanBeratBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerubahanBeratRepository>(
        () => PerubahanBeratRepository(Get.find()));
    Get.lazyPut<PerubahanBeratProvider>(
        () => PerubahanBeratProvider(Get.find()));
    Get.lazyPut<PerubahanBeratController>(
        () => PerubahanBeratController(Get.find()));
  }
}
