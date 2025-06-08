import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiwayatView extends StatefulWidget {
  const RiwayatView({super.key});

  @override
  State<RiwayatView> createState() => _RiwayatViewState();
}

class _RiwayatViewState extends State<RiwayatView> {
  final List<Map<String, dynamic>> dummyTransactions = [
    {
      "title": "Gaji Bulanan",
      "amount": 5000000,
      "date": DateTime(2025, 4, 25),
      "isIncome": true,
    },
    {
      "title": "Makan Siang",
      "amount": 45000,
      "date": DateTime(2025, 4, 26),
      "isIncome": false,
    },
    {
      "title": "Beli Buku",
      "amount": 120000,
      "date": DateTime(2025, 4, 27),
      "isIncome": false,
    },
    {
      "title": "Bonus Tambahan",
      "amount": 750000,
      "date": DateTime(2025, 4, 28),
      "isIncome": true,
    },
  ];

  // Filter options
  String selectedCategory = 'Semua';
  DateTimeRange? selectedDateRange;

  List<Map<String, dynamic>> get filteredTransactions {
    return dummyTransactions.where((transaction) {
      final isIncome = transaction['isIncome'] as bool;
      final date = transaction['date'] as DateTime;

      // Filter kategori
      if (selectedCategory == 'Pemasukan' && !isIncome) return false;
      if (selectedCategory == 'Pengeluaran' && isIncome) return false;

      // Filter tanggal
      if (selectedDateRange != null) {
        if (date.isBefore(selectedDateRange!.start) ||
            date.isAfter(selectedDateRange!.end)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  void pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: selectedDateRange,
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMM yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Column(
        children: [
          // FILTER
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Dropdown kategori
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
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
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                // Button pilih tanggal
                ElevatedButton(
                  onPressed: pickDateRange,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Pilih Tanggal'),
                ),
              ],
            ),
          ),
          if (selectedDateRange != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dari ${formatter.format(selectedDateRange!.start)} s/d ${formatter.format(selectedDateRange!.end)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 8),

          // LIST TRANSAKSI
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = filteredTransactions[index];
                final isIncome = transaction['isIncome'] as bool;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(
                      isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                      color: isIncome ? Colors.green : Colors.red,
                    ),
                    title: Text(transaction['title']),
                    subtitle: Text(formatter.format(transaction['date'])),
                    trailing: Text(
                      "${isIncome ? '+' : '-'} Rp ${transaction['amount']}",
                      style: TextStyle(
                        color: isIncome ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
