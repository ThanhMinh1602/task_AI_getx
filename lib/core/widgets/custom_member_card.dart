import 'package:flutter/material.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/widgets/custom_card.dart';
import 'package:task/data/models/user_model.dart';
import 'package:task/gen/assets.gen.dart';

class CustomMemberCard extends StatelessWidget {
  const CustomMemberCard({super.key, required this.userModel, this.onTap});
  final UserModel userModel;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomCard(
          child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundColor: AppColor.kFFFFFF,
            backgroundImage: userModel.avatarUrl.isEmpty
                ? AssetImage(Assets.images.avatarNull.path)
                : NetworkImage(userModel.avatarUrl),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildMemberCardItem(
                  icon: Icons.person_outline_outlined, title: userModel.name),
              const SizedBox(height: 5.0),
              _buildMemberCardItem(
                  icon: Icons.email_outlined, title: userModel.email),
              const SizedBox(height: 5.0),
              _buildMemberCardItem(
                  icon: Icons.phone_android_outlined,
                  title: userModel.phoneNumber)
            ]),
          ),
        ],
      )),
    );
  }

  Widget _buildMemberCardItem({String? title, required IconData icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 16.0),
        Text(': $title', style: AppStyle.medium14),
      ],
    );
  }
}
