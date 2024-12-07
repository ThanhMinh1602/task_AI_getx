// import 'package:flutter_test/flutter_test.dart';
// import 'package:task/app/models/user_model.dart';
// import 'package:task/app/services/remote/user_service.dart';
// import 'package:task/app/repositories/user_repository.dart';
// import 'package:integration_test/integration_test.dart';

// class MockUserService extends Mock implements UserService {}

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   group('UserRepositoryImp Tests', () {
//     late MockUserService mockUserService;
//     late IUserRepository userRepository;

//     setUp(() {
//       mockUserService = MockUserService();
//       userRepository = UserRepositoryImp(userService: mockUserService);
//     });

//     test('addUser should return a user when adding is successful', () async {
//       final user =
//           UserModel(id: '1', email: 'test@example.com', name: 'Test User');
//       when(mockUserService.addUser(user)).thenAnswer((_) async => user);

//       final result = await userRepository.addUser(user);

//       expect(result, isNotNull);
//       expect(result?.email, 'test@example.com');
//       verify(mockUserService.addUser(user)).called(1);
//     });

//     test('getAllUsers should return a list of users', () async {
//       final users = [
//         UserModel(id: '1', email: 'test1@example.com', name: 'Test User 1'),
//         UserModel(id: '2', email: 'test2@example.com', name: 'Test User 2'),
//       ];

//       when(mockUserService.getAllUsers()).thenAnswer((_) async => users);

//       final result = await userRepository.getAllUsers();

//       expect(result, isA<List<UserModel>>());
//       expect(result.length, 2);
//       expect(result[0].name, 'Test User 1');
//       verify(mockUserService.getAllUsers()).called(1);
//     });

//     test('getUserByEmail should return a user when found', () async {
//       final user =
//           UserModel(id: '1', email: 'test@example.com', name: 'Test User');

//       when(mockUserService.getUserByEmail('test@example.com'))
//           .thenAnswer((_) async => user);

//       final result = await userRepository.getUserByEmail('test@example.com');

//       expect(result, isNotNull);
//       expect(result?.email, 'test@example.com');
//       verify(mockUserService.getUserByEmail('test@example.com')).called(1);
//     });

//     test('updateUser should return updated user when successful', () async {
//       final user =
//           UserModel(id: '1', email: 'test@example.com', name: 'Updated User');
//       final updatedUser = user.copyWith(name: 'Updated User Name');

//       when(mockUserService.updateUser(user))
//           .thenAnswer((_) async => updatedUser);

//       final result = await userRepository.updateUser(user);

//       expect(result, isNotNull);
//       expect(result?.name, 'Updated User Name');
//       verify(mockUserService.updateUser(user)).called(1);
//     });

//     test('deleteUser should call delete service method', () async {
//       final userId = '1';

//       when(mockUserService.deleteUser(userId)).thenAnswer((_) async {});

//       await userRepository.deleteUser(userId);

//       verify(mockUserService.deleteUser(userId)).called(1);
//     });
//   });
// }
