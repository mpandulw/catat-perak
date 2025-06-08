import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/daftar_controller.dart';

class DaftarView extends GetView<DaftarController> {
  const DaftarView({super.key});
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
                  'Register.',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  "Let's get started",
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
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 27.5),

                      // Username
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text("Username"),
                      ),
                      const SizedBox(height: 7.5),
                      TextFormField(
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username tidak boleh kosong!";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Email
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text("Email"),
                      ),
                      const SizedBox(height: 7.5),
                      TextFormField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong!';
                          }
                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return 'Format email tidak valid';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Password
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text("Password"),
                      ),
                      const SizedBox(height: 7.5),
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.togglePassword();
                              },
                              icon:
                                  controller.isObsecure.value
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                            ),
                          ),
                          obscureText: controller.isObsecure.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password tidak boleh kosong!";
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Confirmation password
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text("Konfirmasi Password"),
                      ),
                      const SizedBox(height: 7.5),
                      TextFormField(
                        controller: controller.confPasswordController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Konfirmasi password tidak boleh kosong!";
                          } else if (controller.passwordController.text !=
                              controller.confPasswordController.text) {
                            return "Password dan konfirmasi password tidak cocok";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 32),

                      // Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: Obx(
                          () =>
                              controller.isLoading.value
                                  ? Center(child: CircularProgressIndicator())
                                  : FilledButton(
                                    onPressed: () => controller.register(),
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
