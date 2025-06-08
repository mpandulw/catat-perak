import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class RekapController extends GetxController {
  final homeController = Get.find<HomeController>();

  var transactions = [].obs;
  var groupedTransactions = [].obs;
  var maxAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  void loadTransactions() {
    // Load transaksi dari HomeController
    transactions.assignAll(homeController.transactions);

    // Group berdasarkan tanggal
    final grouped = <Map<String, dynamic>>[];

    for (var transaction in transactions) {
      final date = '${transaction.date.day}/${transaction.date.month}';
      final amount =
          transaction.items?.fold<double>(
            0,
            (previous, item) => previous + item.amount,
          ) ??
          0;

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
}
