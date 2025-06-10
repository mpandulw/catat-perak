import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tambah_rekening_controller.dart';

class TambahRekeningView extends GetView<TambahRekeningController> {
  const TambahRekeningView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Rekening'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text("Nama Rekening"),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  controller: controller.accountNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama rekening tidak boleh kosong!";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text("Saldo Rekening"),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: controller.accountBalanceController,
                ),

                const SizedBox(height: 32),

                Align(
                  alignment: Alignment.centerRight,
                  child: Obx(
                    () =>
                        controller.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : TextButton(
                              onPressed: () => controller.addRekening(),
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.blue,
                                ),
                              ),
                              child: const Text(
                                "Simpan",
                                style: TextStyle(color: Colors.white),
                              ),
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
