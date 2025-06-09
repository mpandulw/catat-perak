import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF2D3748),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login.',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Text(
                    "Good to see you again",
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
                      mainAxisAlignment: MainAxisAlignment.center,
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

                        const SizedBox(height: 30),

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
                                    controller.obsecurePassword.value
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                              ),
                            ),
                            obscureText: controller.obsecurePassword.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),

                        // Forgot password
                        TextButton(
                          onPressed: () => Get.toNamed('/forgot-password'),
                          child: const Text(
                            'Forgot your password?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Login
                        SizedBox(
                          width: double.infinity,
                          child: Obx(
                            () =>
                                controller.isLoading.value
                                    ? Center(child: CircularProgressIndicator())
                                    : FilledButton(
                                      onPressed: () => controller.login(),
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                          Colors.blue,
                                        ),
                                      ),
                                      child: const Text("Login"),
                                    ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                                indent: 15,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text("Or"),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                                endIndent: 15,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Alternative login
                        Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: CircleAvatar(
                              backgroundColor: const Color.fromARGB(
                                255,
                                220,
                                220,
                                220,
                              ),
                              child: Image.asset(
                                'assets/images/google_icon.png',
                              ),
                            ),
                            onPressed: () => controller.googleSignIn(),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Register button
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed("/daftar");
                            },
                            child: const Text(
                              "Tidak punya akun? daftar disini",
                              style: TextStyle(color: Colors.blue),
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
      ),
    );
  }
}
