import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'App_theme/App_theme.dart';
import 'App_theme/Themem_Controller.dart';
import 'Controller/CurrentUser_Controller.dart';
import 'View/CurrentUser_Screen.dart';
import 'View/Home_Screen.dart';
import 'View/LogIn_Screen.dart';
import 'View/Register_Screen.dart';
import 'language/Language.dart';
import 'language/Language_Controller.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(MyLanguageController());
  final themeController =Get.put(ThemeController());
  themeController.loadThemeFromStorage();
  Get.put(CurrentUserController());

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final myLanguageController = Get.find<MyLanguageController>();
    final ThemeController themeController = Get.find();
    final storage = GetStorage();
    final token = storage.read('token');
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
      initialRoute:'/loginScreen' ,
      //initialRoute: token == null ? '/loginScreen' : '/homeScreen',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      locale:myLanguageController.intiaLanguage.value,
      translations: MyLanguage(),
      getPages: [
        GetPage(name: '/registerScreen', page: ()=>const RegisterScreen()),
        GetPage(name: '/loginScreen', page: ()=>const LoginScreen()),
        GetPage(name: '/homeScreen', page: ()=> HomeScreen()),
        GetPage(name: '/profileScreen', page: ()=> ProfileScreen()),
      ],
    );
  }
}
