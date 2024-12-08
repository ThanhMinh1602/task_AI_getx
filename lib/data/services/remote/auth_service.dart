import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/data/models/user_model.dart';
import 'package:task/data/repositories/auth_repository.dart';

class AuthService implements IauthRepository {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');
  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      QuerySnapshot querySnapshot = await _usersRef
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }
      final user = UserModel.fromJson(
          querySnapshot.docs.first.data() as Map<String, dynamic>);
      return user;
    } catch (e) {
      print("Error during login: $e");
      return null;
    }
  }

  @override
  Future<String> changePassword(
      String userId, String oldPassword, String newPassword) async {
    try {
      final userDoc = _usersRef.doc(userId);
      final snapshot = await userDoc.get();
      if (!snapshot.exists) {
        return 'User not found';
      }
      final user = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);

      if (user.password != oldPassword) {
        return 'Incorrect old password';
      }
      if (oldPassword == newPassword) {
        return 'New password must be different from the old password';
      }

      await userDoc.update({'password': newPassword});

      return 'Password changed successfully';
    } catch (e) {
      print('Error changing password: $e');
      return 'An unexpected error occurred';
    }
  }
}
