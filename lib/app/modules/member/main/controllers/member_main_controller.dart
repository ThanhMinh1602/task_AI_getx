import 'package:get/get.dart';
import 'package:task/app/data/services/local/shared_pref_service.dart';
import 'package:task/app/routes/app_routes.dart';

class MemberMainController extends GetxController {
  var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
    if (index == 0) {
      Get.toNamed(AppRoutes.ADMIN_TASK);
    } else if (index == 1) {
      Get.toNamed(AppRoutes.ADMIN_MEMBER);
    }
  }

  void logOut() async {
    await SharedPrefService.clearAll();
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
