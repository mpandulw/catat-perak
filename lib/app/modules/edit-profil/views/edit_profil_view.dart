import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_profil_controller.dart';

class EditProfilView extends GetView<EditProfilController> {
  const EditProfilView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check, color: Colors.blue),
          ),
        ],
      ),

      body: Form(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Text account
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Akun",
                    style: TextStyle(
                      fontSize: 48.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Adding height
                const SizedBox(height: 42),

                // Username
                ListTile(
                  leading: SizedBox(
                    width: 150,
                    child: const Text(
                      "Username",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  title: TextFormField(
                    decoration: InputDecoration(border: UnderlineInputBorder()),
                  ),
                ),

                // Email
                ListTile(
                  leading: SizedBox(
                    width: 150,
                    child: const Text("email", style: TextStyle(fontSize: 16)),
                  ),
                  title: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ), // Customize the border color
                      ),
                    ),
                    initialValue: "email@gmail.com",
                    readOnly: true,
                  ),
                ),

                // Current password
                Obx(
                  () => ListTile(
                    leading: SizedBox(
                      width: 150,
                      child: const Text(
                        "Password",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    title: TextFormField(
                      obscureText: controller.currentPasswordObsecure.value,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        suffix: IconButton(
                          onPressed: () => controller.toggleCurrentPass(),
                          icon:
                              controller.currentPasswordObsecure.value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                ),

                // New Password
                Obx(
                  () => ListTile(
                    leading: SizedBox(
                      width: 150,
                      child: const Text(
                        "Password baru",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    title: TextFormField(
                      obscureText: controller.newPasswordObsecure.value,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        suffix: IconButton(
                          onPressed: () => controller.toggleNewPass(),
                          icon:
                              controller.newPasswordObsecure.value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                ),

                // Confirmation Password
                ListTile(
                  leading: SizedBox(
                    width: 150,
                    child: const Text(
                      "Konfirmasi password",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  title: TextFormField(
                    obscureText: controller.confirmationPasswordObsecure.value,
                    decoration: InputDecoration(border: UnderlineInputBorder()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
