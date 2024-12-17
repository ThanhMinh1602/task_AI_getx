// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:mockito/mockito.dart';
// import 'package:task/app/data/models/user_model.dart';
// import 'package:task/app/data/services/local/shared_pref_service.dart';
// import 'package:task/app/modules/login/controllers/login_controller.dart';
// import 'package:task/app/routes/app_pages.dart';
// import 'package:task/app/routes/app_routes.dart';
// import 'package:task/app/shared/binding/initial_binding.dart';
// import 'package:task/firebase_options.dart';

// import '../test/mocks.mocks.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   late MockAdminMemberDetailController mockAdminMemberDetailController;
//   late MockAdminMainController mockAdminMainController;
//   setUp(() {
//     mockAdminMemberDetailController = MockAdminMemberDetailController();
//     mockAdminMainController = MockAdminMainController();
//   });
//   test('test', () {
//     mockAdminMemberDetailController.
//   });
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/modules/login/controllers/login_controller.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/app/routes/app_routes.dart';
import 'package:task/app/shared/binding/initial_binding.dart';
import 'package:task/firebase_options.dart';

import '../test/mocks.mocks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  late MockLoginController mockLoginController;
  late LoginController loginController;

  setUp(() {
    mockLoginController = MockLoginController();
    loginController = LoginController(authRepository: MockIAuthRepository());
  });

  Widget createTestWidget() {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.LOGIN,
      getPages: AppPages.pages,
      builder: EasyLoading.init(),
    );
  }

  testWidgets('CASE 1:ADMIN LOGIN SUCCESS', (tester) async {
    // Arrange: Mock dữ liệu
    const email = 'ntminh16201@gmail.com';
    const password = 'Minh12345';

    // Mock AuthRepository trả về UserModel
    loginController.emailController.text = email;
    loginController.passwordController.text = password;

    // Giả lập login thành công (trả về một Future thành công)
    when(mockLoginController.login()).thenAnswer(
        (_) async => UserModel(id: '1', email: email, role: 'admin'));

    await tester.pumpWidget(createTestWidget(),
        duration: const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Tìm các widget
    final emailField = find.byKey(const Key('emailField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.byKey(const Key('loginButton'));

    // Assert: Các widget tồn tại
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);

    // Nhập dữ liệu
    await tester.enterText(emailField, email);
    await tester.enterText(passwordField, password);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Kiểm tra chuyển hướng
    expect(Get.currentRoute, AppRoutes.ADMIN_MAIN);
    print('Admin login success test -> passed!');
  });

  testWidgets('CASE 2:ADMIN LOGIN FAILED', (tester) async {
    const email = 'ntminh16201@gmail.com';
    const password = 'Password123';

    loginController.emailController.text = email;
    loginController.passwordController.text = password;

    // Giả lập API trả về thất bại (trả về một Future thất bại)
    when(mockLoginController.login())
        .thenAnswer((_) async => throw Exception('Invalid credentials'));

    // Run the app
    await tester.pumpWidget(createTestWidget(),
        duration: const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Find necessary widgets
    final emailField = find.byKey(const Key('emailField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.byKey(const Key('loginButton'));

    // Assert widget existence
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);

    // Enter data and tap login button
    await tester.enterText(emailField, email);
    await tester.enterText(passwordField, password);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Check for error message and ensure the route is still LOGIN
    expect(Get.currentRoute, AppRoutes.LOGIN);
    expect(find.text('Email or password is incorrect'), findsOneWidget);
    print('Admin login failed test -> passed!');
  });
}
