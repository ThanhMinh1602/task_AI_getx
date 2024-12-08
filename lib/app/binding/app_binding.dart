import 'package:get/get.dart';
import 'package:task/app/controllers/auth_controller.dart';
import 'package:task/data/repositories/auth_repository.dart';
import 'package:task/data/repositories/task_repository.dart';
import 'package:task/data/repositories/user_repository.dart';
import 'package:task/app/controllers/user_controller.dart';
import 'package:task/app/controllers/task_controller.dart';
import 'package:task/data/services/remote/auth_service.dart';
import 'package:task/data/services/remote/user_service.dart';
import 'package:task/data/services/remote/task_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Đăng ký service
    Get.put<UserService>(UserService());
    Get.put<TaskService>(TaskService());
    Get.put<AuthService>(AuthService());

    //Đăng ký repository
    Get.put<IUserRepository>(UserRepositoryImp(userService: Get.find()));
    Get.put<ITaskRepository>(TaskRepositoryImp(taskService: Get.find()));
    Get.put<IauthRepository>(AuthRepositoryImp(authService: Get.find()));

    // Đăng ký Controller
    Get.put<UserController>(UserController(userRepository: Get.find()));
    Get.put<TaskController>(TaskController(
      taskRepository: Get.find(),
      userRepository: Get.find(),
    ));
    Get.put<AuthController>(
        AuthController(repository: AuthRepositoryImp(authService: Get.find())));
  }
}
