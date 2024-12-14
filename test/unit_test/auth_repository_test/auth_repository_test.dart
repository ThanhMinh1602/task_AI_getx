import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/auth_repository.dart';
import 'package:task/app/data/services/remote/auth_service.dart';

import 'auth_repository_test.mocks.dart';
// flutter test test/unit_test/auth_repository_test/auth_repository_test.dart
@GenerateMocks([AuthService])
void main() {
  late AuthRepositoryImpl authRepository;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    authRepository = AuthRepositoryImpl(authService: mockAuthService);
  });

  group('AuthRepository', () {
    group('login', () {
      test('should return UserModel when login is successful', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';
        final expectedUser =
            UserModel(id: '1', email: email, name: 'Test User');
        when(mockAuthService.login(email, password))
            .thenAnswer((_) async => expectedUser);

        // Act
        final result = await authRepository.login(email, password);

        // Assert
        expect(result, expectedUser);
        verify(mockAuthService.login(email, password)).called(1);
      });

      test('should return null when login fails', () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'wrong_password';
        when(mockAuthService.login(email, password))
            .thenAnswer((_) async => null);

        // Act
        final result = await authRepository.login(email, password);

        // Assert
        expect(result, null);
        verify(mockAuthService.login(email, password)).called(1);
      });

      test('should throw an exception when the service throws an exception',
          () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';
        when(mockAuthService.login(email, password))
            .thenThrow(Exception('Network error'));

        // Act & Assert
        expect(() => authRepository.login(email, password),
            throwsA(isA<Exception>()));
        verify(mockAuthService.login(email, password)).called(1);
      });
    });

    group('changePassword', () {
      test('should return success message when password change is successful',
          () async {
        // Arrange
        const userId = '1';
        const oldPassword = 'oldPassword';
        const newPassword = 'newPassword';
        const expectedMessage = 'Password changed successfully';
        when(mockAuthService.changePassword(userId, oldPassword, newPassword))
            .thenAnswer((_) async => expectedMessage);

        // Act
        final result = await authRepository.changePassword(
          userId,
          oldPassword,
          newPassword,
        );

        // Assert
        expect(result, expectedMessage);
        verify(mockAuthService.changePassword(userId, oldPassword, newPassword))
            .called(1);
      });

      test('should throw an exception when the service throws an exception',
          () async {
        // Arrange
        const userId = '1';
        const oldPassword = 'oldPassword';
        const newPassword = 'newPassword';
        when(mockAuthService.changePassword(userId, oldPassword, newPassword))
            .thenThrow(Exception('Invalid old password'));

        // Act & Assert
        expect(
            () => authRepository.changePassword(
                  userId,
                  oldPassword,
                  newPassword,
                ),
            throwsA(isA<Exception>()));
        verify(mockAuthService.changePassword(userId, oldPassword, newPassword))
            .called(1);
      });
    });
  });
}
