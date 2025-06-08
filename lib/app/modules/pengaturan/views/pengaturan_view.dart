import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengaturan_controller.dart';

class PengaturanView extends GetView<PengaturanController> {
  const PengaturanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Text pengaturan
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Pengaturan",
                  style: TextStyle(fontSize: 48.5, fontWeight: FontWeight.bold),
                ),
              ),

              // Adding height
              const SizedBox(height: 42),

              // Account
              const Text(
                "Akun",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListTile(
                onTap: () => Get.toNamed('/edit-profil'),
                leading: CircleAvatar(child: const Icon(Icons.person)),
                // shape: RoundedRectangleBorder(
                //   side: BorderSide(),
                //   borderRadius: BorderRadius.all(Radius.circular(16)),
                // ),
                // contentPadding: EdgeInsets.symmetric(
                //   horizontal: 16,
                //   vertical: 8,
                // ),
                trailing: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: const Color.fromARGB(255, 200, 200, 200),
                  ),
                  height: 32,
                  width: 32,
                  padding: EdgeInsets.all(2.5),
                  child: const Icon(
                    (Icons.arrow_forward_ios_rounded),
                    size: 16,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Username", style: TextStyle(fontSize: 14.5)),
                    Text(
                      "email@gmail.com",
                      style: TextStyle(color: Colors.grey, fontSize: 12.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Other settings
              const Text(
                "Pengaturan lainnya",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              // Dark mode switcher
              ListTile(
                leading: Icon(Icons.dark_mode_rounded, color: Colors.blueGrey),
                title: const Text('Dark Mode'),
                subtitle: const Text('Ubah tampilan aplikasi menjadi gelap'),
                trailing: Obx(
                  () => Switch(
                    value: controller.isDarkMode.value,
                    onChanged: (_) {
                      controller.changeTheme();
                    },
                    activeTrackColor: Colors.blue,
                  ),
                ),
              ),
              // Info app
              ListTile(
                onTap: () => Get.toNamed('/info-app'),
                leading: const Icon(Icons.info_rounded),
                title: const Text("Informasi"),
                subtitle: const Text("Informasi tentang aplikasi kami"),
                trailing: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: const Color.fromARGB(255, 200, 200, 200),
                  ),
                  height: 32,
                  width: 32,
                  padding: EdgeInsets.all(2.5),
                  child: const Icon(
                    (Icons.arrow_forward_ios_rounded),
                    size: 16,
                  ),
                ),
              ),
              // Logout button
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                subtitle: const Text('Keluar dari akun anda'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Mau kemana?"),
                        icon: Image.asset('images/el_wiwi.jpeg'),
                        content: const Text(
                          "Apa kamu yakin ingin meninggalkan el wiwi sendirian?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.offAllNamed('/login'),
                            child: const Text("Adios"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Hell nah"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
