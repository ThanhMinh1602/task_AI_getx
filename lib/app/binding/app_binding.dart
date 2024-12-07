import 'package:get/get.dart';
import 'package:task/app/repositories/task_repository.dart';
import 'package:task/app/repositories/user_repository.dart';
import 'package:task/app/controllers/user_controller.dart';
import 'package:task/app/controllers/task_controller.dart';
import 'package:task/app/services/remote/user_service.dart';
import 'package:task/app/services/remote/task_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Đăng ký service
    Get.lazyPut<UserService>(() => UserService());
    Get.lazyPut<TaskService>(() => TaskService());

    //Đăng ký repository
    Get.lazyPut<IUserRepository>(
        () => UserRepositoryImp(userService: Get.find()));
    Get.lazyPut<ITaskRepository>(
        () => TaskRepositoryImp(taskService: Get.find()));

    // Đăng ký Controller
    Get.lazyPut<UserController>(
        () => UserController(userRepository: Get.find()));
    Get.lazyPut<TaskController>(() => TaskController(
          taskRepository: Get.find(),
          userRepository: Get.find(),
        ));
  }
}
