import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/controllers/user_controller.dart';
import 'package:task/data/models/user_model.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/extensions/build_context_extension.dart';
import 'package:task/core/utils/validator.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_card.dart';
import 'package:task/core/widgets/custom_text_field.dart';
import 'package:task/gen/assets.gen.dart';

class MemberProfileScreen extends StatefulWidget {
  const MemberProfileScreen({super.key, this.userModel});
  final UserModel? userModel;

  @override
  State<MemberProfileScreen> createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends State<MemberProfileScreen> {
  final UserController memberController = Get.find<UserController>();

  @override
  void initState() {
    memberController.initializeMember(widget.userModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unFocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: CustomBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: CustomCard(
                child: Form(
                  key: memberController.globalKey,
                  child: Column(
                    children: [
                      _buildAvatar(),
                      _buildTextField('Name', memberController.nameController,
                          validator: (value) =>
                              Validator.validateEmpty(value!)),
                      _buildTextField('Phone number',
                          memberController.phoneNumberController,
                          validator: (value) =>
                              Validator.validateEmpty(value!)),
                      _buildTextField('Email', memberController.emailController,
                          validator: (value) =>
                              Validator.validateEmail(value!)),
                      _buildTextField(
                          'Password', memberController.passwordController,
                          isPassword: true,
                          validator: (value) =>
                              Validator.validatePassword(value!)),
                      const SizedBox(height: 24),
                      CustomButton(
                          label: 'Update',
                          onPressed: () {
                            memberController.update();
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false, String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyle.medium14),
        const SizedBox(height: 10),
        CustomTextField(
          controller: controller,
          isPassword: isPassword,
          validator: validator,
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 50.0,
      backgroundColor: AppColor.kFFFFFF,
      backgroundImage: widget.userModel?.avatarUrl.isEmpty ?? true
          ? AssetImage(Assets.images.avatarNull.path)
          : NetworkImage(widget.userModel!.avatarUrl) as ImageProvider,
    );
  }
}
