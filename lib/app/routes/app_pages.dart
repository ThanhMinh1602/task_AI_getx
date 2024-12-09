import 'package:get/get.dart';
import 'package:task/app/modules/admin/main/binding/admin_main_binding.dart';
import 'package:task/app/modules/admin/main/views/admin_main_screen.dart';
import 'package:task/app/modules/admin/member/binding/admin_member_binding.dart';
import 'package:task/app/modules/admin/member_detail/binding/admin_member_detail_binding.dart';
import 'package:task/app/modules/admin/member_detail/views/admin_member_detail_screen.dart';
import 'package:task/app/modules/admin/summary/binding/admin_summary_binding.dart';
import 'package:task/app/modules/admin/summary/view/admin_sumary_task_detail_screen.dart';
import 'package:task/app/modules/admin/task/binding/admin_task_binding.dart';
import 'package:task/app/modules/admin/task_detail/binding/admin_task_detail_binding.dart';
import 'package:task/app/modules/admin/task_detail/views/admin_task_detail_screen.dart';
import 'package:task/app/modules/login/binding/login_binding.dart';
import 'package:task/app/modules/login/view/login_screen.dart';
import 'package:task/app/modules/splash/binding/splash_binding.dart';
import 'package:task/app/modules/splash/view/splash_screen.dart';
// Import other views as needed
import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.SPLASH;

  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.ADMIN_MAIN,
      page: () => AdminMainScreen(),
      bindings: [
        AdminMainBinding(),
        AdminTaskBinding(),
        AdminSummaryBinding(),
        AdminMemberDetailBinding(),
        AdminTaskDetailBinding(),
        AdminMemberBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.ADMIN_MEMBER_DETAIL,
      page: () => AdminMemberDetailScreen(),
      binding: AdminMemberDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.ADMIN_TASK_DETAIL,
      page: () => AdminTaskDetailScreen(),
      binding: AdminTaskDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.ADMIN_SUMMARY_TASK_DETAIL,
      page: () => AdminSumaryScreen(),
      binding: AdminSummaryBinding(),
    ),
  ];
}
