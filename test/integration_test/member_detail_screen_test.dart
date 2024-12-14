import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/app/data/repositories/user_repository.dart';
import 'package:task/app/data/services/remote/user_service.dart';
import 'package:task/app/modules/admin/member/controllers/admin_member_controller.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/app/routes/app_routes.dart';
import 'package:task/app/shared/binding/initial_binding.dart';
import 'package:task/core/constants/test_key.dart';
import 'package:task/core/utils/app_utils.dart';

class MemberDetailScreenTest {
  static Future<void> addTask() async {
    // Chạy cả hai test: tạo thành công và thất bại khi thêm thành viên
    await _runMemberDetailTest(
      name: 'test${AppUtils.generateRandomString(10)}',
      email: 'test${AppUtils.generateRandomString(10)}@test.com',
      phone: '1234567890',
      password: 'Password123',
      isSuccess: true,
    );

    await _runMemberDetailTest(
      name: 'test${AppUtils.generateRandomString(10)}',
      email: 'johndoe@example.com', // Email đã tồn tại
      phone: '1234567890',
      password: 'Password123',
      isSuccess: false,
    );
  }

  static Future<void> _runMemberDetailTest({
    required String name,
    required String email,
    required String phone,
    required String password,
    required bool isSuccess,
  }) async {
    testWidgets('Member Detail Screen Test ${isSuccess ? "success" : "failed"}',
        (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialBinding: InitialBinding(),
          initialRoute: AppRoutes.ADMIN_MEMBER_DETAIL,
          getPages: AppPages.pages,
          builder: EasyLoading.init(),
        ),
        duration: const Duration(seconds: 3),
      );

      await tester.pumpAndSettle();

      final nameField = find.byKey(const Key(TestKey.memberNameField));
      final emailField = find.byKey(const Key(TestKey.memberEmailField));
      final phoneField = find.byKey(const Key(TestKey.memberPhoneField));
      final passwordField = find.byKey(const Key(TestKey.memberPasswordField));
      final createMemberButton =
          find.byKey(const Key(TestKey.createMemberButton));

      expect(nameField, findsOneWidget);
      expect(emailField, findsOneWidget);
      expect(phoneField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(createMemberButton, findsOneWidget);

      await tester.enterText(nameField, name);
      await tester.enterText(emailField, email);
      await tester.enterText(phoneField, phone);
      await tester.enterText(passwordField, password);
      await tester.tap(createMemberButton);

      await tester.pumpAndSettle();

      if (isSuccess) {
        // Kiểm tra sau khi thêm thành viên thành công
        expect(find.text('Member created successfully'), findsOneWidget);
      } else {
        // Kiểm tra sau khi thêm thành viên thất bại
        expect(find.text('Email already exists'), findsOneWidget);
      }
    });
  }

  static Future<void> updateMember() async {
    // Mở ứng dụng và chờ cho tới khi widget được vẽ ra
    group('AdminMemberDetail Integration Test', () {
      testWidgets('Update Member UI Test', (tester) async {
        // Dữ liệu mẫu cho bài kiểm tra
        final user = UserModel(
          id: '324049f5-e576-43ff-a92d-1110e4a8449c',
          name: 'Thanh Bình',
          email: 'thanhbinh@example.com',
          phoneNumber: '0987654321',
          password: 'OldPassword123',
        );

        // Cài đặt ứng dụng với GetMaterialApp
        await tester.pumpWidget(
          GetMaterialApp(
            initialRoute: AppRoutes.ADMIN_MEMBER_DETAIL,
            getPages: AppPages.pages,
            builder: EasyLoading.init(),
            initialBinding: InitialBinding(),
          ),
        );

        // Truyền dữ liệu mẫu vào Get.arguments
        Get.toNamed(AppRoutes.ADMIN_MEMBER_DETAIL, arguments: user);
        await tester.pumpAndSettle();
        print('user?.name ${Get.arguments}');

        // Kiểm tra giá trị ban đầu của các trường
        expect(find.text('Thanh Bình'), findsOneWidget);
        expect(find.text('thanhbinh@example.com'), findsOneWidget);
        expect(find.text('0987654321'), findsOneWidget);

        // Cập nhật giá trị trong các trường
        await tester.enterText(
            find.byKey(const Key('memberNameField')), 'Nguyễn Văn A');
        await tester.enterText(find.byKey(const Key('memberEmailField')),
            'nguyenvana@example.com');
        await tester.enterText(
            find.byKey(const Key('memberPhoneField')), '0123456789');
        await tester.enterText(
            find.byKey(const Key('memberPasswordField')), 'NewPassword123');

        // Nhấn nút cập nhật
        await tester.tap(find.byKey(const Key('updateMemberButton')));
        await tester.pumpAndSettle();

        // Kiểm tra thông báo hiển thị
        expect(find.text('Member updated successfully'), findsOneWidget);
      });
    });
  }
}

// Mock Repository cho kiểm thử
class MockUserRepository implements IUserRepository {
  @override
  Future<UserModel?> create(UserModel user) async {
    return Future.value(user); // Giả lập thành công
  }

  @override
  Future<bool> deleteUserAndTasks(String id) async {
    return Future.value(true); // Giả lập thành công
  }

  @override
  Future<UserModel?> getById(String id) async {
    return Future.value(UserModel(
      id: id,
      name: 'Mock User',
      email: 'mock@example.com',
      phoneNumber: '123456789',
    ));
  }

  @override
  Future<UserModel?> update(UserModel user) async {
    return Future.value(user); // Giả lập thành công
  }

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> getUserByEmail(String email) {
    // TODO: implement getUserByEmail
    throw UnimplementedError();
  }
}
