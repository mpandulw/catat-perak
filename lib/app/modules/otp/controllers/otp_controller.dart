import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/services/auth_services.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  var otp = "".obs;
  late String email;
  late bool register;

  final RxBool isLoading = false.obs;

  final AuthServices _authServices = AuthServices();

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
    register = Get.arguments['register'];
  }

  void verifyOtp() async {
    if (register == true) {
      isLoading.value = true;

      final response = await _authServices.verifyOtp(email, otp.value);

      isLoading.value = false;

      if (response["success"] == true) {
        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder:
              (context) => AlertDialog(
                title: const Text("Berhasil Memverifikasi Akunmu"),
                icon: Image.asset('images/check.gif', width: 200, height: 200),
                content: const Text(
                  "Akun sudah terverifikasi. Kamu sudah bisa login menggunakan akun ini.",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.offNamedUntil('/login', (route) => false);
                    },
                    child: const Text("Selesai"),
                  ),
                ],
              ),
        );
      } else if (response["success"] == false) {
        Get.snackbar(
          "Error",
          response["message"],
          backgroundColor: Colors.white,
        );
      }
    } else if (register == false) {
      Get.offAllNamed(
        "/reset-password",
        arguments: {"email": email, "otp": otp.value},
      );
    }
  }
}
