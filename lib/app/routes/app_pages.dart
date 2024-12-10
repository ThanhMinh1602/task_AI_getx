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
import 'package:task/app/modules/member/main/binding/member_main_binding.dart';
import 'package:task/app/modules/member/main/views/member_main_screen.dart';
import 'package:task/app/modules/member/profile/binding/member_profile_binding.dart';
import 'package:task/app/modules/member/profile/view/member_change_password_screen.dart';
import 'package:task/app/modules/member/profile/view/member_profile_screen.dart';
import 'package:task/app/modules/member/summary/binding/member_summary_binding.dart';
import 'package:task/app/modules/member/summary/view/member_sumary_task_detail_screen.dart';
import 'package:task/app/modules/member/task/binding/member_task_binding.dart';
import 'package:task/app/modules/member/task/views/member_task_screen.dart';
import 'package:task/app/modules/member/task_detail/binding/member_task_detail_binding.dart';
import 'package:task/app/modules/member/task_detail/views/member_task_detail_screen.dart';
import 'package:task/app/modules/splash/binding/splash_binding.dart';
import 'package:task/app/modules/splash/view/splash_screen.dart';
// Import other views as needed
import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.SPLASH;

  static final pages = [
    //admin
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
    //member
    GetPage(
      name: AppRoutes.MEMBER_MAIN,
      page: () => MemberMainScreen(),
      bindings: [
        MemberMainBinding(),
        MemberProfileBinding(),
        MemberTaskBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.MEMBER_TASK,
      page: () => MemberTaskScreen(),
      binding: MemberTaskBinding(),
    ),
    GetPage(
      name: AppRoutes.MEMBER_TASK_DETAIL,
      page: () => MemberTaskDetailScreen(),
      binding: MemberTaskDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.MEMBER_SUMMARY_TASK_DETAIL,
      page: () => MemberSumaryTaskDetailScreen(),
      binding: MemberSummaryBinding(),
    ),
    GetPage(
      name: AppRoutes.MEMBER_PROFILE,
      page: () => MemberProfileScreen(),
      binding: MemberProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.MEMBER_CHANGE_PASSWORD,
      page: () => MemberChangePasswordScreen(),
      binding: MemberProfileBinding(),
    ),
  ];
}
