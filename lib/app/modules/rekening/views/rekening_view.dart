import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Obx(() {
            if (controller.isLoading.value == true) {
              return const CircularProgressIndicator();
            }

            if (controller.rekeningList.isEmpty) {
              return const Text("Tidak ada rekening");
            }

            return RefreshIndicator(
              onRefresh: () => controller.getAccounts(),
              child: ListView.builder(
                itemCount: controller.rekeningList.length,
                itemBuilder: (content, index) {
                  final rekening = controller.rekeningList[index];
                  return Card(
                    child: ListTile(
                      onTap:
                          () => Get.toNamed(
                            '/detail-rekening',
                            arguments: {
                              'id': rekening.id,
                              'name': rekening.name,
                              'balance': rekening.balance,
                            },
                          ),
                      title: Text(rekening.name),
                      trailing: IconButton(
                        onPressed: () => controller.delAccount(rekening.id),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                      subtitle: Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(rekening.balance),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ),

      // body: Center(
      //   child: Padding(
      //     padding: EdgeInsets.all(16),
      //     child: Column(
      //       children: [
      //         ...controller.rekeningList.map((account) {
      //           return Card(
      //             child: ListTile(
      //               onTap: () => Get.toNamed('/detail-rekening'),
      //               leading: Text(account.name),
      //               trailing: Text(account.balance.toString()),
      //             ),
      //           );
      //         }),
      //       ],
      //     ),
      //   ),
      // ),

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
