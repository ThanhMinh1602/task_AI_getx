import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/app/models/user_model.dart';
import 'package:task/app/repositories/user_repository.dart';

class UserService implements IUserRepository {
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _tasksRef =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Future<UserModel?> addUser(UserModel user) async {
    try {
      final existingUser = await getUserByEmail(user.email);
      if (existingUser != null) {
        print("Email already exists!");
        return null;
      }

      await _usersRef.doc(user.id).set(user.toJson());
      print("User added successfully!");
      return user;
    } catch (e) {
      print("Failed to add user: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      final tasksSnapshot =
          await _tasksRef.where('assignTo', isEqualTo: userId).get();
      for (var task in tasksSnapshot.docs) {
        await _tasksRef.doc(task.id).delete();
        print("Task with ID ${task.id} deleted successfully!");
      }
      await _usersRef.doc(userId).delete();
      print("User deleted successfully!");
    } catch (e) {
      print("Failed to delete user and related tasks: ${e.toString()}");
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final querySnapshot = await _usersRef
          .where('role', isEqualTo: 'member')
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Failed to get users: ${e.toString()}");
      return [];
    }
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final querySnapshot =
          await _usersRef.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        return UserModel.fromJson(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print("Error checking email existence: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<UserModel?> updateUser(UserModel user) async {
    try {
      final docRef = _usersRef.doc(user.id);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        print("User not found for update.");
        return null;
      }

      await docRef.update(user.toJson());
      print("User updated successfully!");
      return UserModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print("Failed to update user: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    try {
      final querySnapshot = await _usersRef.doc(id).get();

      if (querySnapshot.exists) {
        final data = querySnapshot.data() as Map<String, dynamic>;
        return UserModel.fromJson(data);
      } else {
        print("No user found with ID: $id");
        return null;
      }
    } catch (e) {
      print("Error fetching user by ID: ${e.toString()}");
      return null;
    }
  }
}
