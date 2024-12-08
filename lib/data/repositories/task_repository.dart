import 'package:task/data/models/task_model.dart';
import 'package:task/data/services/remote/task_service.dart';

abstract class ITaskRepository {
  Future<TaskModel?> addTask(TaskModel task);
  Future<List<TaskModel>> getAllTasks();
  Future<List<TaskModel>> getAllTasksByUser(String userId);
  Future<TaskModel?> getTaskById(String taskId);
  Future<List<TaskModel>> getAssignedTo(String assignedTo);
  Future<TaskModel?> updateTask(TaskModel task);
  Future<void> deleteTask(String taskId);
}

class TaskRepositoryImp implements ITaskRepository {
  final TaskService taskService;

  TaskRepositoryImp({required this.taskService});

  @override
  Future<TaskModel?> addTask(TaskModel task) {
    return taskService.addTask(task);
  }

  @override
  Future<List<TaskModel>> getAllTasks() {
    return taskService.getAllTasks();
  }

  @override
  Future<List<TaskModel>> getAllTasksByUser(String userId) {
    // Gọi hàm từ TaskService để lấy danh sách công việc theo userId
    return taskService.getAllTasksByUser(userId);
  }

  @override
  Future<TaskModel?> getTaskById(String taskId) {
    // Gọi hàm từ TaskService để lấy công việc theo taskId
    return taskService.getTaskById(taskId);
  }

  @override
  Future<List<TaskModel>> getAssignedTo(String assignedTo) {
    // Gọi hàm từ TaskService để lấy danh sách công việc đã được giao
    return taskService.getAssignedTo(assignedTo);
  }

  @override
  Future<TaskModel?> updateTask(TaskModel task) {
    // Gọi hàm từ TaskService để cập nhật công việc
    return taskService.updateTask(task);
  }

  @override
  Future<void> deleteTask(String taskId) {
    // Gọi hàm từ TaskService để xóa công việc
    return taskService.deleteTask(taskId);
  }
}
