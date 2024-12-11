import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/data/models/mesage_model.dart';
import 'package:task/app/data/models/task_model.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/remote/gemini_service.dart';

enum GeminiType { report, chat }

class TaskReportController extends GetxController {
  final promptController = TextEditingController();
  final GeminiService _geminiService;
  final ITaskRepository _taskRepository;
  final IUserRepository _userRepository;
  var reportContent = ''.obs;
  var isLoading = false.obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;

  String conversationContext = '';

  TaskReportController({
    required ITaskRepository taskRepository,
    required IUserRepository userRepository,
    required GeminiService geminiService,
  })  : _geminiService = geminiService,
        _taskRepository = taskRepository,
        _userRepository = userRepository;

  Rx<GeminiType> typeGemini = GeminiType.report.obs;

  void changeTypeGemini(GeminiType type) {
    typeGemini.value = type;
  }

  void sendMessage() {
    final prompt = promptController.text.trim();
    if (prompt.isEmpty) return;
    conversationContext += "\nUser: $prompt";
    messages.add(MessageModel(content: prompt, isSentByUser: true));
    messages.add(MessageModel(content: 'Đang trả lời...', isSentByUser: false));
    promptController.clear();

    if (typeGemini.value == GeminiType.report) {
      generateGeminiReport(conversationContext);
    } else {
      generateGeminiChat(conversationContext);
    }
  }

  Future<void> generateGeminiReport(String context) async {
    try {
      isLoading.value = true;
      final tasks = await _taskRepository.getAll();
      final dataJson = tasks.map((task) => task.toJson()).join(',');
      final report = await _geminiService.generateContent('$context $dataJson');
      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: report, isSentByUser: false));

      conversationContext += "\nGemini: $report";
    } catch (e) {
      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: 'Error: $e', isSentByUser: false));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> generateGeminiChat(String context) async {
    try {
      isLoading.value = true;
      final response = await _geminiService.generateContent(context);

      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: response, isSentByUser: false));
      conversationContext += "\nGemini: $response";
    } catch (e) {
      messages.removeWhere((msg) => msg.content == 'Đang trả lời...');
      messages.add(MessageModel(content: 'Error: $e', isSentByUser: false));
    } finally {
      isLoading.value = false;
    }
  }

// Future<void> getUserWithTasks(String userId) async {
//   try {
//     // Truy vấn thông tin User
//     final userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

//     if (userSnapshot.exists) {
//       // Lấy thông tin người dùng
//       UserModel user = UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);

//       // Truy vấn tất cả các task có assignTo là userId
//       final taskSnapshot = await FirebaseFirestore.instance
//           .collection('tasks')
//           .where('assignTo', isEqualTo: userId)
//           .get();

//       // Lấy danh sách các task của người dùng
//       List<TaskModel> tasks = taskSnapshot.docs.map((doc) => TaskModel.fromJson(doc.data())).toList();

//       // Cập nhật thông tin của user với danh sách tasks
//       user = UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);

//       // Thực hiện xử lý với dữ liệu user và task
//       print('User: ${user.name}');
//       print('Tasks:');
//       for (var task in user.tasks) {
//         print('- ${task.title}');
//       }
//     } else {
//       print('User not found');
//     }
//   } catch (e) {
//     print('Error fetching user and tasks: $e');
//   }
// }
}
