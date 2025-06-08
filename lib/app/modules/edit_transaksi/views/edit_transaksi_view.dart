import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_transaksi_controller.dart';

class EditTransaksiView extends GetView<EditTransaksiController> {
  const EditTransaksiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Transaksi'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF2D3748),
      ),

      body: Center(
        child: Form(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Row(
                //   children: [
                //     Flexible(
                //       flex: 2,
                //       child: TextFormField(
                //         textAlign: TextAlign.center,
                //         initialValue: DateFormat(
                //           "dd-MM-yyyy",
                //         ).format(DateTime.now()),
                //         decoration: InputDecoration(
                //           border: OutlineInputBorder(),
                //           prefixIcon: Icon(Icons.calendar_month_rounded),
                //         ),
                //       ),
                //     ),
                //     Flexible(
                //       flex: 1,
                //       child: TextFormField(
                //         textAlign: TextAlign.center,
                //         initialValue: DateFormat(
                //           "HH:mm",
                //         ).format(DateTime.now()),
                //         decoration: InputDecoration(
                //           border: OutlineInputBorder(),
                //           prefixIcon: const Icon(
                //             Icons.access_time_rounded,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 15),

                // Transaction name
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text("Nama Transaksi"),
                ),

                // Transaction name TextFormField
                TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                // Table items
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Table(
                        border: TableBorder.all(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey[300]),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Nama Item",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Jumlah (Rp)",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          ...List.generate(controller.totalColumn.value, (
                            index,
                          ) {
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          // Add new column button
                          ElevatedButton.icon(
                            onPressed: () => controller.totalColumn.value++,
                            icon: const Icon(Icons.add),
                            label: const Text("Tambah Baris"),
                          ),

                          // Delete the last button
                          ElevatedButton.icon(
                            onPressed: () => controller.delColum(),
                            icon: const Icon(Icons.delete, color: Colors.red),
                            label: const Text("Hapus Baris"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: const Text("Nominal"),
                // ),
                // // TextFormField title
                // TextFormField(
                //   decoration: InputDecoration(
                //     isDense: true,
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  value: controller.selectedAccount.value,
                  items:
                      controller.accountList.map((String account) {
                        return DropdownMenuItem<String>(
                          value: account,
                          child: Text(account),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedAccount.value = value;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Pilih Akun",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text("Note"),
                ),

                // Note
                TextFormField(
                  maxLines: 5,
                  minLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true, // aligns label to top
                  ),
                ),

                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: const Text("Judul"),
                // ),
                // // TextFormField title
                // TextFormField(
                //   decoration: InputDecoration(
                //     isDense: true,
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                const SizedBox(height: 30),

                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),
                  child: const Text(
                    "Catat transaksi",
                    style: TextStyle(color: Colors.white),
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
