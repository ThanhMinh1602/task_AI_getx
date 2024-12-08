import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task/data/repositories/auth_repository.dart';
import 'package:task/data/services/local/shared_pref_service.dart';
import 'package:task/app/views/admin/admin_main.dart';
import 'package:task/app/views/login_screen.dart';
import 'package:task/app/views/member/member_main.dart';

class AuthController extends GetxController {
  final IauthRepository _repository;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AuthController({
    required AuthRepositoryImp repository
  }) : _repository = repository;

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      final result = await _repository.login(email, password);
      if (result != null) {
        await SharedPrefService.saveRole(result.role);
        await SharedPrefService.saveUserId(result.id);
        switch (result.role) {
          case 'member':
            EasyLoading.showSuccess('Logged');
            Get.offAll(const MemberMain(), transition: Transition.rightToLeft);
            break;
          case 'admin':
            EasyLoading.showSuccess('Logged');
            Get.offAll(const AdminMain(), transition: Transition.rightToLeft);
            break;
          default:
            EasyLoading.showError('Error');
            break;
        }
      } else {
        EasyLoading.showError('Emailll or password invalid');
      }
    }
  }

  void logout() async {
    await SharedPrefService.clear();
    Get.offAll(LoginScreen(), transition: Transition.leftToRight);
  }

  void checkToken() async {
    final role = await SharedPrefService.getRole();
    switch (role) {
      case 'member':
        Get.offAll(const MemberMain(), transition: Transition.rightToLeft);
        break;
      case 'admin':
        Get.offAll(const AdminMain(), transition: Transition.rightToLeft);
        break;
      default:
        Get.offAll(LoginScreen(), transition: Transition.rightToLeft);
        break;
    }
  }
}
