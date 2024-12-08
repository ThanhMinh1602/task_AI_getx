import 'package:get/get.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/remote/task_service.dart';
import 'package:task/app/modules/controllers/task_controller.dart';

class TaskBinding implements Bindings {
  @override
  void dependencies() {
    // Services
    Get.lazyPut<TaskService>(
      () => TaskService(),
      fenix: true,
    );

    // Repositories
    Get.lazyPut<ITaskRepository>(
      () => TaskRepositoryImpl(
        taskService: Get.find<TaskService>(),
      ),
      fenix: true,
    );

    // Controllers
    Get.lazyPut<TaskController>(
      () => TaskController(
        taskRepository: Get.find<ITaskRepository>(),
        userRepository: Get.find<IUserRepository>(),
      ),
      fenix: true,
    );
  }
}
