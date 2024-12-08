import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firebase Timestamp

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String dueDate;
  final String status;
  final String assignTo;
  final Timestamp? createdAt; // Change to Timestamp
  final Timestamp? updatedAt; // Change to Timestamp

  TaskModel({
    String? id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    required this.assignTo,
    this.createdAt,
    this.updatedAt,
  }) : id = id ?? const Uuid().v4();

  // Convert TaskModel to Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'status': status,
      'assignTo': assignTo,
      'createdAt': createdAt ??
          FieldValue.serverTimestamp(), // Use server timestamp if null
      'updatedAt': updatedAt ??
          FieldValue.serverTimestamp(), // Use server timestamp if null
    };
  }

  // Convert Map to TaskModel
  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['dueDate'],
      status: map['status'],
      assignTo: map['assignTo'],
      createdAt: map['createdAt'] != null
          ? map['createdAt'] as Timestamp
          : null, // Parse Timestamp
      updatedAt: map['updatedAt'] != null
          ? map['updatedAt'] as Timestamp
          : null, // Parse Timestamp
    );
  }

  // Example fake tasks
  static List<TaskModel> fakeTasks = [
    TaskModel(
      title: 'Task #1',
      description: 'This is the first task description.',
      dueDate: '2024-12-08',
      status: 'Open',
      assignTo: '1',
      createdAt: Timestamp.now(), // Use current Timestamp
      updatedAt: Timestamp.now(),
    ),
    TaskModel(
      title: 'Task #2',
      description: 'This is the second task description.',
      dueDate: '2024-12-09',
      status: 'In Progress',
      assignTo: '1',
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    ),
    // Add more fake tasks if needed
  ];
}
