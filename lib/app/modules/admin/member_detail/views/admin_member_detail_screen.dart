import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/admin/member_detail/controllers/admin_member_detail_controller.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/constants/test_key.dart';
import 'package:task/core/extensions/build_context_extension.dart';
import 'package:task/core/utils/validator.dart';
import 'package:task/core/widgets/custom_appbar.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_card.dart';
import 'package:task/core/widgets/custom_dialog.dart';
import 'package:task/core/widgets/custom_text_field.dart';

class AdminMemberDetailScreen extends StatelessWidget {
  AdminMemberDetailScreen({super.key});
  final controller = Get.find<AdminMemberDetailController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unFocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            title: controller.userModel.value.name ?? 'Add new member',
          ),
        ),
        body: CustomBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: CustomCard(
                child: Obx(
                  () => Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                            key: const Key(TestKey.memberNameField),
                            'Name',
                            controller.nameController,
                            validator: (value) =>
                                Validator.validateEmpty(value!)),
                        _buildTextField(
                            key: const Key(TestKey.memberPhoneField),
                            'Phone number',
                            controller.phoneController,
                            validator: (value) =>
                                Validator.validateEmpty(value!)),
                        _buildTextField(
                            key: const Key(TestKey.memberEmailField),
                            'Email',
                            controller.emailController,
                            validator: (value) =>
                                Validator.validateEmail(value!)),
                        _buildTextField(
                            key: const Key(TestKey.memberPasswordField),
                            'Password',
                            controller.passwordController,
                            isPassword: true,
                            validator: (value) =>
                                Validator.validatePassword(value!)),
                        const SizedBox(height: 24),
                        if (!controller.isNewMember.value)
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  label: 'Delete',
                                  backgroundColor: Colors.red,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      useRootNavigator: true,
                                      builder: (context) {
                                        return CustomDialog(
                                            title: 'Delete',
                                            content:
                                                'Are you sure you want to delete?',
                                            onConfirm: () {
                                              controller.deleteMember(controller
                                                  .userModel.value.id);
                                            });
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: CustomButton(
                                    key: const Key('updateButton'),
                                    label: 'Update',
                                    onPressed: () {
                                      controller.updateMember();
                                    }),
                              ),
                            ],
                          )
                        else
                          CustomButton(
                              key: const Key(TestKey.createMemberButton),
                              label: 'Add new member',
                              onPressed: () => controller.createMember()),
                      ],
                    ),
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
      {bool isPassword = false,
      String? Function(String?)? validator,
      required Key key}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyle.medium14),
        const SizedBox(height: 10),
        CustomTextField(
          key: key,
          controller: controller,
          isPassword: isPassword,
          validator: validator,
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
