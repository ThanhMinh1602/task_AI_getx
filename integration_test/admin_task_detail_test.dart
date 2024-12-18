import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/app/routes/app_routes.dart';
import 'package:task/app/shared/binding/initial_binding.dart';
import 'package:task/core/utils/app_utils.dart';
import 'package:task/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  group('Admin Task Detail', () {
    testWidgets('CASE 1: Add Task success', (tester) async {
      print("Test Case 1 started");
      await tester.pumpWidget(
          GetMaterialApp(
            initialBinding: InitialBinding(),
            initialRoute: AppRoutes.ADMIN_TASK_DETAIL,
            getPages: AppPages.pages,
            builder: EasyLoading.init(),
          ),
          duration: const Duration(seconds: 5));

      await tester.pumpAndSettle();

      final taskNameField = find.byKey(const Key('taskNameField'));
      final taskDescriptionField =
          find.byKey(const Key('taskDescriptionField'));
      final taskAssigneeField = find.byKey(const Key('taskAssigneeField'));
      final taskStatusField = find.byKey(const Key('taskStatusField'));
      final deadlineField = find.byKey(const Key('deadlineField'));
      final createTaskButton = find.byKey(const Key('createTaskButton'));

      expect(taskNameField, findsOneWidget);
      expect(taskDescriptionField, findsOneWidget);
      expect(taskAssigneeField, findsOneWidget);
      expect(taskStatusField, findsOneWidget);
      expect(deadlineField, findsOneWidget);
      expect(createTaskButton, findsOneWidget);

      await tester.enterText(
          taskNameField, 'Test Task Name${AppUtils.generateRandomString(10)}');
      await tester.enterText(taskDescriptionField, 'Test Task Description');

      await tester.tap(taskAssigneeField);
      await tester.pumpAndSettle();
      final assigneeOption = find.text('Minh').last;
      await tester.tap(assigneeOption);
      await tester.pumpAndSettle();

      await tester.tap(taskStatusField);
      await tester.pumpAndSettle();
      final statusOption = find.text('In Progress').last;
      await tester.tap(statusOption);
      await tester.pumpAndSettle();

      await tester.tap(deadlineField);
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.tap(createTaskButton);
      await tester.pumpAndSettle();

      expect(find.text('Created'), findsOneWidget);
      print("Test Case 1 finished");
    });

    testWidgets('CASE 2: Add Task failed', (tester) async {
      print("Test Case 2 started");
      await tester.pumpWidget(
          GetMaterialApp(
            initialBinding: InitialBinding(),
            initialRoute: AppRoutes.ADMIN_TASK_DETAIL,
            getPages: AppPages.pages,
            builder: EasyLoading.init(),
          ),
          duration: const Duration(seconds: 5));

      await tester.pumpAndSettle();

      final taskNameField = find.byKey(const Key('taskNameField'));
      final taskDescriptionField =
          find.byKey(const Key('taskDescriptionField'));
      final taskAssigneeField = find.byKey(const Key('taskAssigneeField'));
      final taskStatusField = find.byKey(const Key('taskStatusField'));
      final deadlineField = find.byKey(const Key('deadlineField'));
      final createTaskButton = find.byKey(const Key('createTaskButton'));

      expect(taskNameField, findsOneWidget);
      expect(taskDescriptionField, findsOneWidget);
      expect(taskAssigneeField, findsOneWidget);
      expect(taskStatusField, findsOneWidget);
      expect(deadlineField, findsOneWidget);
      expect(createTaskButton, findsOneWidget);

      await tester.enterText(taskNameField, 'Test Task NameI6cewJDdw9');
      await tester.enterText(taskDescriptionField, 'Test Task Description');

      await tester.tap(taskAssigneeField);
      await tester.pumpAndSettle();
      final assigneeOption = find.text('Minh').last;
      await tester.tap(assigneeOption);
      await tester.pumpAndSettle();

      await tester.tap(taskStatusField);
      await tester.pumpAndSettle();
      final statusOption = find.text('In Progress').last;
      await tester.tap(statusOption);
      await tester.pumpAndSettle();

      await tester.tap(deadlineField);
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.tap(createTaskButton);
      await tester.pumpAndSettle();

      expect(find.text('Failed to create task'), findsOneWidget);
      print("Test Case 2 finished");
    });
    // testWidgets('CASE 3: Update Task success', (tester) async {
    //   print("Test Case 3 started");
    //   await tester.pumpWidget(
    //       GetMaterialApp(
    //         initialBinding: InitialBinding(),
    //         initialRoute: AppRoutes.ADMIN_TASK_DETAIL,
    //         getPages: AppPages.pages,
    //         builder: EasyLoading.init(),
    //       ),
    //       duration: const Duration(seconds: 5));

    //   await tester.pumpAndSettle();

    //   // Find widgets for the task update form
    //   final taskNameField = find.byKey(const Key('taskNameField'));
    //   final taskDescriptionField =
    //       find.byKey(const Key('taskDescriptionField'));
    //   final taskAssigneeField = find.byKey(const Key('taskAssigneeField'));
    //   final taskStatusField = find.byKey(const Key('taskStatusField'));
    //   final deadlineField = find.byKey(const Key('deadlineField'));
    //   final updateTaskButton = find.byKey(const Key('updateTaskButton'));

    //   // Ensure the widgets are found
    //   expect(taskNameField, findsOneWidget);
    //   expect(taskDescriptionField, findsOneWidget);
    //   expect(taskAssigneeField, findsOneWidget);
    //   expect(taskStatusField, findsOneWidget);
    //   expect(deadlineField, findsOneWidget);
    //   expect(updateTaskButton, findsOneWidget);

    //   // Enter new data for the task
    //   await tester.enterText(taskNameField, 'Updated Task Name');
    //   await tester.enterText(taskDescriptionField, 'Updated Task Description');

    //   // Update assignee
    //   await tester.tap(taskAssigneeField);
    //   await tester.pumpAndSettle();
    //   final newAssigneeOption = find.text('Linh').last;
    //   await tester.tap(newAssigneeOption);
    //   await tester.pumpAndSettle();

    //   // Update status
    //   await tester.tap(taskStatusField);
    //   await tester.pumpAndSettle();
    //   final newStatusOption = find.text('Completed').last;
    //   await tester.tap(newStatusOption);
    //   await tester.pumpAndSettle();

    //   // Update deadline
    //   await tester.tap(deadlineField);
    //   await tester.pumpAndSettle();
    //   await tester.tap(find.text('20'));
    //   await tester.tap(find.text('OK'));
    //   await tester.pumpAndSettle();

    //   // Tap the update task button
    //   await tester.tap(updateTaskButton);
    //   await tester.pumpAndSettle();

    //   // Verify that the task update was successful
    //   expect(find.text('Updated successfully'), findsOneWidget);
    //   print("Test Case 3 finished");
    // });
  });
}
