import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/controllers/task_controller.dart';
import 'package:task/app/modules/views/member/member_task_detail_screen.dart';
import 'package:task/app/modules/views/member/sumary_task_detail_screen.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_task_card.dart';

class MemberTaskScreen extends StatelessWidget {
  MemberTaskScreen({super.key});

  final TaskController taskController = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            taskController.onInit();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Summary',
                      style: AppStyle.medium20,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 163.5 / 83,
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: taskController.statues.length,
                        itemBuilder: (context, index) {
                          // taskController.filterTasksByStatus(
                          //     taskController.statuses[index].label);
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => MemberSumaryTaskDetailScreen(
                                    status:
                                        taskController.statues[index].label),
                                transition: Transition.rightToLeft,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: AppColor.kFFFFFF,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.kDCE1EF),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(taskController.statues[index].label,
                                      style: AppStyle.regular14.copyWith(
                                          color: taskController
                                              .statues[index].color)),
                                  Obx(
                                    () => Text('Status',
                                        // taskController
                                        //     .getStatusCount(taskController
                                        //         .statues[index].label)
                                        //     .toString(),
                                        style: AppStyle.medium24),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('All task', style: AppStyle.medium20)),
              Expanded(
                child: Obx(
                  () => ListView.separated(
                    padding: const EdgeInsets.all(20.0),
                    itemCount: taskController.tasks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                    itemBuilder: (context, index) {
                      final data = taskController.tasks[index];
                      return CustomTaskCard(
                        onTap: () => Get.to(
                          MemberTaskDetailScreen(taskModel: data),
                          transition: Transition.rightToLeft,
                        ),
                        taskModel: data,
                        userName:
                            'taskController.getUserNameById(data.assignTo).toString()',
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
