import 'package:get/get.dart';
import 'package:task/app/data/repositories/auth_repository.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/remote/auth_service.dart';
import 'package:task/app/data/services/remote/task_service.dart';
import 'package:task/app/data/services/remote/user_service.dart';
import 'package:task/app/shared/controllers/auth_controller.dart';
import 'package:task/app/shared/controllers/task_controller.dart';
import 'package:task/app/shared/controllers/user_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Đăng ký service
    Get.put<UserService>(UserService());
    Get.put<TaskService>(TaskService());
    Get.put<AuthService>(AuthService());

    //Đăng ký repository
    Get.put<IUserRepository>(UserRepositoryImpl(userService: Get.find()));
    Get.put<ITaskRepository>(TaskRepositoryImpl(taskService: Get.find()));
    Get.put<IAuthRepository>(AuthRepositoryImpl(authService: Get.find()));

    //Đăng ký controller
    Get.put<UserController>(UserController());
    Get.put<TaskController>(TaskController());
    Get.put<AuthController>(AuthController());
  }
}
