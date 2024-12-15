// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:task/app/routes/app_pages.dart';
// import 'package:task/app/routes/app_routes.dart';
// import 'package:task/core/constants/test_key.dart';
// import 'package:task/firebase_options.dart';

// import 'package:task/main.dart';

// void main() async {
//   testWidgets('Login test', (WidgetTester tester) async {
//     // Run the app
//     await tester.pumpWidget(
//         GetMaterialApp(
//           initialRoute: AppRoutes.LOGIN,
//           getPages: AppPages.pages,
//           debugShowCheckedModeBanner: false,
//           title: 'Task Manager',
//         ),
//         duration: const Duration(seconds: 3));
//     await tester.pumpAndSettle(); // Wait for all animations to settle

//     // Find textFields
//     final Finder emailText = find.byKey(const Key(TestKey.emailField));
//     final Finder passwordText = find.byKey(const Key(TestKey.passwordField));

//     // Ensure there is a login and password field on the initial page
//     expect(emailText, findsOneWidget);
//     expect(passwordText, findsOneWidget);

//     // Enter text
//     await tester.enterText(emailText, 'ntminh16201@gmail.com');
//     await tester.enterText(passwordText, 'Minh12345');
//     await tester.pumpAndSettle();
//     await tester.pump(const Duration(seconds: 2));

//     // Tap btn
//     final Finder loginBtn = find.byKey(const Key(TestKey.loginButton));
//     await tester.tap(loginBtn, warnIfMissed: true);
//     await tester.pumpAndSettle();
//     await tester.pump(const Duration(seconds: 2));

//     // Expect all anims have finished
//     expect(Get.currentRoute, AppRoutes.ADMIN_MAIN);

//     // Wait a bit more...
//     await tester.pump(const Duration(seconds: 2));
//   });
// }
