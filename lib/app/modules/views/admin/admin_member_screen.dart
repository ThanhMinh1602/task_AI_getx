import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/controllers/user_controller.dart';
import 'package:task/app/modules/views/admin/admin_member_detail_screen.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_floating_action_button.dart';
import 'package:task/core/widgets/custom_member_card.dart';

class AdminMemberScreen extends StatelessWidget {
  AdminMemberScreen({super.key});
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        icon: Icons.person_add_outlined,
        onPressed: () => Get.to(const AdminMemberDetailScreen(),
            transition: Transition.rightToLeft),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: CustomBackground(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: Obx(
            () => ListView.separated(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              itemCount: userController.users.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10.0),
              itemBuilder: (context, index) {
                final data = userController.users[index];
                return CustomMemberCard(
                  userModel: data,
                  onTap: () => Get.to(AdminMemberDetailScreen(userModel: data),
                      transition: Transition.rightToLeft),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
