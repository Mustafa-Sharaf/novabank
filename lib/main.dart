import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'View/Home_Screen.dart';
import 'View/LogIn_Screen.dart';
import 'View/Register_Screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
      home:  LoginScreen(),
      getPages: [
        GetPage(name: '/registerScreen', page: ()=>const RegisterScreen()),
        GetPage(name: '/loginScreen', page: ()=>const LoginScreen()),
        GetPage(name: '/homeScreen', page: ()=> HomeScreen()),

      ],
    );
  }
}
