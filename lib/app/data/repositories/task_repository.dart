import 'package:task/app/data/services/remote/task_service.dart';

import '../models/task_model.dart';
import 'base/base_repository.dart';

abstract class ITaskRepository extends IBaseRepository<TaskModel> {
  Future<List<TaskModel>> getTasksByUser(String userId);
  Future<List<TaskModel>> getTasksByStatus(String status);
}

class TaskRepositoryImpl extends BaseRepository<TaskModel>
    implements ITaskRepository {
  final TaskService _taskService;

  TaskRepositoryImpl({required TaskService taskService})
      : _taskService = taskService;

  @override
  Future<TaskModel?> create(TaskModel task) async {
    try {
      return await _taskService.create(task);
    } catch (e) {
      print('Error in TaskRepository.create: $e');
      return null;
    }
  }

  @override
  Future<bool> delete(String id) async {
    try {
      await _taskService.delete(id);
      return true;
    } catch (e) {
      print('Error in TaskRepository.delete: $e');
      return false;
    }
  }

  @override
  Future<List<TaskModel>> getAll() async {
    try {
      return await _taskService.getAll();
    } catch (e) {
      print('Error in TaskRepository.getAll: $e');
      return [];
    }
  }

  @override
  Future<TaskModel?> getById(String id) async {
    try {
      return await _taskService.getById(id);
    } catch (e) {
      print('Error in TaskRepository.getById: $e');
      return null;
    }
  }

  @override
  Future<TaskModel?> update(TaskModel task) async {
    try {
      return await _taskService.update(task);
    } catch (e) {
      print('Error in TaskRepository.update: $e');
      return null;
    }
  }

  @override
  Future<List<TaskModel>> getTasksByUser(String userId) async {
    try {
      return await _taskService.getTasksByUser(userId);
    } catch (e) {
      print('Error in TaskRepository.getTasksByUser: $e');
      return [];
    }
  }

  @override
  Future<List<TaskModel>> getTasksByStatus(String status) async {
    try {
      return await _taskService.getTasksByStatus(status);
    } catch (e) {
      print('Error in TaskRepository.getTasksByStatus: $e');
      return [];
    }
  }
}
