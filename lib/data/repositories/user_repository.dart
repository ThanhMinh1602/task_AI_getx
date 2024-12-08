import 'package:task/data/models/user_model.dart';
import 'package:task/data/services/remote/user_service.dart';

abstract class IUserRepository {
  Future<UserModel?> addUser(UserModel user);
  Future<void> deleteUser(String userId);
  Future<List<UserModel>> getAllUsers();
  Future<UserModel?> getUserByEmail(String email);
  Future<UserModel?> getUserById(String id);
  Future<UserModel?> updateUser(UserModel user);
}

class UserRepositoryImp implements IUserRepository {
  final UserService userService;

  UserRepositoryImp({required this.userService});

  @override
  Future<UserModel?> addUser(UserModel user) {
    return userService.addUser(user);
  }

  @override
  Future<void> deleteUser(String userId) {
    return userService.deleteUser(userId);
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    return await userService.getAllUsers();
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    return await userService.getUserByEmail(email);
  }

  @override
  Future<UserModel?> updateUser(UserModel user) async {
    return await userService.updateUser(user);
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    return await userService.getUserById(id);
  }
}
