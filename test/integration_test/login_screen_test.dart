  import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_easyloading/flutter_easyloading.dart';
  import 'package:flutter_test/flutter_test.dart';
  import 'package:get/get.dart';
  import 'package:task/app/routes/app_pages.dart';
  import 'package:task/app/routes/app_routes.dart';
  import 'package:task/app/shared/binding/initial_binding.dart';
  import 'package:task/core/constants/test_key.dart';

  class LoginScreenTest {
    static Future<void> loginTest() async {
      // Chạy cả hai test: thành công và thất bại

      await _runLoginTest('ntminh1@gmail.com', 'Minh12345', false);
      await _runLoginTest('ntminh16201@gmail.com', 'Minh12345', true);
    }

    static Future<void> _runLoginTest(
        String email, String password, bool isSuccess) async {
      testWidgets('Login Screen Test ${isSuccess ? "success" : "failed"}',
          (tester) async {
        await tester.pumpWidget(
          GetMaterialApp(
            initialBinding: InitialBinding(),
            initialRoute: AppRoutes.SPLASH,
            getPages: AppPages.pages,
            builder: EasyLoading.init(),
          ),
          duration: const Duration(seconds: 3),
        );

        await tester.pumpAndSettle();

        final emailField = find.byKey(const Key(TestKey.emailField));
        final passwordField = find.byKey(const Key(TestKey.passwordField));
        final loginButton = find.byKey(const Key(TestKey.loginButton));

        expect(emailField, findsOneWidget);
        expect(passwordField, findsOneWidget);
        expect(loginButton, findsOneWidget);

        await tester.enterText(emailField, email);
        await tester.enterText(passwordField, password);
        await tester.tap(loginButton);

        // Đợi cây widget vẽ lại sau khi thực hiện đăng nhập
        await tester.pumpAndSettle();

        if (isSuccess) {
          // Kiểm tra sau khi đăng nhập thành công
          expect(Get.currentRoute, AppRoutes.ADMIN_MAIN);
        } else {
          // Kiểm tra sau khi đăng nhập thất bại
          expect(Get.currentRoute, AppRoutes.LOGIN);
          expect(find.text('Email or password is incorrect'), findsOneWidget);
        }
      });
    }
  }
