import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/Register_Model.dart';
import '../Validation/email_validation.dart';
import '../Validation/empty_fields_validation.dart';
import '../Validation/password_validation.dart';
import '../Validation/phone_validation.dart';
import '../Validation/validation_context.dart';
import '../configurations/http_helpers.dart';
import '../widgets/OTPDialog.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final loading = false.obs;
  final otpLoading = false.obs;
  String registeredEmail = "";
  String otpCode = "";

  void register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final phone = phoneNumberController.text.trim();

    final validator = ValidationContext([
      EmptyFieldsValidation([name, email, password, phone]),
      EmailValidation(email),
      PasswordValidation(password),
      PhoneValidation(phone),
    ]);

    final error = validator.validateAll();
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

    final user = UserModel(
      userName: name,
      email: email,
      password: password,
      phoneNumber: phone,
    );

    try {
      final response = await HttpHelper.postMultipartRequest(
        endpoint: "users/register",
        fields: {
          "UserName": user.userName,
          "Email": user.email,
          "Password": user.password,
          "PhoneNumber": user.phoneNumber,
          "Role": user.role,
        },
      );
      loading.value = false;

      if (response["success"] == true) {
        registeredEmail = email;
        showOTPDialog();
      } else {
        Get.snackbar(
          "Error",
          response["message"] ?? "Server returned an error",
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

  void showOTPDialog() {
    otpCode = "";
    Get.dialog(
      OTPDialog(
        loading: otpLoading,
        otpCode: otpCode,
        onChanged: (value) {
          otpCode = value;
          //print("OTP TYPING: $otpCode");
        },
        onVerify: () {
          // print("VERIFY CLICKED — input code: $otpCode");
          if (otpCode.length == 6) {
            confirmOTP(otpCode);
          } else {
            // print("OTP not 6 digits");
            Get.snackbar(
              "Error",
              "OTP must be 6 digits",
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        },
      ),
      barrierDismissible: false,
    );
  }

  void confirmOTP(String code) async {
    otpLoading.value = true;
    final email = registeredEmail;
    try {
      final url = Uri.parse("${baseUrl}users/confirmEmail");
      final res = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "*/*",
        },
        body: jsonEncode({"email": email, "code": code}),
      );
      otpLoading.value = false;
      if (res.statusCode == 200) {
        if (res.body.isEmpty) {
          Get.snackbar(
            "Success",
            "Email confirmed successfully! You can now log in.",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offNamed('/loginScreen');
          return;
        }

        final response = jsonDecode(res.body);
        if (response["successStatus"] == true) {
          Get.back();
          Get.snackbar(
            "Success",
            "Email confirmed successfully! You can now log in.",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offNamed('/loginScreen');
        } else {
          Get.snackbar(
            "Error",
            response["message"] ?? "Invalid OTP",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Server error: ${res.statusCode}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      otpLoading.value = false;
      Get.snackbar(
        "Error",
        "Connection Failed: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
