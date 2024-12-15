import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import '../../mocks.mocks.dart';
// flutter test test/unit_test/repositories/user_repository_test.dart
void main() {
  late UserRepositoryImpl userRepository;
  late MockUserService mockUserService;

  setUp(() {
    mockUserService = MockUserService();
    userRepository = UserRepositoryImpl(userService: mockUserService);
  });

  group('UserRepository', () {
    test('create should return user when successful', () async {
      // Arrange
      final user = UserModel(
        name: 'Test User',
        email: 'test@test.com',
      );

      when(mockUserService.create(user)).thenAnswer((_) async => user);

      // Act
      final result = await userRepository.create(user);

      // Assert
      expect(result, user);
      verify(mockUserService.create(user)).called(1);

      // Thông báo test thành công
      print('Test "create should return user when successful" passed!');
    });

    test('getUserByEmail should return user when found', () async {
      // Arrange
      final email = 'test@test.com';
      final expectedUser = UserModel(
        id: '1',
        email: email,
      );

      when(mockUserService.getUserByEmail(email))
          .thenAnswer((_) async => expectedUser);

      // Act
      final result = await userRepository.getUserByEmail(email);

      // Assert
      expect(result, expectedUser);
      verify(mockUserService.getUserByEmail(email)).called(1);

      // Thông báo test thành công
      print('Test "getUserByEmail should return user when found" passed!');
    });

    test('deleteUserAndTasks should return true when successful', () async {
      // Arrange
      const userId = '1';
      when(mockUserService.deleteUserAndTasks(userId))
          .thenAnswer((_) async => true);

      // Act
      final result = await userRepository.deleteUserAndTasks(userId);

      // Assert
      expect(result, true);
      verify(mockUserService.deleteUserAndTasks(userId)).called(1);

      // Thông báo test thành công
      print(
          'Test "deleteUserAndTasks should return true when successful" passed!');
    });

    test('update should return updated user', () async {
      // Arrange
      final user = UserModel(
        id: '1',
        name: 'Updated Name',
        email: 'test@test.com',
      );

      when(mockUserService.update(user)).thenAnswer((_) async => user);

      // Act
      final result = await userRepository.update(user);

      // Assert
      expect(result, user);
      verify(mockUserService.update(user)).called(1);

      // Thông báo test thành công
      print('Test "update should return updated user" passed!');
    });

    test('getAll should return list of users', () async {
      // Arrange
      final users = [
        UserModel(id: '1', name: 'User 1'),
        UserModel(id: '2', name: 'User 2'),
      ];

      when(mockUserService.getAll()).thenAnswer((_) async => users);

      // Act
      final result = await userRepository.getAll();

      // Assert
      expect(result.length, 2);
      expect(result, users);
      verify(mockUserService.getAll()).called(1);

      // Thông báo test thành công
      print('Test "getAll should return list of users" passed!');
    });
  });
}
