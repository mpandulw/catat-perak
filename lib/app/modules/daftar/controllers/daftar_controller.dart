import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/services/auth_services.dart';
import 'package:get/get.dart';

class DaftarController extends GetxController {
  var isLoading = false.obs;
  final isObsecure = true.obs;

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confPasswordController = TextEditingController();

  final AuthServices _authServices = AuthServices();

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final result = await _authServices.register(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      isLoading.value = false;

      if (result['success'] == true) {
        Get.snackbar(
          'Registrasi Berhasil',
          result['message'],
          backgroundColor: Colors.white,
        );
        Get.offAllNamed(
          '/otp',
          arguments: {'email': emailController.text, "register": true},
        );
      } else if (result['success'] == false) {
        passwordController.clear();
        confPasswordController.clear();
        Get.snackbar(
          'Registrasi Gagal',
          result['message'],
          backgroundColor: Colors.redAccent,
        );
      }
    } else {
      passwordController.clear();
      confPasswordController.clear();
    }
  }

  void togglePassword() {
    isObsecure.value = !isObsecure.value;
  }
}
