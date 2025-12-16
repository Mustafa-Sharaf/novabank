import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../App_theme/AppColors.dart';
import '../Controller/LogIn_Controller.dart';
import '../widgets/buildTextField.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogInController());
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF19314e),
              Color(0xff436ea8),
              Color(0xff6a9fe1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "NovaBank".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "WelcomeBack".tr,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Buildtextfield(
                          label: "Email".tr,
                          icon: Icons.email,
                          controller: controller.emailController,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10,),
                        Buildtextfield(
                          label: "Password".tr,
                          icon: Icons.lock,
                          controller: controller.passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "ForgotPassword".tr,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed:controller.login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              "Log_In".tr,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text("Don’tHaveAnAccount".tr),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/registerScreen');
                              },
                              child: Text(
                                "Register".tr,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
