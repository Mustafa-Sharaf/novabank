import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/LogIn_Model.dart';
import '../Validation/email_validation.dart';
import '../Validation/empty_fields_validation.dart';
import '../Validation/password_validation.dart';
import '../Validation/validation_context.dart';
import '../configurations/http_helpers.dart';

class LogInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loading = false.obs;

  final storage = GetStorage();

  void login() async {
    String fcmToken = GetStorage().read('fcm_token') ?? "";
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final validator = ValidationContext([
      EmptyFieldsValidation([email, password]),
      EmailValidation(email),
      PasswordValidation(password),
    ]);

    final error = validator.validateAll();
    //print("error------------------$error");
    if (error != null) {
      Get.snackbar(
        "Error",
        error,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    loading.value = true;

    final userLogin = UserLoginModel(
      email: email,
      password: password,
      deviceToken: fcmToken,
    );
    print("fcmToken----------------$fcmToken");

    try {
      final response = await HttpHelper.postRequest(
        endpoint: "users/login",
        body: userLogin.toJson(),
      );
      loading.value = false;

      if (response["success"] == true) {
        final token = response["data"]["token"];
        await storage.write("token", token);
        await storage.write("refreshToken", response["data"]["refreshToken"]);


        Get.snackbar(
          "Success",
          "Logged in successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await storage.save();

        print("TOKEN SAVED: ${storage.read("token")}");
        print("REFRESH SAVED: ${storage.read("refreshToken")}");
        Get.offAllNamed('/homeScreen');

      } else {
        String errorMsg = "";
        if (response["data"] != null && response["data"] is List) {
          List errors = response["data"];
          errorMsg = errors.map((e) => e["description"]).join("\n");
        } else if (response["message"] != null &&
            response["message"].toString().isNotEmpty) {
          errorMsg = response["message"].toString();
        } else {
          errorMsg = "Server returned an error";
        }
        print("errorMsg$errorMsg");
        Get.snackbar(
          "Error",
          errorMsg,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar(
        "Error",
        "An error occurred: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
