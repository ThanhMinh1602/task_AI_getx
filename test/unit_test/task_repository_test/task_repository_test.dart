import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task/app/data/models/task_model.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/services/remote/task_service.dart';

import 'task_repository_test.mocks.dart';
// flutter test test/unit_test/task_repository_test/task_repository_test.dart
@GenerateMocks([TaskService])
void main() {
  late TaskRepositoryImpl taskRepository;
  late MockTaskService mockTaskService;

  setUp(() {
    mockTaskService = MockTaskService();
    taskRepository = TaskRepositoryImpl(taskService: mockTaskService);
  });

  group('TaskRepositoryImpl', () {
    final testTask = TaskModel(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        status: 'pending',
        assignTo: '123');
    final testTasks = [testTask];
    const testId = '1';
    const testUserId = '123';
    const testStatus = 'pending';

    group('create', () {
      test('should return TaskModel when creation is successful', () async {
        when(mockTaskService.create(testTask))
            .thenAnswer((_) async => testTask);
        final result = await taskRepository.create(testTask);
        expect(result, testTask);
        verify(mockTaskService.create(testTask)).called(1);
      });

      test('should return null when creation fails', () async {
        when(mockTaskService.create(testTask)).thenThrow(Exception());
        final result = await taskRepository.create(testTask);
        expect(result, null);
        verify(mockTaskService.create(testTask)).called(1);
      });
    });

    group('delete', () {
      test('should return true when deletion is successful', () async {
        when(mockTaskService.delete(testId))
            .thenAnswer((_) async => true); // void function
        final result = await taskRepository.delete(testId);
        expect(result, true);
        verify(mockTaskService.delete(testId)).called(1);
      });

      test('should return false when deletion fails', () async {
        when(mockTaskService.delete(testId)).thenThrow(Exception());
        final result = await taskRepository.delete(testId);
        expect(result, false);
        verify(mockTaskService.delete(testId)).called(1);
      });
    });

    group('getAll', () {
      test('should return a list of TaskModels', () async {
        when(mockTaskService.getAll()).thenAnswer((_) async => testTasks);
        final result = await taskRepository.getAll();
        expect(result, testTasks);
        verify(mockTaskService.getAll()).called(1);
      });

      test('should return an empty list on error', () async {
        when(mockTaskService.getAll()).thenThrow(Exception());
        final result = await taskRepository.getAll();
        expect(result, []);
        verify(mockTaskService.getAll()).called(1);
      });
    });

    group('getById', () {
      test('should return a TaskModel', () async {
        when(mockTaskService.getById(testId)).thenAnswer((_) async => testTask);
        final result = await taskRepository.getById(testId);
        expect(result, testTask);
        verify(mockTaskService.getById(testId)).called(1);
      });

      test('should return null on error', () async {
        when(mockTaskService.getById(testId)).thenThrow(Exception());
        final result = await taskRepository.getById(testId);
        expect(result, null);
        verify(mockTaskService.getById(testId)).called(1);
      });
    });

    group('update', () {
      test('should return updated TaskModel', () async {
        when(mockTaskService.update(testTask))
            .thenAnswer((_) async => testTask);
        final result = await taskRepository.update(testTask);
        expect(result, testTask);
        verify(mockTaskService.update(testTask)).called(1);
      });

      test('should return null on error', () async {
        when(mockTaskService.update(testTask)).thenThrow(Exception());
        final result = await taskRepository.update(testTask);
        expect(result, null);
        verify(mockTaskService.update(testTask)).called(1);
      });
    });

    group('getTasksByUser', () {
      test('should return a list of tasks by user', () async {
        when(mockTaskService.getTasksByUser(testUserId))
            .thenAnswer((_) async => testTasks);
        final result = await taskRepository.getTasksByUser(testUserId);
        expect(result, testTasks);
        verify(mockTaskService.getTasksByUser(testUserId)).called(1);
      });

      test('should return an empty list on error', () async {
        when(mockTaskService.getTasksByUser(testUserId)).thenThrow(Exception());
        final result = await taskRepository.getTasksByUser(testUserId);
        expect(result, []);
        verify(mockTaskService.getTasksByUser(testUserId)).called(1);
      });
    });

    group('getTasksByStatus', () {
      test('should return a list of tasks by status', () async {
        when(mockTaskService.getTasksByStatus(testStatus))
            .thenAnswer((_) async => testTasks);
        final result = await taskRepository.getTasksByStatus(testStatus);
        expect(result, testTasks);
        verify(mockTaskService.getTasksByStatus(testStatus)).called(1);
      });

      test('should return an empty list on error', () async {
        when(mockTaskService.getTasksByStatus(testStatus))
            .thenThrow(Exception());
        final result = await taskRepository.getTasksByStatus(testStatus);
        expect(result, []);
        verify(mockTaskService.getTasksByStatus(testStatus)).called(1);
      });
    });
  });
}
