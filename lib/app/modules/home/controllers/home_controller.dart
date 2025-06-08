import 'package:flutter_application_1/app/data/models/transaksi_model.dart';
import 'package:flutter_application_1/app/data/models/item_transaksi_model.dart';

import 'package:flutter_application_1/app/modules/home/views/home_view.dart';
import 'package:flutter_application_1/app/modules/rekap/controllers/rekap_controller.dart';
import 'package:flutter_application_1/app/modules/rekap/views/rekap_view.dart';
import 'package:flutter_application_1/app/modules/rekening/controllers/rekening_controller.dart';
import 'package:flutter_application_1/app/modules/rekening/views/rekening_view.dart';
import 'package:flutter_application_1/app/modules/riwayat/controllers/riwayat_controller.dart';
import 'package:flutter_application_1/app/modules/riwayat/views/riwayat_view.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  // Dummy Data
  final List<Transaction> dummyTransactions = [
    Transaction(
      title: "Transaction 1",
      date: DateTime.now().subtract(Duration(days: 1)),
      account: "BRI",
      isIncome: true,
      items: [
        TransactionItem(item: "Gaji", amount: 10000.0),
        TransactionItem(item: "Bonus", amount: 25000.0),
      ],
      note: "Catatan",
    ),
    Transaction(
      title: "Transaction 2",
      date: DateTime.now().subtract(Duration(days: 3)),
      account: "BRI",
      isIncome: false,
      items: [
        TransactionItem(item: "Bakwan Jagung", amount: 10000.0),
        TransactionItem(item: "Bebek Goreng H.Slame(Asli)", amount: 5000.0),
      ],
      note: "Catatan",
    ),
    Transaction(
      title: "Transaction 2",
      date: DateTime.now().subtract(Duration(days: 3)),
      account: "BRI",
      isIncome: false,
      items: [
        TransactionItem(item: "Bakwan Jagung", amount: 10000.0),
        TransactionItem(item: "Bebek Goreng H.Slame(Asli)", amount: 5000.0),
      ],
      note: "Catatan",
    ),
  ];

  // Pages for bottom navigation bar
  final pages = [
    const Home(),
    const RekeningView(),
    const RekapView(),
    const RiwayatView(),
  ];
  // Index for navigation over pages
  final currentIndex = 0.obs;

  final transactions = <Transaction>[].obs;

  // Total saldo
  final totalBalance = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    transactions.assignAll(dummyTransactions);
  }

  void changeIndex(int index) {
    currentIndex.value = index;

    if (index == 1) {
      Get.lazyPut(() => RekeningController());
    } else if (index == 2) {
      Get.lazyPut(() => RekapController());
    } else if (index == 3) {
      Get.lazyPut(() => RiwayatController());
    }
  }
}
