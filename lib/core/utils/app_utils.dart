import 'package:flutter/material.dart';

class AppUtils {
  static Color getStatusColors(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.blue;
      case 'in progress':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
