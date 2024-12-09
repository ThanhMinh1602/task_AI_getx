import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task/app/data/repositories/auth_repository.dart';
import 'package:task/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final IAuthRepository _authRepository;

  LoginController({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text;
      EasyLoading.show(status: 'Logging in...');
      try {
        final result = await _authRepository.login(email, password);
        if (result != null) {
          switch (result.role) {
            case 'admin':
              Get.offAllNamed(AppRoutes.ADMIN_MAIN);
              break;
            case 'member':
              // Get.offAllNamed(AppRoutes.USER_MAIN);
              break;
            default:
              EasyLoading.showError('Unknown role');
          }
        } else {
          EasyLoading.showError('Invalid email or password');
        }
      } catch (e) {
        EasyLoading.showError('An error occurred: $e');
      } finally {
        EasyLoading.dismiss();
      }
    }
  }

  // Dọn dẹp TextEditingController khi không dùng nữa
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
