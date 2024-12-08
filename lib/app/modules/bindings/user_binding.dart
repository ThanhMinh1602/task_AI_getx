import 'package:get/get.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/remote/user_service.dart';
import 'package:task/app/modules/controllers/user_controller.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    // Services
    Get.lazyPut<UserService>(
      () => UserService(),
      fenix: true,
    );

    // Repositories
    Get.lazyPut<IUserRepository>(
      () => UserRepositoryImpl(
        userService: Get.find<UserService>(),
      ),
      fenix: true,
    );

    // Controllers
    Get.lazyPut<UserController>(
      () => UserController(
        repository: Get.find<IUserRepository>(),
      ),
      fenix: true,
    );
  }
}
