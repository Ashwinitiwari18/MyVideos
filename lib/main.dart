import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/constant.dart';
import 'package:getx_tutorial/controller/auth_controller.dart';
import 'package:getx_tutorial/view/screen/auth/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/logo.png'),
        backgroundColor: backgroundColor,
        nextScreen: LoginScreen(),
        splashIconSize: 250,
        splashTransition: SplashTransition.scaleTransition,
      ),
    );
  }
}
