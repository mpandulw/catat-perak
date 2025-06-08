import 'package:flutter_application_1/app/data/services/auth_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ResetPasswordController extends GetxController {
  late String email;
  late String otp;

  final isLoading = false.obs;

  final AuthServices _authServices = AuthServices();

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
    otp = Get.arguments['otp'];
  }

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final response = await _authServices.resetPassword(
        email,
        otp,
        passwordController.text,
      );

      isLoading.value = false;

      if (response["success"] == true) {
        Get.toNamed("/login");
        Get.snackbar(
          "Berhasil Reset Password",
          response['message'],
          backgroundColor: Colors.white,
        );
      } else if (response['success'] == false) {
        passwordController.clear();
        confPasswordController.clear();
        Get.snackbar(
          "Error",
          response["message"],
          backgroundColor: Colors.white,
        );
      }
    } else {
      passwordController.clear();
      confPasswordController.clear();
    }
  }
}
