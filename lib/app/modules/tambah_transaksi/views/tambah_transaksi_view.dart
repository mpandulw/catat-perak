import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tambah_transaksi_controller.dart';

class TambahTransaksiView extends GetView<TambahTransaksiController> {
  const TambahTransaksiView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Transaksi'),
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF2D3748),
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            labelStyle: TextStyle(color: Colors.white),
            unselectedLabelStyle: TextStyle(color: Colors.white),
            tabs: [
              Tab(
                icon: Icon(Icons.arrow_upward_rounded, color: Colors.green),
                text: "Pemasukan",
              ),
              Tab(
                icon: Icon(Icons.arrow_downward_rounded, color: Colors.red),
                text: "Pengeluaran",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Income form
            Center(
              child: Form(
                key: controller.incomeFormKey,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      const SizedBox(height: 15),

                      // Income transaction name
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text("Nama Transaksi"),
                      ),
                      TextFormField(
                        controller: controller.incomeTransactionNameController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Table item and price
                      Obx(
                        () => Column(
                          children: [
                            Table(
                              border: TableBorder.all(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        "Nama Item",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        "Harga",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(""),
                                    ),
                                  ],
                                ),
                                ...List.generate(controller.itemInputs.length, (
                                  index,
                                ) {
                                  final item = controller.itemInputs[index];
                                  return TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: TextFormField(
                                          controller: item.incomeNameController,
                                          decoration: const InputDecoration(
                                            hintText: "Nama barang",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: TextFormField(
                                          controller:
                                              item.incomePriceController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            hintText: "Rp",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed:
                                            () => controller.removeItem(index),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton.icon(
                                onPressed: controller.addItem,
                                icon: const Icon(Icons.add),
                                label: const Text("Tambah Item"),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Dropdown accounts
                      Obx(
                        () => DropdownButtonFormField<String>(
                          value:
                              controller.selectedAccount.value.isNotEmpty
                                  ? controller.selectedAccount.value
                                  : null,
                          items:
                              controller.rekeningList.map((rekening) {
                                return DropdownMenuItem<String>(
                                  value: rekening.name,
                                  child: Text(rekening.name),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.selectedAccount.value = value;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "Pilih Akun",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Note
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text("Note"),
                      ),
                      TextFormField(
                        controller: controller.incomeNoteController,
                        maxLines: 5,
                        minLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true, // aligns label to top
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Button add transaction
                      TextButton(
                        onPressed: () => controller.addTransaction(true),
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

            // Expense form
            Center(
              child: Form(
                key: controller.expenseFormKey,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      const SizedBox(height: 15),

                      // Expense transaction name
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text("Nama Transaksi"),
                      ),
                      TextFormField(
                        controller: controller.expenseTransactionNameController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Expense items
                      Obx(
                        () => Column(
                          children: [
                            Table(
                              border: TableBorder.all(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                  ),
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        "Nama Item",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        "Harga",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(""),
                                    ),
                                  ],
                                ),
                                ...List.generate(controller.itemInputs.length, (
                                  index,
                                ) {
                                  final item = controller.itemInputs[index];
                                  return TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: TextFormField(
                                          controller:
                                              item.expenseNameController,
                                          decoration: const InputDecoration(
                                            hintText: "Nama barang",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: TextFormField(
                                          controller:
                                              item.expensePriceController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            hintText: "Rp",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed:
                                            () => controller.removeItem(index),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // Add column button
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton.icon(
                                onPressed: controller.addItem,
                                icon: const Icon(Icons.add),
                                label: const Text("Tambah Item"),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Dropdown accounts widget
                      Obx(
                        () => DropdownButtonFormField<String>(
                          value:
                              controller.selectedAccount.value.isNotEmpty
                                  ? controller.selectedAccount.value
                                  : null,
                          items:
                              controller.rekeningList.map((rekening) {
                                return DropdownMenuItem<String>(
                                  value: rekening.name,
                                  child: Text(rekening.name),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.selectedAccount.value = value;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "Pilih Akun",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Note
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text("Note"),
                      ),
                      TextFormField(
                        controller: controller.expenseNoteController,
                        maxLines: 5,
                        minLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true, // aligns label to top
                        ),
                      ),

                      const SizedBox(height: 30),

                      TextButton(
                        onPressed: () => controller.addTransaction(false),
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
          ],
        ),
      ),
    );
  }
}
