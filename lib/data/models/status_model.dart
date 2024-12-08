import 'package:flutter/material.dart';

class StatusModel {
  final String label;
  final Color color;

  StatusModel({required this.label, required this.color});
  static List<StatusModel> status = [
    StatusModel(label: 'Open', color: Colors.blue),
    StatusModel(label: 'In Progress', color: Colors.orange),
    StatusModel(label: 'Completed', color: Colors.green),
    StatusModel(label: 'Overdue', color: Colors.red),
  ];
}
