// lib/app/controllers/login_controller.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/auth_services.dart';

class LoginController extends GetxController {
  late SharedPreferences prefs;

  final obsecurePassword = true.obs;
  final isLoading = false.obs;
  final isRemember = false.obs;

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthServices _authServices = AuthServices();

  void togglePassword() {
    obsecurePassword.value = !obsecurePassword.value;
  }

  @override
  void onInit() {
    super.onInit();
    _initPrefsAndAutoLogin();
  }

  void _initPrefsAndAutoLogin() async {
    prefs = await SharedPreferences.getInstance();
    await autoLogin();
  }

  Future<void> autoLogin() async {
    final username = prefs.getString('username');
    final password = prefs.getString('password');

    if (username != null &&
        password != null &&
        username.isNotEmpty &&
        password.isNotEmpty) {
      isLoading.value = !isLoading.value;

      final response = await _authServices.login(username, password);

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

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      if (isRemember.isTrue) {
        prefs.setString('username', usernameController.text);
        prefs.setString('password', passwordController.text);
      }

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
          backgroundColor: Colors.redAccent,
        );
      } else {
        Get.snackbar(
          'Login Gagal',
          response['message'],
          backgroundColor: Colors.redAccent,
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

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId:
        '1017030183926-nn806v03apkfj34iu8lv20fd2mmb57tb.apps.googleusercontent.com',
  );

  Future<void> loginWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      final auth = await account?.authentication;

      final response = await http.post(
        Uri.parse(
          'http://catatperak.my.id/auth/mobile',
        ), // kamu buat endpoint baru khusus
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id_token': auth?.idToken}),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        print('Login Berhasil: ${result['access_token']}');
      } else {
        print('Login gagal: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Future<void> logout() async {
  //   await _googleSignIn.signOut();
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  //   Get.offAllNamed("/login");
  // }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("token");
  }

  // Future<String?> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("token");
  // // }

  // Future<String?> getUsername() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("username");
  // }

  // Future<String?> getEmail() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("email");
  // }
}
