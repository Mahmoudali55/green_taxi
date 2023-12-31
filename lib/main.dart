import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_texi/controller/auth_controller.dart';
import 'package:green_texi/firebase_options.dart';
import 'package:green_texi/views/login_screen.dart';
import 'package:green_texi/views/profileSetting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final TextTheme = Theme.of(context).textTheme;
    AuthCountroller authCountroller = Get.put(AuthCountroller());
    authCountroller.decideRoute();
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(TextTheme),
        ),
        home: LoginScreen());
  }
}
