import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/controllers/auth_controller.dart';
import 'package:task/app/controllers/user_controller.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/utils/string_format.dart';
import 'package:task/core/widgets/custom_dialog.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({super.key, this.isMain = false, this.title});
  final bool isMain;
  final String? title;

  final AuthController authController = Get.find();
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    if (isMain) {
      return Container(
        color: AppColor.kFFFFFF,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: userController.getUserById(),
                    builder: (context, snapshot) => Text(
                        'Hello ${snapshot.data?.name}!',
                        style: AppStyle.regular12),
                  ),
                  Text(StringFormat.formatDate(DateTime.now()),
                      style: AppStyle.medium16)
                ],
              ),
            ),
            GestureDetector(
                onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                            title: 'Logout',
                            content: 'Bạn có chắc chắn mốn đăng xuất',
                            onConfirm: authController.logout);
                      },
                    ),
                child:
                    const Icon(Icons.login_outlined, color: AppColor.k0D101C)),
          ],
        ),
      );
    } else {
      return AppBar(
        backgroundColor: AppColor.kFFFFFF,
        title: Text(title ?? '--:--'),
      );
    }
  }

  @override
  Size get preferredSize => const Size(double.infinity, 58.0);
}
