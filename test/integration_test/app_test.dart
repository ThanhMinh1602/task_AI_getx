import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:task/firebase_options.dart';

import 'login_screen_test.dart';
import 'member_detail_screen_test.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LoginScreenTest.loginTest();
  await MemberDetailScreenTest.addTask();

  // await MemberDetailScreenTest.updateMember();
}
