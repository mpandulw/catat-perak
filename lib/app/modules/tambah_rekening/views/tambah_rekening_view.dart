import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/rekening_model.dart';

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
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text("Nama Rekening"),
                ),

                // Account balance name
                TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  onChanged: (value) => controller.name.value = value,
                ),

                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text("Saldo Rekening"),
                ),

                // Account balance amount
                Obx(
                  () => TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    // onChanged: (value) => ,
                  ),
                ),

                const SizedBox(height: 32),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      controller.addRekening(
                        RekeningModel(
                          name: controller.name.value,
                          balance: controller.balance.value,
                        ),
                      );
                      controller.clearForm();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    ),
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
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
