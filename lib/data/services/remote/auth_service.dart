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
}
