import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/riwayat/controllers/riwayat_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatView extends GetView<RiwayatController> {
  const RiwayatView({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => Row(
                children: [
                  // Dropdown kategori
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedCategory.value,
                      decoration: const InputDecoration(
                        labelText: 'Kategori',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items:
                          ['Semua', 'Pemasukan', 'Pengeluaran']
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.setCategory(value);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Button pilih tanggal
                  ElevatedButton(
                    onPressed: () async {
                      final picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                        initialDateRange: controller.selectedDateRange.value,
                      );
                      controller.setDateRange(picked);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Pilih Tanggal'),
                  ),
                ],
              ),
            ),
          ),

          Obx(() {
            final range = controller.selectedDateRange.value;
            if (range == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dari ${formatter.format(range.start)} s/d ${formatter.format(range.end)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 8),

          // List Transaksi
          Expanded(
            child: Obx(() {
              final transactions = controller.filteredTransactions;
              if (transactions.isEmpty) {
                return const Center(child: Text("Tidak ada transaksi."));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  final isIncome = tx.type == 'income';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ExpansionTile(
                      shape: Border(),
                      leading: Icon(
                        isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isIncome ? Colors.green : Colors.red,
                      ),
                      title: Text(tx.title),
                      subtitle: Text(formatter.format(tx.date)),
                      trailing: Text(
                        "${isIncome ? '+' : '-'} Rp ${tx.totalPrice}",
                        style: TextStyle(
                          color: isIncome ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        if (tx.items != null && tx.items!.isNotEmpty)
                          ...tx.items!.map((item) {
                            return ListTile(
                              title: Text(
                                item.item,
                                style: const TextStyle(fontSize: 13.5),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: Text(
                                  'Rp ${NumberFormat('#,###').format(item.amount)}',
                                  style: const TextStyle(fontSize: 13.5),
                                ),
                              ),
                            );
                          }).toList(),
                        if (tx.note != null && tx.note!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 12,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.sticky_note_2,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    tx.note!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
