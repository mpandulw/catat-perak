import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // bottom navigation bar
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // date formatter
import 'package:get/get.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // expandable floating action button
import 'package:collection/collection.dart';

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

      body: RefreshIndicator(
        onRefresh: () => controller.getTransaction(),
        child: ListView(
          children: [
            Stack(
              children: [
                // Background Color
                Container(
                  height: 120,
                  decoration: BoxDecoration(color: const Color(0xFF2D3748)),
                ),

                // Account Balance Card
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
                          Obx(() {
                            final list = controller.rekeningList;
                            if (list.isEmpty) {
                              return const Text(
                                'Rp 0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }

                            final current =
                                list[controller.currentIndexMarquee.value];

                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder: (
                                Widget child,
                                Animation<double> animation,
                              ) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 1),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                              child: Text(
                                "Rp ${controller.formatter.format(current.balance)}",
                                key: ValueKey(current.id),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }),

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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Transaction Log
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                if (controller.isLoading.value == true) {
                  return CircularProgressIndicator();
                }

                if (controller.transactionsList.isEmpty) {
                  return SizedBox(
                    height:
                        MediaQuery.of(context).size.height *
                        0.5, // agar tidak terlalu ke bawah
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/transaction.png',
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Transaksi Kosong, silahkan tekan\ntombol '+' untuk menambah transaksi",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }

                final transactions =
                    controller.transactionsList
                        .sorted(
                          (a, b) => b.date.compareTo(a.date),
                        ) // urutkan terbaru ke terlama
                        .take(10)
                        .toList();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return Card(
                      child: ExpansionTile(
                        shape: Border(),
                        leading:
                            transaction.type == "income"
                                ? const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.green,
                                )
                                : const Icon(
                                  Icons.arrow_upward,
                                  color: Colors.red,
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
                                '${transaction.type == "income" ? '+' : '-'} Rp ${NumberFormat('#,###').format(transaction.totalPrice)}',
                                style: TextStyle(
                                  color:
                                      transaction.type == "income"
                                          ? Colors.green
                                          : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder:
                                    (BuildContext context) => [
                                      // PopupMenuItem(
                                      //   child: TextButton(
                                      //     onPressed:
                                      //         () => Get.toNamed(
                                      //           '/edit-transaksi',
                                      //         ),
                                      //     child: Row(
                                      //       children: const [
                                      //         Icon(
                                      //           Icons.edit,
                                      //           color: Colors.blueGrey,
                                      //         ),
                                      //         SizedBox(width: 8),
                                      //         Text(
                                      //           'Edit',
                                      //           style: TextStyle(
                                      //             color: Colors.black,
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
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
                                                      onPressed:
                                                          () => controller
                                                              .delTransaction(
                                                                transaction.id,
                                                              ),
                                                      child: const Text("Ya"),
                                                    ),
                                                    TextButton(
                                                      onPressed:
                                                          () => Navigator.pop(
                                                            context,
                                                          ),
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
                                            children: const [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
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
                        children: [
                          if (transaction.items != null &&
                              transaction.items!.isNotEmpty)
                            ...transaction.items!.map((item) {
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
                          if (transaction.note != null &&
                              transaction.note!.isNotEmpty)
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
                                      transaction.note!,
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
