import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // bottom navigation bar
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // date formatter
import 'package:get/get.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // expandable floating action button

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body
      body: Obx(
        () => AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: controller.pages[controller.currentIndex.value],
        ),
      ),

      bottomNavigationBar: CurvedNavigationBar(
        items: [
          const Icon(Icons.home),
          const Icon(Icons.account_balance_wallet_rounded),
          const Icon(Icons.bar_chart_rounded),
          const Icon(Icons.history_rounded),
        ],
        onTap: (value) => controller.changeIndex(value),
      ),
    );
  }
}

class Home extends GetView<HomeController> {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: Text(
          DateFormat('dd-MM-yyyy').format(DateTime.now()),
          style: TextStyle(fontSize: 18.5),
        ),
        titleSpacing: -4,
        leading: const Icon(Icons.calendar_month),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/pengaturan');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        foregroundColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFF2D3748),
      ),

      body: Center(
        child: ListView(
          children: [
            // Stack for account balance card
            Stack(
              children: [
                // Empty container
                Container(
                  height: 120,
                  decoration: BoxDecoration(color: const Color(0xFF2D3748)),
                ),

                // Account balance card
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 13.5, horizontal: 16),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF4CC9F0),
                          const Color(0xFF2E5BFF),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Saldo
                          Align(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Saldo kamu',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Jumlah Saldo
                          Text(
                            controller.totalBalance.value.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28.5,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 16),

                          // Pengeluaran
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Pengeluaran',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '000.000',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          // Selisih
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Selisih',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '000.000',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Transaction log
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ...controller.transactions.map((transaction) {
                    bool isIncome = transaction.isIncome;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 8,
                      child: ExpansionTile(
                        shape: const Border(),
                        leading: Icon(
                          isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                          color: isIncome ? Colors.green : Colors.red,
                        ),
                        title: Text(transaction.title),
                        subtitle: Text(
                          DateFormat('dd MMM yyyy').format(transaction.date),
                        ),
                        trailing: IntrinsicWidth(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${isIncome ? '+' : '-'} Rp ${NumberFormat('#,###').format(transaction.totalAmount)}',
                                style: TextStyle(
                                  color: isIncome ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // Popup Menu
                              PopupMenuButton(
                                itemBuilder:
                                    (BuildContext context) => [
                                      // Button edit
                                      PopupMenuItem(
                                        child: TextButton(
                                          onPressed:
                                              () => Get.toNamed(
                                                '/edit-transaksi',
                                              ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.edit,
                                                color: Colors.blueGrey,
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                'Edit',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Button hapus
                                      PopupMenuItem(
                                        child: TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    "Hapus transaksi ini?",
                                                  ),
                                                  content: const Text(
                                                    "Apakah kamu yakin untuk menghapus transaksi ini?",
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {},
                                                      child: const Text("Ya"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Tidak",
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                'Hapus',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                              ),
                            ],
                          ),
                        ),

                        // Items
                        children:
                            transaction.items != null
                                ? transaction.items!.map((item) {
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
                                }).toList()
                                : [],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: // Floating action button
          _getFAB(),
    );
  }
}

Widget _getFAB() {
  return SpeedDial(
    activeChild: const Icon(Icons.close, color: Colors.white, weight: 32),
    activeBackgroundColor: Colors.red,
    animatedIconTheme: IconThemeData(size: 22),
    backgroundColor: Colors.blue,
    visible: true,
    curve: Curves.bounceIn,
    spacing: 16,
    spaceBetweenChildren: 16,
    overlayOpacity: 0,
    children: [
      // Scan Input
      SpeedDialChild(
        child: Icon(Icons.document_scanner, color: Colors.white),
        backgroundColor: Colors.blue,
        onTap: () {
          Get.toNamed('/scan');
        },
      ),

      // Manual Input
      SpeedDialChild(
        child: Icon(Icons.edit_document, color: Colors.white),
        backgroundColor: Colors.blue,
        onTap: () {
          Get.toNamed('/tambah-transaksi');
        },
      ),
    ],
    child: const Icon(Icons.add, color: Colors.white, weight: 32),
  );
}
