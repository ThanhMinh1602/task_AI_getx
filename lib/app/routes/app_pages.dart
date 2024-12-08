import 'package:get/get.dart';
import 'package:task/app/modules/bindings/auth_binding.dart';
import 'package:task/app/modules/bindings/task_binding.dart';
import 'package:task/app/modules/bindings/user_binding.dart';
import 'package:task/app/modules/views/admin/admin_main.dart';
import 'package:task/app/modules/views/login_screen.dart';
import 'package:task/app/modules/views/member/member_main.dart';
import 'package:task/app/modules/views/splash_screen.dart';
import 'package:task/app/routes/app_routes.dart';

// Import các module khác

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const SplashScreen(),
      bindings: [
        AuthBinding(),
        UserBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.ADMIN_HOME,
      page: () => const AdminMain(),
      bindings: [
        AuthBinding(),
        UserBinding(),
        TaskBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.MEMBER_HOME,
      page: () => const MemberMain(),
      bindings: [
        AuthBinding(),
        UserBinding(),
        TaskBinding(),
      ],
    ),
  ];
}
