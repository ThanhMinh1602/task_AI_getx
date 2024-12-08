import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Thêm thư viện Firestore

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String avatarUrl;
  final String? password;
  final Timestamp createdAt; // Thay đổi thành Timestamp
  final Timestamp updatedAt; // Thay đổi thành Timestamp
  final String role;

  UserModel({
    String? id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.password,
    this.avatarUrl = '',
    this.role = 'member',
    Timestamp? createdAt,
    Timestamp? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? Timestamp.fromDate(DateTime.now()),
        updatedAt = updatedAt ?? Timestamp.fromDate(DateTime.now());

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'password': password,
      'role': role,
      'createdAt': createdAt, // Sử dụng Timestamp
      'updatedAt': updatedAt, // Sử dụng Timestamp
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      avatarUrl: map['avatarUrl'] ?? '',
      password: map['password'],
      role: map['role'] ?? 'member',
      createdAt: map['createdAt'] is Timestamp
          ? map['createdAt']
          : Timestamp.fromDate(DateTime.now()),
      updatedAt: map['updatedAt'] is Timestamp
          ? map['updatedAt']
          : Timestamp.fromDate(DateTime.now()),
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
    String? password,
    String? role,
    Timestamp? updatedAt,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      password: password ?? this.password,
      role: role ?? this.role,
      createdAt: createdAt,
      updatedAt:
          updatedAt ?? Timestamp.fromDate(DateTime.now()), 
    );
  }
}

List<UserModel> fakeUsers = [
  UserModel(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    phoneNumber: '1234567890',
    avatarUrl:
        'https://cdn.pixabay.com/photo/2024/03/03/20/44/cat-8611246_1280.jpg',
    password: 'password123',
  ),
  UserModel(
    id: '2',
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    phoneNumber: '0987654321',
    avatarUrl: 'https://example.com/avatar2.jpg',
    password: 'password456',
  ),
  UserModel(
    id: '3',
    name: 'Bob Johnson',
    email: 'bob.johnson@example.com',
    phoneNumber: '1122334455',
    avatarUrl: 'https://example.com/avatar3.jpg',
    password: 'password789',
  ),
  UserModel(
    id: '4',
    name: 'Alice Williams',
    email: 'alice.williams@example.com',
    phoneNumber: '6677889900',
    avatarUrl: 'https://example.com/avatar4.jpg',
    password: 'password101',
  ),
];
