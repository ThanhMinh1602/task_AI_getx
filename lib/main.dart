import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task/app/binding/app_binding.dart';
import 'package:task/app/views/admin/admin_main.dart';
import 'package:task/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const AdminMain(),
        builder: EasyLoading.init(),
        initialBinding: AppBinding(),
      ),
    );
  }
}
