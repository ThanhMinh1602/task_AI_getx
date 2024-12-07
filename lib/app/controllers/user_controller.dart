import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task/app/models/user_model.dart';
import 'package:task/app/repositories/user_repository.dart'; // Import IUserRepository

class UserController extends GetxController {
  // TextEditingControllers
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final IUserRepository _userRepository;

  RxList<UserModel> users = <UserModel>[].obs;
  UserController({required IUserRepository userRepository})
      : _userRepository = userRepository;

  @override
  void onInit() {
    super.onInit();
    getAllUser();
  }

  @override
  void refresh() {
    getAllUser();
    super.refresh();
  }

  void getAllUser() async {
    try {
      List<UserModel> fetchedUsers = await _userRepository.getAllUsers();
      users.assignAll(fetchedUsers);
    } catch (e) {
      print("Failed to get users: ${e.toString()}");
    }
  }

  void initializeMember(UserModel? userModel) {
    if (userModel == null) {
      resetMemberFields();
    } else {
      nameController.text = userModel.name;
      emailController.text = userModel.email;
      phoneNumberController.text = userModel.phoneNumber;
    }
  }

  void resetMemberFields() {
    nameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    passwordController.clear();
  }

  void addUser() async {
    if (globalKey.currentState?.validate() ?? false) {
      EasyLoading.show(status: 'Adding user...');
      UserModel user = UserModel(
        name: nameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text,
      );
      UserModel? addedUser = await _userRepository.addUser(user);
      if (addedUser != null) {
        EasyLoading.showSuccess('Success!');
        refresh();
        Get.back();
      } else {
        EasyLoading.showError("Email already exists!");
      }
    }
  }

  void updateUser(String uid) async {
    if (globalKey.currentState?.validate() ?? false) {
      EasyLoading.show(status: 'Updating user...');
      UserModel user = UserModel(
        id: uid,
        name: nameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text,
      );
      try {
        UserModel? updatedUser = await _userRepository.updateUser(user);
        if (updatedUser != null) {
          EasyLoading.showSuccess('User updated successfully!');
          refresh();
          Get.back();
        } else {
          EasyLoading.showError("Failed to update user!");
        }
      } catch (e) {
        EasyLoading.showError("An error occurred: ${e.toString()}");
      }
    }
  }

  void deleteUser(String userId) async {
    try {
      EasyLoading.show(status: 'Deleting');
      await _userRepository.deleteUser(userId);
      EasyLoading.showSuccess('User deleted successfully!');
      Get.back();
      refresh();
    } catch (e) {
      EasyLoading.showError("An error occurred: ${e.toString()}");
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
