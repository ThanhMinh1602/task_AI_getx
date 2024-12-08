import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'base/base_model.dart';

class TaskModel extends BaseModel {
  final String title;
  final String description;
  final String dueDate;
  final String status;
  final String assignTo;

  TaskModel({
    String? id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    required this.assignTo,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) : super(
          id: id ?? const Uuid().v4(),
          createdAt: createdAt ?? BaseModel.getCurrentTimestamp(),
          updatedAt: updatedAt ?? BaseModel.getCurrentTimestamp(),
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'status': status,
      'assignTo': assignTo,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dueDate: json['dueDate'] ?? '',
      status: json['status'] ?? 'Open',
      assignTo: json['assignTo'] ?? '',
      createdAt: json['createdAt'] is Timestamp 
          ? json['createdAt'] 
          : BaseModel.getCurrentTimestamp(),
      updatedAt: json['updatedAt'] is Timestamp 
          ? json['updatedAt'] 
          : BaseModel.getCurrentTimestamp(),
    );
  }

  TaskModel copyWith({
    String? title,
    String? description,
    String? dueDate,
    String? status,
    String? assignTo,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      assignTo: assignTo ?? this.assignTo,
      createdAt: createdAt,
      updatedAt: BaseModel.getCurrentTimestamp(),
    );
  }
} 