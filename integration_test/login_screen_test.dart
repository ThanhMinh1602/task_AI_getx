import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:get/get.dart';
import 'package:task/app/routes/app_routes.dart';
import 'package:task/main.dart'; // Đảm bảo rằng đây là đường dẫn chính xác

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login Test', (tester) async {
    // Mở ứng dụng
    await tester.pumpWidget(const MyApp());

    // Tìm các widget cần thiết
    final emailField = find.byKey(const Key('emailField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.byKey(const Key('loginButton'));

    // Kiểm tra xem các widget có hiện ra không
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);

    // Nhập thông tin đăng nhập
    await tester.enterText(
        emailField, 'ntminh16201@gmail.com'); // dùng tài khoản admin
    await tester.enterText(passwordField, 'Minh12345');

    // Nhấn nút đăng nhập
    await tester.tap(loginButton);
    await tester
        .pumpAndSettle(); // Đợi cho các animation và quá trình bất đồng bộ hoàn tất

    // Kiểm tra kết quả
    // Kiểm tra xem có điều hướng đến màn hình đúng không
    expect(
        Get.currentRoute,
        AppRoutes
            .MEMBER_MAIN); // Giả sử sau khi đăng nhập thành công, sẽ có chữ "Welcome"
  });
}
