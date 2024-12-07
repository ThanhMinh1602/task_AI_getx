import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/controllers/user_controller.dart';
import 'package:task/app/controllers/task_controller.dart';
import 'package:task/app/views/admin/admin_member_screen.dart';
import 'package:task/app/views/admin/admin_task_screen.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/widgets/custom_appbar.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  int currentIndex = 0;

  void _refreshData() {
    if (currentIndex == 0) {
      Get.find<TaskController>().onInit();
    } else if (currentIndex == 1) {
      Get.find<UserController>().onInit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(isMain: true),
      body: IndexedStack(
        index: currentIndex,
        children: [
          AdminTaskScreen(),
          AdminMemberScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.kFFFFFF,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
          _refreshData();
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Member')
        ],
      ),
    );
  }
}
