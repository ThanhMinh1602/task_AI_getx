import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/app/data/providers/firebase_provider.dart';
import 'package:task/core/enum/auth_status.dart';

class AuthService {
  final CollectionReference _usersRef = FirebaseProvider.usersCollection;

  Future<AuthStatus> login(String email, String password) async {
    try {
      final querySnapshot = await _usersRef
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();
      if (querySnapshot.docs.isEmpty) {
        return AuthStatus.failure;
      }
      return AuthStatus.success;
    } catch (e) {
      print('Error in AuthService.login: $e');
      return AuthStatus.error;
    }
  }

  Future<AuthStatus> changePassword(
    String userId,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final userDoc = await _usersRef.doc(userId).get();

      if (!userDoc.exists) {
        return AuthStatus.userNotFound;
      }

      final userData = userDoc.data() as Map<String, dynamic>;
      if (userData['password'] != oldPassword) {
        return AuthStatus.incorrectPassword;
      }

      if (oldPassword == newPassword) {
        return AuthStatus.samePassword;
      }

      await _usersRef.doc(userId).update({'password': newPassword});
      return AuthStatus.passwordChanged;
    } catch (e) {
      print('Error in AuthService.changePassword: $e');
      return AuthStatus.error;
    }
  }
}
