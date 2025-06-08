import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/info_app_controller.dart';

class InfoAppView extends GetView<InfoAppController> {
  const InfoAppView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: const Icon(Icons.apps, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),

            // Nama Aplikasi
            Center(
              child: Text(
                "MyFinance App",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Versi
            Center(
              child: Text(
                "Versi 1.0.0",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 32),

            // Deskripsi
            const Text(
              "Tentang Aplikasi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "MyFinance App adalah aplikasi untuk membantu Anda "
              "mencatat transaksi keuangan pribadi seperti pemasukan, "
              "pengeluaran, dan mengelola saldo rekening secara efektif. "
              "Aplikasi ini bertujuan untuk memberikan gambaran sederhana "
              "atas kondisi keuangan harian Anda.",
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 32),

            // Credit / Developer Info
            const Text(
              "Dikembangkan oleh",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Tim Developer Flutter"),
          ],
        ),
      ),
    );
  }
}
