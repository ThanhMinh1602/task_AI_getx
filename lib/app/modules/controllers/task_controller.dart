import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task/app/data/models/status_model.dart';
import 'package:task/app/data/models/task_model.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';

class TaskController extends GetxController {
  final ITaskRepository _taskRepository;
  final IUserRepository _userRepository;

  // Form controllers
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();

  // Observable variables
  final tasks = <TaskModel>[].obs;
  final filteredTasks = <TaskModel>[].obs;
  final users = <UserModel>[].obs;
  final selectedUserId = ''.obs;
  final selectedStatus = ''.obs;
  final isLoading = false.obs;

  final statues = StatusModel.statuses;

  TaskController({
    required ITaskRepository taskRepository,
    required IUserRepository userRepository,
  })  : _taskRepository = taskRepository,
        _userRepository = userRepository;

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    try {
      isLoading.value = true;
      await Future.wait([
        fetchTasks(),
        fetchUsers(),
      ]);
    } catch (e) {
      EasyLoading.showError('Failed to load data');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTasks() async {
    try {
      final result = await _taskRepository.getAll();
      tasks.assignAll(result);
      filterTasks();
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> fetchUsers() async {
    try {
      final result = await _userRepository.getAll();
      users.assignAll(result);
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  void filterTasks() {
    if (selectedStatus.isEmpty) {
      filteredTasks.assignAll(tasks);
      return;
    }
    filteredTasks
        .assignAll(tasks.where((task) => task.status == selectedStatus.value));
  }
}
