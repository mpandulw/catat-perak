import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rekening_controller.dart';

class RekeningView extends GetView<RekeningController> {
  const RekeningView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        title: const Text('Rekening'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
      ),

      // List of accounts balance
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ...controller.rekeningList.map((account) {
                return Card(
                  child: ListTile(
                    onTap: () => Get.toNamed('/detail-rekening'),
                    leading: Text(account.name),
                    trailing: Text(account.balance.toString()),
                  ),
                );
              }),
            ],
          ),
        ),
      ),

      // Floating action button for add new account balance
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/tambah-rekening'),
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 22),
      ),
    );
  }
}
