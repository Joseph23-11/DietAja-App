import 'package:diet_app/controllers/auth_controller.dart';
import 'package:diet_app/services/providers/auth_providers.dart';
import 'package:diet_app/services/repository/auth_repository.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find()));
    Get.lazyPut<AuthProvider>(() => AuthProvider(Get.find()));
    Get.lazyPut<AuthController>(() => AuthController(Get.find()));
  }
}
