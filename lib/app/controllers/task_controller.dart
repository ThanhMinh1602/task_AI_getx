import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task/app/models/status_model.dart';
import 'package:task/app/models/task_model.dart';
import 'package:task/app/models/user_model.dart';
import 'package:task/app/repositories/task_repository.dart';
import 'package:task/app/repositories/user_repository.dart';
import 'package:task/core/utils/string_format.dart';

class TaskController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();

  final users = <UserModel>[].obs;
  final tasks = <TaskModel>[].obs;
  final filteredTasks = <TaskModel>[].obs;
  final statuses = StatusModel.status.obs;
  final selectedUserId = ''.obs;
  final selectedStatus = ''.obs;

  final ITaskRepository _taskRepository;
  final IUserRepository _userRepository;

  TaskController({
    required ITaskRepository taskRepository,
    required IUserRepository userRepository,
  })  : _taskRepository = taskRepository,
        _userRepository = userRepository;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    await Future.wait([_fetchUsers(), _fetchTasks()]);
  }

  Future<void> _fetchUsers() async {
    try {
      final fetchedUsers = await _userRepository.getAllUsers();
      users.assignAll(fetchedUsers);
    } catch (e) {
      EasyLoading.showError("Failed to fetch users: $e");
    }
  }

  Future<void> _fetchTasks() async {
    try {
      final fetchedTasks = await _taskRepository.getAllTasks();
      tasks.assignAll(fetchedTasks);
    } catch (e) {
      EasyLoading.showError("Failed to fetch tasks: $e");
    }
  }

  void initializeTask(TaskModel? taskModel) {
    if (taskModel == null) {
      resetFields();
    } else {
      titleController.text = taskModel.title;
      descriptionController.text = taskModel.description;
      selectedUserId.value = taskModel.assignTo;
      selectedStatus.value = taskModel.status;
      dueDateController.text = taskModel.dueDate;
    }
  }

  void filterTasksByStatus(String status) {
    filteredTasks.assignAll(tasks.where((task) => task.status == status));
  }

  int getStatusCount(String status) =>
      tasks.where((task) => task.status == status).length;

  void resetFields() {
    descriptionController.clear();
    titleController.clear();
    selectedUserId.value = '';
    selectedStatus.value = '';
    dueDateController.clear();
  }

  void selectUser(String? id) => selectedUserId.value = id ?? '';

  void selectStatus(String? newStatus) =>
      selectedStatus.value = newStatus ?? '';

  String getUserNameById(String userId) {
    // Lọc danh sách các nhiệm vụ (tasks) với assignTo trùng với userId
    final user = users.firstWhere(
      (task) => task.id == userId,
    );

    // Nếu tìm thấy task, trả về tên của người dùng, nếu không trả về "Unknown"
    return user.name;
  }

  void selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dueDateController.text = StringFormat.formatDate(picked);
    }
  }

  void addTask() async {
    if (formKey.currentState?.validate() ?? false) {
      EasyLoading.show(status: 'Adding task...');
      final task = TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        dueDate: dueDateController.text,
        status: selectedStatus.value,
        assignTo: selectedUserId.value,
      );

      try {
        final addedTask = await _taskRepository.addTask(task);
        if (addedTask != null) {
          EasyLoading.showSuccess('Task added successfully!');
          resetFields();
          fetchData();
          Get.back();
        }
      } catch (e) {
        EasyLoading.showError("Failed to add task: $e");
      }
    }
  }

  void updateTask(String taskId) async {
    if (formKey.currentState?.validate() ?? false) {
      EasyLoading.show(status: 'Updating task...');
      final task = TaskModel(
        id: taskId,
        title: titleController.text,
        description: descriptionController.text,
        dueDate: dueDateController.text,
        status: selectedStatus.value,
        assignTo: selectedUserId.value,
      );

      try {
        final updateTask = await _taskRepository.updateTask(task);
        if (updateTask != null) {
          EasyLoading.showSuccess('Task updated successfully!');
          resetFields();
          fetchData();
          Get.back();
        }
      } catch (e) {
        EasyLoading.showError("Failed to update task: $e");
      }
    }
  }

  void deleteTask(String taskId) async {
    try {
      EasyLoading.show(status: 'Deleting');
      await _taskRepository.deleteTask(taskId);
      EasyLoading.showSuccess('User deleted successfully!');
      fetchData();
      Get.back();
    } catch (e) {
      EasyLoading.showError("An error occurred: ${e.toString()}");
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    super.onClose();
  }
}
