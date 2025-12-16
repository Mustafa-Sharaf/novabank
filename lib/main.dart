import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as storage;
import 'App_theme/Themem_Controller.dart';
import 'View/CurrentUser_View.dart';
import 'View/Home_Screen.dart';
import 'View/LogIn_Screen.dart';
import 'View/Register_Screen.dart';
import 'language/Language_Controller.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(MyLanguageController());
  final themeController =Get.put(ThemeController());
  themeController.loadThemeFromStorage();
  final storage = GetStorage();
  final token = storage.read('token');
  runApp(MyApp(initialRoute: token == null ? '/loginScreen' : '/homeScreen'));
}


class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key,required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
      initialRoute:initialRoute,
      getPages: [
        GetPage(name: '/registerScreen', page: ()=>const RegisterScreen()),
        GetPage(name: '/loginScreen', page: ()=>const LoginScreen()),
        GetPage(name: '/homeScreen', page: ()=> HomeScreen()),
        GetPage(name: '/profileScreen', page: ()=> ProfileScreen()),

      ],
    );
  }
}
