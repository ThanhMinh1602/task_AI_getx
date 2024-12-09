import 'package:task/app/data/services/remote/base/base_service.dart';

import '../../models/user_model.dart';
import '../../providers/firebase_provider.dart';

class UserService extends BaseService<UserModel> {
  UserService() : super(FirebaseProvider.usersCollection);

  @override
  UserModel fromJson(Map<String, dynamic> json) => UserModel.fromJson(json);

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final querySnapshot =
          await collection.where('email', isEqualTo: email).limit(1).get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      return UserModel.fromJson(
          querySnapshot.docs.first.data() as Map<String, dynamic>);
    } catch (e) {
      print('Error in UserService.getUserByEmail: $e');
      return null;
    }
  }

  @override
  Future<UserModel?> create(UserModel userModel) async {
    try {
      final existingUser = await getUserByEmail(userModel.email!);
      if (existingUser != null) {
        print('User with this email already exists');
        return null;
      }

      return super.create(userModel);
    } catch (e) {
      print('Error in UserService.create: $e');
      return null;
    }
  }

  Future<void> deleteUserAndTasks(String userId) async {
    try {
      final batch = FirebaseProvider.batch;
      batch.delete(collection.doc(userId));

      final tasksSnapshot = await FirebaseProvider.tasksCollection
          .where('assignTo', isEqualTo: userId)
          .get();

      for (var doc in tasksSnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      print('Error in UserService.deleteUserAndTasks: $e');
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getAll() async {
    try {
      final querySnapshot = await collection
          .where('role', isEqualTo: 'member')
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error in UserService.getAll: $e');
      return [];
    }
  }
}
