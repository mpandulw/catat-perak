import 'package:flutter_application_1/app/data/services/transaction_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/controllers/home_controller.dart';

class RekapController extends GetxController {
  final homeController = Get.find<HomeController>();

  var transactions = [].obs;
  var groupedTransactions = [].obs;
  var maxAmount = 0.0.obs;

  final TransactionService _transactionService = TransactionService();

  final isLoading = false.obs;
  final totalIncome = 0.0.obs;
  final totalExpense = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
    getSummary();
  }

  void loadTransactions() {
    // Load transaksi dari HomeController
    transactions.assignAll(homeController.transactionsList);

    // Group berdasarkan tanggal
    final grouped = <Map<String, dynamic>>[];

    for (var transaction in transactions) {
      final date = '${transaction.date.day}/${transaction.date.month}';
      final amount = transaction.totalPrice.toDouble(); // 👈 Ubah int ke double

      final existing = grouped.firstWhereOrNull((g) => g['date'] == date);
      if (existing != null) {
        existing['amount'] += amount;
      } else {
        grouped.add({'date': date, 'amount': amount});
      }
    }

    groupedTransactions.assignAll(grouped);

    // Hitung max untuk scale chart
    if (grouped.isNotEmpty) {
      maxAmount.value = grouped
          .map((e) => e['amount'] as double)
          .reduce((a, b) => a > b ? a : b);
    }
  }

  Future<void> getSummary() async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await _transactionService.getSummary(token!);
      totalIncome.value = response['income'];
      totalExpense.value = response['expense'];

      isLoading.value = false;
    } catch (e) {
      Get.snackbar("Error", "Error : $e");
    }
  }
}
