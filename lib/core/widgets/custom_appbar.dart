import 'package:flutter/material.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/utils/string_format.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, this.isMain = false, this.title});
  final bool isMain;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return isMain
        ? Container(
            color: AppColor.kFFFFFF,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Good morning Andre!',
                          style: AppStyle.regular12),
                      Text(StringFormat.formatDate(DateTime.now()),
                          style: AppStyle.medium16)
                    ],
                  ),
                ),
                const Icon(Icons.notifications_sharp, color: AppColor.k0D101C)
              ],
            ),
          )
        : AppBar(
            backgroundColor: AppColor.kFFFFFF,
            title: Text(title ?? '--:--'),
          );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 58.0);
}
