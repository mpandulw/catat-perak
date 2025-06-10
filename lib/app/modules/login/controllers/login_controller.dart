// lib/app/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/auth_services.dart';

class LoginController extends GetxController {
  final obsecurePassword = true.obs;
  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthServices _authServices = AuthServices();

  void togglePassword() {
    obsecurePassword.value = !obsecurePassword.value;
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = !isLoading.value;

      final response = await _authServices.login(
        usernameController.text,
        passwordController.text,
      );

      isLoading.value = false;

      if (response['success'] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response['access_token']);
        prefs.setString('username', response['username']);
        prefs.setString('email', response['email']);

        Get.snackbar(
          'Login Berhasil',
          'Selamat Datang ${response['username']}!',
          backgroundColor: Colors.white,
        );
        Get.offAllNamed('/home');
      } else if (response["success"] == false) {
        passwordController.clear();
        Get.snackbar(
          'Login Gagal',
          response['message'],
          backgroundColor: Colors.white,
        );
      } else {
        Get.snackbar(
          'Login Gagal',
          response['message'],
          backgroundColor: Colors.white,
        );
      }
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Get.offAllNamed('/login');
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Future<void> googleSignIn() async {
  //   final response = await _authServices.googleSignIn();

  //   if (response['success'] == true) {
  //     print(response['message']);
  //   }
  // }
}
