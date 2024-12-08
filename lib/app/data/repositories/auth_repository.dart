import 'package:task/app/data/services/remote/auth_service.dart';
import 'package:task/core/enum/auth_status.dart';

abstract class IAuthRepository {
  Future<AuthStatus> login(String email, String password);
  Future<AuthStatus> changePassword(
      String userId, String oldPassword, String newPassword);
}

class AuthRepositoryImpl implements IAuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({required AuthService authService})
      : _authService = authService;

  @override
  Future<AuthStatus> login(String email, String password) async {
    return await _authService.login(email, password);
  }

  @override
  Future<AuthStatus> changePassword(
    String userId,
    String oldPassword,
    String newPassword,
  ) async {
    return await _authService.changePassword(
      userId,
      oldPassword,
      newPassword,
    );
  }
}
