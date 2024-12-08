import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/auth_repository.dart';
import 'package:task/app/data/services/local/shared_pref_service.dart';
import 'package:task/core/enum/auth_status.dart';
import '../../routes/app_routes.dart';

class AuthController extends GetxController {
  final IAuthRepository _repository;

  // Form controllers
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  // Observable variables
  final isLoggedIn = false.obs;
  final currentRole = ''.obs;

  AuthController({required IAuthRepository repository})
      : _repository = repository;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    try {
      final role = await SharedPrefService.getRole();
      if (role != null) {
        currentRole.value = role;
        isLoggedIn.value = true;
        _navigateBasedOnRole(role);
      } else {
        Get.offAllNamed(AppRoutes.LOGIN);
      }
    } catch (e) {
      EasyLoading.showError('Error checking auth status');
    } finally {}
  }

  Future<void> login(String email, String password) async {
    try {
      EasyLoading.show();
      final result = await _repository.login(
        emailController.text,
        passwordController.text,
      );
      switch (result) {
        case AuthStatus.success:
          break;

        case AuthStatus.failure:
          EasyLoading.showError('Invalid credentials');
          break;

        case AuthStatus.error:
          EasyLoading.showError('Login failed: An error occurred');
          break;
        default:
          EasyLoading.showError('Unknown error');
      }
    } catch (e) {
      EasyLoading.showError('Login failed: ${e.toString()}');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void _navigateBasedOnRole(String role) {
    switch (role) {
      case 'admin':
        Get.offAllNamed(AppRoutes.ADMIN_HOME);
        break;
      case 'member':
        Get.offAllNamed(AppRoutes.MEMBER_HOME);
        break;
      default:
        Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  Future<void> logout() async {
    try {
      EasyLoading.show();

      await SharedPrefService.clearAll();
      isLoggedIn.value = false;
      currentRole.value = '';

      Get.offAllNamed(AppRoutes.LOGIN);
      EasyLoading.showSuccess('Logged out successfully');
    } catch (e) {
      EasyLoading.showError('Logout failed: ${e.toString()}');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    oldPasswordController.clear();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    oldPasswordController.dispose();
    super.onClose();
  }
}
