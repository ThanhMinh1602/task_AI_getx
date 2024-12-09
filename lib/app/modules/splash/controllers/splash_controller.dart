import 'package:get/get.dart';
import 'package:task/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.LOGIN);
    });
    super.onInit();
  }
}
