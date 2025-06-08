import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D3748),

      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reset Password.',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  "U better don't forget this one lil bro",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 27.5),

                      // New password
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text("New Password"),
                      ),
                      const SizedBox(height: 7.5),
                      TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        controller: controller.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password tidak boleh kosong!";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Confirmation new password
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text("Confirmation Your New Password"),
                      ),
                      const SizedBox(height: 7.5),
                      TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        controller: controller.confPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password konfirmasi tidak boleh kosong!";
                          } else if (controller.passwordController.text !=
                              controller.confPasswordController.text) {
                            return "Password dan password konfirmasi tidak cocok";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 32),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Obx(
                          () =>
                              controller.isLoading.value
                                  ? Center(child: CircularProgressIndicator())
                                  : FilledButton(
                                    onPressed: () => controller.resetPassword(),
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        Colors.blue,
                                      ),
                                    ),
                                    child: const Text("Register"),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
