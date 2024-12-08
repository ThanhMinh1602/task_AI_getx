import 'package:get/get.dart';
import 'package:task/app/data/repositories/auth_repository.dart';
import 'package:task/app/data/services/remote/auth_service.dart';
import 'package:task/app/modules/controllers/auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    // Services
    Get.lazyPut<AuthService>(
      () => AuthService(),
      fenix: true,
    );

    // Repositories
    Get.lazyPut<IAuthRepository>(
      () => AuthRepositoryImpl(
        authService: Get.find<AuthService>(),
      ),
      fenix: true,
    );

    // Controllers
    Get.lazyPut<AuthController>(
      () => AuthController(
        repository: Get.find<IAuthRepository>(),
      ),
      fenix: true,
    );
  }
}
