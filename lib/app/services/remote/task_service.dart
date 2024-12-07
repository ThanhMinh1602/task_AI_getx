import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/app/models/task_model.dart';
import 'package:task/app/repositories/task_repository.dart';

class TaskService implements ITaskRepository {
  final CollectionReference _tasksRef =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Future<TaskModel?> addTask(TaskModel task) async {
    try {
      final querySnapshot =
          await _tasksRef.where('title', isEqualTo: task.title).get();
      if (querySnapshot.docs.isNotEmpty) {
        print("Công việc với tên này đã tồn tại!");
        return null;
      }
      await _tasksRef.doc(task.id).set(task.toJson());
      print("Công việc đã được tạo thành công!");
      final docSnapshot = await _tasksRef.doc(task.id).get();
      if (docSnapshot.exists) {
        return TaskModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      } else {
        print("Không tìm thấy công việc sau khi tạo.");
        return null;
      }
    } catch (e) {
      print("Tạo công việc thất bại: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final QuerySnapshot querySnapshot =
          await _tasksRef.orderBy('createdAt', descending: true).get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return TaskModel.fromJson(data);
      }).toList();
    } catch (e) {
      print("Lấy danh sách công việc thất bại: ${e.toString()}");
      return [];
    }
  }

  @override
  Future<List<TaskModel>> getAllTasksByUser(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await _tasksRef
          .where('assignTo', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return TaskModel.fromJson(data);
      }).toList();
    } catch (e) {
      print("Lấy công việc của người dùng thất bại: ${e.toString()}");
      return [];
    }
  }

  @override
  Future<TaskModel?> getTaskById(String taskId) async {
    try {
      final doc = await _tasksRef.doc(taskId).get();
      if (doc.exists) {
        return TaskModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      print("Không tìm thấy công việc!");
      return null;
    } catch (e) {
      print("Lấy công việc thất bại: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<List<TaskModel>> getAssignedTo(String assignedTo) async {
    try {
      final QuerySnapshot querySnapshot =
          await _tasksRef.where('assignedTo', isEqualTo: assignedTo).get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return TaskModel.fromJson(data);
      }).toList();
    } catch (e) {
      print(
          "Lấy công việc cho người dùng $assignedTo thất bại: ${e.toString()}");
      return [];
    }
  }

  @override
  Future<TaskModel?> updateTask(TaskModel task) async {
    try {
      final docRef = _tasksRef.doc(task.id);
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        print("Không tìm thấy công việc để cập nhật.");
        return null;
      }
      await docRef.update(task.toJson());
      print("Cập nhật công việc thành công!");
      final updatedDocSnapshot = await docRef.get();
      return TaskModel.fromJson(
          updatedDocSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print("Cập nhật công việc thất bại: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksRef.doc(taskId).delete();
      print("Xóa công việc thành công!");
    } catch (e) {
      print("Xóa công việc thất bại: ${e.toString()}");
    }
  }
}
