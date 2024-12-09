import 'package:flutter/material.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/extensions/build_context_extension.dart';
import 'package:task/core/utils/validator.dart';
import 'package:task/core/widgets/custom_appbar.dart';
import 'package:task/core/widgets/custom_background.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_card.dart';
import 'package:task/core/widgets/custom_dialog.dart';
import 'package:task/core/widgets/custom_text_field.dart';
import 'package:task/gen/assets.gen.dart';

class AdminMemberDetailScreen extends StatefulWidget {
  const AdminMemberDetailScreen({super.key, this.userModel});
  final UserModel? userModel;

  @override
  State<AdminMemberDetailScreen> createState() =>
      _AdminMemberDetailScreenState();
}

class _AdminMemberDetailScreenState extends State<AdminMemberDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unFocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppbar(title: widget.userModel?.name ?? 'Add new member'),
        body: CustomBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: CustomCard(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // _buildAvatar(),
                      _buildTextField('Name', _nameController,
                          validator: (value) =>
                              Validator.validateEmpty(value!)),
                      _buildTextField('Phone number', _phoneNumberController,
                          validator: (value) =>
                              Validator.validateEmpty(value!)),
                      _buildTextField('Email', _emailController,
                          validator: (value) =>
                              Validator.validateEmail(value!)),
                      _buildTextField('Password', _passwordController,
                          isPassword: true,
                          validator: (value) =>
                              Validator.validatePassword(value!)),
                      const SizedBox(height: 24),
                      if (widget.userModel != null)
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
                                            // userController
                                            //   .deleteUser(widget.userModel!.id);
                                          });
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: CustomButton(
                                  label: 'Update',
                                  onPressed: () {
                                    // userController
                                    //     .updateUser(widget.userModel!.id);
                                  }),
                            ),
                          ],
                        )
                      else
                        CustomButton(label: 'Add new member', onPressed: () {}),
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

  // Widget _buildAvatar() {
  //   return CircleAvatar(
  //     radius: 50.0,
  //     backgroundColor: AppColor.kFFFFFF,
  //     backgroundImage: widget.userModel?.avatarUrl.isEmpty ?? true
  //         ? AssetImage(Assets.images.avatarNull.path)
  //         : NetworkImage(widget.userModel!.avatarUrl) as ImageProvider,
  //   );
  // }
}
