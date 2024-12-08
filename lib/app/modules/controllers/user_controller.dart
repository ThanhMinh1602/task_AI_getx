import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/user_repository.dart';

class UserController extends GetxController {
  final IUserRepository _repository;

  // Form controllers
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  final users = <UserModel>[].obs;
  final currentUser = Rxn<UserModel>();
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  UserController({required IUserRepository repository})
      : _repository = repository;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      final result = await _repository.getAll();
      users.assignAll(result);
    } catch (e) {
      EasyLoading.showError('Failed to fetch users');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addUser() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      EasyLoading.show();

      final newUser = UserModel(
        name: nameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        password: passwordController.text,
      );

      final result = await _repository.create(newUser);
      if (result != null) {
        users.add(result);
        clearForm();
        Get.back();
        EasyLoading.showSuccess('User added successfully');
      } else {
        EasyLoading.showError('Failed to add user');
      }
    } catch (e) {
      EasyLoading.showError('Error adding user');
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
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
