// test/mocks.dart
import 'package:mockito/annotations.dart';
import 'package:task/app/data/repositories/auth_repository.dart';
import 'package:task/app/data/repositories/task_repository.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/remote/auth_service.dart';
import 'package:task/app/data/services/remote/gemini_service.dart';
import 'package:task/app/data/services/remote/task_service.dart';
import 'package:task/app/data/services/remote/user_service.dart';

@GenerateMocks([
  AuthService,
  TaskService,
  UserService,
  ITaskRepository,
  IAuthRepository,
  GeminiService,
  IUserRepository
])
void main() {}
