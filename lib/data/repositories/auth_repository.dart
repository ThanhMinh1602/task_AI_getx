import 'package:task/data/models/user_model.dart';
import 'package:task/data/services/remote/auth_service.dart';

abstract class IauthRepository {
  Future<UserModel?> login(String email, String password);
}

class AuthRepositoryImp implements IauthRepository {
  final AuthService _authService;

  AuthRepositoryImp({required AuthService authService})
      : _authService = authService;
  @override
  Future<UserModel?> login(String email, String password) async {
    return await _authService.login(email, password);
  }
}
