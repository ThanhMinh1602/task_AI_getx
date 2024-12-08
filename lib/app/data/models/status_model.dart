import 'package:flutter/material.dart';

class StatusModel {
  final String label;
  final Color color;

  const StatusModel({
    required this.label,
    required this.color,
  });

  static const List<StatusModel> statuses = [
    StatusModel(
      label: 'Open',
      color: Colors.blue,
    ),
    StatusModel(
      label: 'In Progress',
      color: Colors.orange,
    ),
    StatusModel(
      label: 'Completed',
      color: Colors.green,
    ),
    StatusModel(
      label: 'Overdue',
      color: Colors.red,
    ),
  ];

  static Color getColorByStatus(String status) {
    return statuses
        .firstWhere(
          (s) => s.label == status,
          orElse: () => statuses.first,
        )
        .color;
  }
} 