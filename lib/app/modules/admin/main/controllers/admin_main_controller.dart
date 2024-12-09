import 'package:get/get.dart';
import 'package:task/app/routes/app_routes.dart';

class AdminMainController extends GetxController {
  var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
    if (index == 0) {
      Get.toNamed(AppRoutes.ADMIN_TASK);
    } else if (index == 1) {
      Get.toNamed(AppRoutes.ADMIN_MEMBER);
    }
  }

  void logOut() {
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
