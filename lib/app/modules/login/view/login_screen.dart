import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/login/controllers/login_controller.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/test_key.dart';
import 'package:task/core/utils/validator.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_logo.dart';
import 'package:task/core/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.kFFFFFF,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Form(
              key: loginController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (Get.arguments != null)
                    Hero(tag: Get.arguments, child: const CustomLogo(width: 50))
                  else
                    const CustomLogo(width: 50),
                  const SizedBox(height: 70),
                  _buildTextField(
                    key: const Key(TestKey.emailField),
                    controller: loginController.emailController,
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    key: const Key(TestKey.passwordField),
                    controller: loginController.passwordController,
                    hintText: 'Password',
                    isPassword: true,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  const SizedBox(height: 70),
                  CustomButton(
                    key: const Key(TestKey.loginButton),
                    label: 'Login',
                    onPressed: loginController.login,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      required Widget prefixIcon,
      Key? key,
      bool isPassword = false}) {
    return CustomTextField(
      key: key,
      controller: controller,
      hintText: hintText,
      prefixIcon: prefixIcon,
      isPassword: isPassword,
      validator: (p0) => Validator.validateEmpty(p0!),
    );
  }
}
