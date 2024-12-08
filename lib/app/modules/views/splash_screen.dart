import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/widgets/custom_logo.dart';
import 'package:task/app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.LOGIN);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLogo(),
            SizedBox(height: 20),
            Text(
              'Task Manager',
              style: TextStyle(
                fontSize: 24,
                color: AppColor.k613BE7,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
