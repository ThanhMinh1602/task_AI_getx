import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/controllers/task_controller.dart';
import 'package:task/app/modules/views/admin/admin_task_detail_screen.dart';
import 'package:task/core/widgets/custom_appbar.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_task_card.dart';

class AdminSumaryTaskDetailScreen extends StatefulWidget {
  const AdminSumaryTaskDetailScreen({super.key, required this.status});
  final String status;

  @override
  State<AdminSumaryTaskDetailScreen> createState() =>
      _AdminSumaryTaskDetailScreenState();
}

class _AdminSumaryTaskDetailScreenState
    extends State<AdminSumaryTaskDetailScreen> {
  final TaskController taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: widget.status),
      body: CustomBackground(child: Obx(() {
        return ListView.separated(
          padding: const EdgeInsets.all(20.0),
          itemCount: taskController.filteredTasks.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10.0),
          itemBuilder: (context, index) {
            final data = taskController.filteredTasks[index];
            return CustomTaskCard(
              onTap: () => Get.to(AdminTaskDetailScreen(taskModel: data),
                  transition: Transition.rightToLeft),
              taskModel: data,
              userName:
                  'taskController.getUserNameById(data.assignTo).toString()',
            );
          },
        );
      })),
    );
  }
}
