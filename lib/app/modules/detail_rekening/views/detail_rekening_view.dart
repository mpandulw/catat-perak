import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_rekening_controller.dart';

class DetailRekeningView extends GetView<DetailRekeningController> {
  const DetailRekeningView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Rekening'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed:
                () => Get.toNamed(
                  '/edit-rekening',
                  arguments: {
                    'id': controller.id,
                    'name': controller.accountName,
                    'balance': controller.accountBalance,
                  },
                ),
            icon: const Icon(Icons.edit_rounded, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text("Nama Rekening"),
                ),

                // Account balance name
                TextFormField(
                  enabled: false,
                  initialValue: controller.accountName,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text("Saldo Rekening"),
                ),

                // Account balance amount
                TextFormField(
                  enabled: false,
                  initialValue: controller.accountBalance.toString(),
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
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
