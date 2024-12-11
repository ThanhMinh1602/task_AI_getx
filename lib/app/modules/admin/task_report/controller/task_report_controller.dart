import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/remote/gemini_service.dart';

enum GeminiType {
  report,
  chat,
}

class TaskReportController extends GetxController {
  final promptController = TextEditingController();
  final GeminiService _geminiService;
  final ITaskRepository _taskRepository;
  final IUserRepository _userRepository;
  var reportContent = ''.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    typeGemini.value = GeminiType.report;
  }

  TaskReportController(
      {required ITaskRepository taskRepository,
      required IUserRepository userRepository,
      required GeminiService geminiService})
      : _geminiService = geminiService,
        _taskRepository = taskRepository,
        _userRepository = userRepository;

  Rx<GeminiType> typeGemini = GeminiType.report.obs;
  void changeTypeGemini(GeminiType type) {
    typeGemini.value = type;
  }

  void generateGemini() {
    if (typeGemini.value == GeminiType.report) {
      generateGeminiReport();
    } else {
      generateGeminiChat();
    }
  }

  Future<void> generateGeminiReport() async {
    final prompt = promptController.text.trim();
    try {
      final tasks = await _taskRepository.getAll();

      final dataJson = tasks.map((task) => task.toJson()).join(',');
      print('dataJson: $dataJson');
      isLoading.value = true;
      reportContent.value =
          await _geminiService.generateContent('$prompt $dataJson');
      promptController.clear();
    } catch (e) {
      reportContent.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> generateGeminiChat() async {
    final prompt = promptController.text.trim();
    try {
      reportContent.value = await _geminiService.generateContent(prompt);
      promptController.clear();
    } catch (e) {
      reportContent.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
