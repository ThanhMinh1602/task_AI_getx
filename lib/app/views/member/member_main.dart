import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/controllers/user_controller.dart';
import 'package:task/app/controllers/task_controller.dart';
import 'package:task/app/views/admin/admin_member_screen.dart';
import 'package:task/app/views/admin/admin_task_screen.dart';
import 'package:task/app/views/member/member_profile_screen.dart';
import 'package:task/app/views/member/member_task_screen.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/widgets/custom_appbar.dart';

class MemberMain extends StatefulWidget {
  const MemberMain({super.key});

  @override
  State<MemberMain> createState() => _MemberMainState();
}

class _MemberMainState extends State<MemberMain> {
  int currentIndex = 0;
  @override
  void initState() {
    Get.find<TaskController>().onInit();
    Get.find<UserController>().onInit();
    super.initState();
  }

  final currentRouter = Get.currentRoute;
  @override
  Widget build(BuildContext context) {
    print('currentRouter$currentRouter');
    return Scaffold(
      appBar: CustomAppbar(isMain: true),
      body: IndexedStack(
        index: currentIndex,
        children: [
          MemberTaskScreen(),
          MemberProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.kFFFFFF,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Member')
        ],
      ),
    );
  }
}
