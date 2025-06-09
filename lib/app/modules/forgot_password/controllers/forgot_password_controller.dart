import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/services/auth_services.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  var isLoading = false.obs;

  final AuthServices _authServices = AuthServices();

  Future<void> forgotPassword() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final response = await _authServices.forgotPassword(emailController.text);

      isLoading.value = false;

      if (response["success"] == true) {
        Get.snackbar(
          'Kode OTP telah dikirimkan',
          response['message'],
          backgroundColor: Colors.white,
        );
        Get.toNamed(
          "/otp",
          arguments: {"email": emailController.text, "register": false},
        );
      } else if (response['success'] == false) {
        Get.snackbar(
          "Error",
          response["message"],
          backgroundColor: Colors.white,
        );
      }
    }
  }
}
