import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static CollectionReference get usersCollection =>
      _firestore.collection('users');

  static CollectionReference get tasksCollection =>
      _firestore.collection('tasks');

  static FirebaseAuth get firebaseAuth => _auth;
  static WriteBatch get batch => _firestore.batch();

  static Future<T> runTransaction<T>(
      Future<T> Function(Transaction transaction) updateFunction) {
    return _firestore.runTransaction(updateFunction);
  }
}
