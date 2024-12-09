import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/modules/admin/task/controllers/admin_task_controller.dart';

class AdminMemberDetailController extends GetxController {
  final IUserRepository _userRepository;
  AdminMemberDetailController({required IUserRepository userRepository})
      : _userRepository = userRepository;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final userModel = UserModel().obs;

  final isNewMember = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();

    if (Get.arguments != null) {
      userModel.value = Get.arguments;
      nameController.text = userModel.value.name ?? '';
      emailController.text = userModel.value.email ?? '';
      phoneController.text = userModel.value.phoneNumber ?? '';
      passwordController.text = userModel.value.password ?? '';
    } else {
      isNewMember.value = true;
    }
  }

  Future<void> createMember() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Creating member...');
      final user = UserModel(
        name: nameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        password: passwordController.text,
      );
      final result = await _userRepository.create(user);
      if (result != null) {
        EasyLoading.showSuccess('Member created successfully');
        Get.back(result: true);
      } else {
        EasyLoading.showError('Email already exists');
      }
    }
  }

  Future<void> updateMember() async {
    final updateUser = userModel.value.copyWith(
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
      password: passwordController.text,
    );
    EasyLoading.show(status: 'Updating member...');
    final result = await _userRepository.update(updateUser);
    if (result != null) {
      EasyLoading.showSuccess('Member updated successfully');
      Get.back(result: true);
    } else {
      EasyLoading.showError('Email not found');
    }
  }

  Future<void> deleteMember(String id) async {
    EasyLoading.show(status: 'Deleting member...');
    final result = await _userRepository.deleteUserAndTasks(id);
    if (result) {
      EasyLoading.showSuccess('Member deleted successfully');
      Get.find<AdminTaskController>().onInit();
      Get.back(result: true);
    } else {
      EasyLoading.showError('Failed to delete member');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
