import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/controllers/task_controller.dart';
import 'package:task/app/views/admin/admin_task_detail_screen.dart';
import 'package:task/app/views/member/member_task_detail_screen.dart';
import 'package:task/core/widgets/custom_appbar.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_task_card.dart';

class MemberSumaryTaskDetailScreen extends StatefulWidget {
  const MemberSumaryTaskDetailScreen({super.key, required this.status});
  final String status;

  @override
  State<MemberSumaryTaskDetailScreen> createState() =>
      _MemberSumaryTaskDetailScreenState();
}

class _MemberSumaryTaskDetailScreenState
    extends State<MemberSumaryTaskDetailScreen> {
  final TaskController taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
    taskController.filterTasksByStatus(widget.status);
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
              onTap: () => Get.to(MemberTaskDetailScreen(taskModel: data),
                  transition: Transition.rightToLeft),
              taskModel: data,
              userName:
                  taskController.getUserNameById(data.assignTo).toString(),
            );
          },
        );
      })),
    );
  }
}
