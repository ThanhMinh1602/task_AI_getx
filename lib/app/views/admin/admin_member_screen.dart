import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/controllers/user_controller.dart';
import 'package:task/app/views/admin/admin_member_detail_screen.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_floating_action_button.dart';
import 'package:task/core/widgets/custom_member_card.dart';
import 'package:task/core/widgets/custom_text_field.dart';

class AdminMemberScreen extends StatelessWidget {
  AdminMemberScreen({super.key});
  final UserController memberController = Get.find<UserController>();

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
          onRefresh: () async {
            memberController.refresh();
          },
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            children: [
              // CustomTextField(
              //   controller: memberController.searchController,
              //   hintText: 'Search...',
              //   suffixIcon: const Icon(Icons.search),
              // ),
              // const SizedBox(height: 24.0),
              Obx(
                () => ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: memberController.users.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                  itemBuilder: (context, index) {
                    final data = memberController.users[index];
                    return CustomMemberCard(
                      userModel: data,
                      onTap: () => Get.to(
                          AdminMemberDetailScreen(userModel: data),
                          transition: Transition.rightToLeft),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
