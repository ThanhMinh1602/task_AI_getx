import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/admin/main/controllers/admin_main_controller.dart';
import 'package:task/app/modules/admin/member/views/admin_member_screen.dart';
import 'package:task/app/modules/admin/task/views/admin_task_screen.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/widgets/custom_appbar.dart';

class AdminMainScreen extends StatelessWidget {
  AdminMainScreen({super.key});

  // Khởi tạo controller
  final adminMainController = Get.find<AdminMainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(isMain: true),
      body: Obx(() {
        return IndexedStack(
          index: adminMainController.currentIndex.value,
          children: [
            AdminTaskScreen(),
            const AdminMemberScreen(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: AppColor.kFFFFFF,
          currentIndex: adminMainController.currentIndex.value,
          onTap: (value) {
            adminMainController.changeTab(value);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Member'),
          ],
        );
      }),
    );
  }
}
