import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/data/models/task_model.dart';
import 'package:task/app/modules/admin/task/controllers/admin_task_controller.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/utils/app_utils.dart';
import 'package:task/core/widgets/custom_card.dart';
import 'package:task/core/widgets/custom_status_box.dart';

class CustomTaskCard extends StatelessWidget {
  CustomTaskCard({super.key, required this.taskModel, this.onTap});
  final TaskModel taskModel;
  final void Function()? onTap;
  final AdminTaskController taskController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print('taskModel ${taskModel.assignTo}');
      return GestureDetector(
        onTap: onTap,
        child: CustomCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(taskModel.title ?? '--:--', style: AppStyle.medium16),
              const SizedBox(height: 5.0),
              Text(
                taskModel.description ?? '--:--',
                style: AppStyle.regular12,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIconText(
                            icon: Icons.calendar_month_outlined,
                            title: taskModel.dueDate ?? '--:--'),
                        const SizedBox(height: 5.0),
                        if (taskModel.assignTo != null)
                          _buildIconText(
                              icon: Icons.person_outline_outlined,
                              title: taskController
                                  .getNameMemberByTask(taskModel.assignTo!))
                      ],
                    ),
                  ),
                  CustomStatusBox(
                    status: taskModel.status ?? '--:--',
                    color:
                        AppUtils.getStatusColors(taskModel.status ?? '--:--'),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _buildIconText({required String title, required IconData icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 12.0),
        const SizedBox(width: 5.0),
        Text(title, style: AppStyle.regular10),
      ],
    );
  }
}
