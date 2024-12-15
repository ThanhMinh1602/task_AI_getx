import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task/app/data/models/task_model.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import '../../mocks.mocks.dart';
// flutter test test/unit_test/repositories/task_repository_test.dart
void main() {
  late TaskRepositoryImpl taskRepository;
  late MockTaskService mockTaskService;

  setUp(() {
    mockTaskService = MockTaskService();
    taskRepository = TaskRepositoryImpl(taskService: mockTaskService);
  });

  group('TaskRepository', () {
    test('create should return task when successful', () async {
      // Arrange
      final task = TaskModel(
        title: 'Test Task',
        description: 'Test Description',
      );

      when(mockTaskService.create(task)).thenAnswer((_) async => task);

      // Act
      final result = await taskRepository.create(task);

      // Assert
      expect(result, task);
      verify(mockTaskService.create(task)).called(1);

      // Thông báo test thành công
      print('Test "create should return task when successful" passed!');
    });

    test('getTasksByUser should return list of tasks', () async {
      // Arrange
      final userId = '1';
      final tasks = [
        TaskModel(id: '1', title: 'Task 1', assignTo: userId),
        TaskModel(id: '2', title: 'Task 2', assignTo: userId),
      ];

      when(mockTaskService.getTasksByUser(userId))
          .thenAnswer((_) async => tasks);

      // Act
      final result = await taskRepository.getTasksByUser(userId);

      // Assert
      expect(result.length, 2);
      expect(result, tasks);
      verify(mockTaskService.getTasksByUser(userId)).called(1);

      // Thông báo test thành công
      print('Test "getTasksByUser should return list of tasks" passed!');
    });

    test('getTasksByStatus should return filtered tasks', () async {
      // Arrange
      const status = 'In Progress';
      final tasks = [
        TaskModel(id: '1', title: 'Task 1', status: status),
        TaskModel(id: '2', title: 'Task 2', status: status),
      ];

      when(mockTaskService.getTasksByStatus(status))
          .thenAnswer((_) async => tasks);

      // Act
      final result = await taskRepository.getTasksByStatus(status);

      // Assert
      expect(result.length, 2);
      expect(result.every((task) => task.status == status), true);
      verify(mockTaskService.getTasksByStatus(status)).called(1);

      // Thông báo test thành công
      print('Test "getTasksByStatus should return filtered tasks" passed!');
    });

    test('delete should return true when successful', () async {
      // Arrange
      const taskId = '1';
      when(mockTaskService.delete(taskId)).thenAnswer((_) async => true);

      // Act
      final result = await taskRepository.delete(taskId);

      // Assert
      expect(result, true);
      verify(mockTaskService.delete(taskId)).called(1);

      // Thông báo test thành công
      print('Test "delete should return true when successful" passed!');
    });
  });
}
