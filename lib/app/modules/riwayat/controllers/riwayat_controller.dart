import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/transaksi_model.dart';
import 'package:flutter_application_1/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class RiwayatController extends GetxController {
  final _homeController = Get.find<HomeController>();

  final transactions = <Transaction>[].obs;
  final selectedCategory = "Semua".obs;
  final selectedDateRange = Rxn<DateTimeRange>();

  List<Transaction> get filteredTransactions {
    return transactions.where((tx) {
      final isIncome = tx.type == 'income';
      final isExpense = tx.type == 'expense';
      final date = tx.date;

      // Filter kategori
      if (selectedCategory.value == "Pemasukan" && !isIncome) return false;
      if (selectedCategory.value == "Pengeluaran" && !isExpense) return false;

      // Filter tanggal
      if (selectedDateRange.value != null) {
        final range = selectedDateRange.value!;
        if (date.isBefore(range.start) || date.isAfter(range.end)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  void setDateRange(DateTimeRange? range) {
    selectedDateRange.value = range;
  }

  void getTransactions() {
    transactions.assignAll(_homeController.transactionsList);
    // Debug log
    for (var tx in transactions) {
      print(
        "[TRANSAKSI] ${tx.title} - ${tx.type} - ${tx.totalPrice} - ${tx.date.toIso8601String()}",
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    getTransactions();
  }
}
