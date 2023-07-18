import 'package:diet_app/controllers/user_controller.dart';
import 'package:diet_app/services/providers/user_provider.dart';
import 'package:diet_app/services/repository/user_repository.dart';
import 'package:get/get.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(() => UserRepository(Get.find()));
    Get.lazyPut<UserProvider>(() => UserProvider(Get.find()));
    Get.lazyPut<UserController>(() => UserController(Get.find()));
  }
}
