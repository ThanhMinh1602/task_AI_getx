import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/remote/user_service.dart';

import 'user_repository_test.mocks.dart';

// flutter test test/unit_test/user_repository_test/user_repository_test.dart
@GenerateMocks([UserService])
void main() {
  late UserRepositoryImpl userRepository;
  late MockUserService mockUserService;

  setUp(() {
    mockUserService = MockUserService();
    userRepository = UserRepositoryImpl(userService: mockUserService);
  });

  group('UserRepositoryImpl', () {
    final testUser =
        UserModel(id: '1', email: 'test@example.com', name: 'Test User');
    final testUsers = [testUser];
    const testId = '1';
    const testEmail = 'test@example.com';

    group('create', () {
      test('should return UserModel when creation is successful', () async {
        when(mockUserService.create(any)).thenAnswer((_) async => testUser);
        final result = await userRepository.create(testUser);
        expect(result, testUser);
        verify(mockUserService.create(testUser)).called(1);
      });

      test('should return null when creation fails', () async {
        when(mockUserService.create(any)).thenThrow(Exception());
        final result = await userRepository.create(testUser);
        expect(result, null);
        verify(mockUserService.create(testUser)).called(1);
      });
    });

    group('delete', () {
      test('should return true when deletion is successful', () async {
        when(mockUserService.delete(testId)).thenAnswer((_) async => true);
        final result = await userRepository.delete(testId);
        expect(result, true);
        verify(mockUserService.delete(testId)).called(1);
      });

      test('should return false when deletion fails', () async {
        when(mockUserService.delete(testId)).thenThrow(Exception());
        final result = await userRepository.delete(testId);
        expect(result, false);
        verify(mockUserService.delete(testId)).called(1);
      });
    });

    group('getAll', () {
      test('should return a list of UserModels', () async {
        when(mockUserService.getAll()).thenAnswer((_) async => testUsers);
        final result = await userRepository.getAll();
        expect(result, testUsers);
        verify(mockUserService.getAll()).called(1);
      });

      test('should return an empty list on error', () async {
        when(mockUserService.getAll()).thenThrow(Exception());
        final result = await userRepository.getAll();
        expect(result, []);
        verify(mockUserService.getAll()).called(1);
      });
    });

    group('getById', () {
      test('should return a UserModel', () async {
        when(mockUserService.getById(testId)).thenAnswer((_) async => testUser);
        final result = await userRepository.getById(testId);
        expect(result, testUser);
        verify(mockUserService.getById(testId)).called(1);
      });

      test('should return null on error', () async {
        when(mockUserService.getById(testId)).thenThrow(Exception());
        final result = await userRepository.getById(testId);
        expect(result, null);
        verify(mockUserService.getById(testId)).called(1);
      });
    });

    group('update', () {
      test('should return updated UserModel', () async {
        when(mockUserService.update(any)).thenAnswer((_) async => testUser);
        final result = await userRepository.update(testUser);
        expect(result, testUser);
        verify(mockUserService.update(testUser)).called(1);
      });

      test('should return null on error', () async {
        when(mockUserService.update(any)).thenThrow(Exception());
        final result = await userRepository.update(testUser);
        expect(result, null);
        verify(mockUserService.update(testUser)).called(1);
      });
    });

    group('getUserByEmail', () {
      test('should return a UserModel by email', () async {
        when(mockUserService.getUserByEmail(testEmail))
            .thenAnswer((_) async => testUser);
        final result = await userRepository.getUserByEmail(testEmail);
        expect(result, testUser);
        verify(mockUserService.getUserByEmail(testEmail)).called(1);
      });

      test('should return null on error', () async {
        when(mockUserService.getUserByEmail(testEmail)).thenThrow(Exception());
        final result = await userRepository.getUserByEmail(testEmail);
        expect(result, null);
        verify(mockUserService.getUserByEmail(testEmail)).called(1);
      });
    });

    group('deleteUserAndTasks', () {
      test('should return true when deletion is successful', () async {
        when(mockUserService.deleteUserAndTasks(testId))
            .thenAnswer((_) async => {});
        final result = await userRepository.deleteUserAndTasks(testId);
        expect(result, true);
        verify(mockUserService.deleteUserAndTasks(testId)).called(1);
      });

      test('should return false when deletion fails', () async {
        when(mockUserService.deleteUserAndTasks(testId)).thenThrow(Exception());
        final result = await userRepository.deleteUserAndTasks(testId);
        expect(result, false);
        verify(mockUserService.deleteUserAndTasks(testId)).called(1);
      });
    });
  });
}
