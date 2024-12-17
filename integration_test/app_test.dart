import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/services/local/shared_pref_service.dart';
import 'package:task/app/modules/admin/member_detail/controllers/admin_member_detail_controller.dart';
import 'package:task/app/modules/login/controllers/login_controller.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/app/routes/app_routes.dart';
import 'package:task/app/shared/binding/initial_binding.dart';
import 'package:task/firebase_options.dart';
import 'package:task/gen/assets.gen.dart';

import '../test/mocks.mocks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  late MockAdminMemberController mockAdminMemberController;
  late MockAdminMemberDetailController mockAdminMemberDetailController;
  late AdminMemberDetailController adminMemberDetailController;

  setUp(() {
    mockAdminMemberController = MockAdminMemberController();
    mockAdminMemberDetailController = MockAdminMemberDetailController();
    adminMemberDetailController = AdminMemberDetailController(
      userRepository: MockIUserRepository(),
    );
    Get.put(
        adminMemberDetailController); // Thêm dòng này nếu controller chưa được Put vào GetX
  });

  Widget createTestWidget() {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.ADMIN_MEMBER_DETAIL,
      getPages: AppPages.pages,
      builder: EasyLoading.init(),
    );
  }

  testWidgets('ADMIN MEMBER: CASE 1: CREATE MEMBER SUCCESS', (tester) async {
    await tester.pumpWidget(createTestWidget(),
        duration: const Duration(seconds: 3));
    await tester.pumpAndSettle();
    adminMemberDetailController.emailController.text = 'testuser1@gmail.com';
    adminMemberDetailController.nameController.text = 'testuser1';
    adminMemberDetailController.phoneController.text = '0987654321';
    adminMemberDetailController.passwordController.text = 'Password123';
    final emailField = find.byKey(const Key('memberEmailField'));
    final nameField = find.byKey(const Key('memberNameField'));
    final phoneField = find.byKey(const Key('memberPhoneField'));
    final passwordField = find.byKey(const Key('memberPasswordField'));
    final loginButton = find.byKey(const Key('createMemberButton'));

    expect(emailField, findsOne);
    expect(nameField, findsOne);
    expect(phoneField, findsOne);
    expect(passwordField, findsOne);
    expect(loginButton, findsOne);

    await tester.enterText(emailField, 'testuser1@gmail.com');
    await tester.enterText(nameField, 'testuser1');
    await tester.enterText(phoneField, '0987654321');
    await tester.enterText(passwordField, 'Password123');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();
    when(mockAdminMemberDetailController.createMember())
        .thenAnswer((_) async => true);
    // Ensure the success message is displayed
    expect(find.text('Member created successfully'), findsOne);
    print('CREATE MEMBER SUCCESS -> passed!');
  });
}
