import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/item_input_model.dart';
import 'package:flutter_application_1/app/data/models/item_transaksi_model.dart';
import 'package:flutter_application_1/app/data/models/rekening_model.dart';
import 'package:flutter_application_1/app/data/services/transaction_service.dart';
import 'package:flutter_application_1/app/modules/rekening/controllers/rekening_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahTransaksiController extends GetxController {
  final totalColumn = 1.obs;

  var selectedAccount = ''.obs;
  var rekeningList = <RekeningModel>[].obs;

  final itemInputs = <ItemInput>[ItemInput()].obs;

  // Form key
  final incomeFormKey = GlobalKey<FormState>();
  final expenseFormKey = GlobalKey<FormState>();

  // Transaction name text controller
  final incomeTransactionNameController = TextEditingController();
  final expenseTransactionNameController = TextEditingController();

  // Note text controller
  final incomeNoteController = TextEditingController();
  final expenseNoteController = TextEditingController();

  final TransactionService _transactionService = TransactionService();

  @override
  void onInit() {
    super.onInit();
    getAccounts();

    // Parsing data hasil scan dari Get.arguments
    final arguments = Get.arguments;
    if (arguments != null && arguments['data'] != null) {
      final hasilList = arguments['data'];
      loadScannedItems(
        hasilList,
        isIncome: false, // atau true, tergantung jenis transaksi
      );
    }
  }

  // Ambil data hasil OCR scan dan masukkan ke dalam itemInputs
  void loadScannedItems(List<dynamic> hasilList, {bool isIncome = false}) {
    itemInputs.clear();

    for (var item in hasilList) {
      final nama = item['nama'] ?? '';
      final harga = item['harga']?.toString() ?? '0';

      final itemInput = ItemInput();

      if (isIncome) {
        itemInput.incomeNameController.text = nama;
        itemInput.incomePriceController.text = harga;
      } else {
        itemInput.expenseNameController.text = nama;
        itemInput.expensePriceController.text = harga;
      }

      itemInputs.add(itemInput);
    }
  }

  Future<void> getAccounts() async {
    final rekeningController = Get.put(RekeningController());

    await rekeningController.getAccounts();

    rekeningList.assignAll(rekeningController.rekeningList);

    if (rekeningList.isNotEmpty) {
      selectedAccount.value = rekeningList.first.name;
    }
  }

  void addItem() {
    itemInputs.add(ItemInput());
  }

  void removeItem(int index) {
    if (itemInputs.length > 1) {
      itemInputs.removeAt(index);
    }
  }

  Future<void> addTransaction(bool income) async {
    final isFormValid =
        income
            ? incomeFormKey.currentState!.validate()
            : expenseFormKey.currentState!.validate();
    if (!isFormValid) return;

    final items =
        itemInputs.map((input) {
          final name =
              income
                  ? input.incomeNameController.text
                  : input.expenseNameController.text;
          final priceText =
              income
                  ? input.incomePriceController.text
                  : input.expensePriceController.text;
          final price =
              double.tryParse(
                priceText.replaceAll(',', '').replaceAll('.', ''),
              ) ??
              0.0;

          return TransactionItem(item: name, amount: price);
        }).toList();

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    final result = await _transactionService.addTransaction(
      token: token,
      name:
          income
              ? incomeTransactionNameController.text
              : expenseTransactionNameController.text,
      type: income ? "income" : "expense",
      items: items,
      account: selectedAccount.value,
      note: income ? incomeNoteController.text : expenseNoteController.text,
    );

    if (result['success']) {
      Get.defaultDialog(
        title: "Success",
        content: Column(
          children: [
            Image.asset('assets/images/checked.png', height: 100, width: 100),
            const SizedBox(height: 10),
            const Text('Berhasil menambahkan transaksi'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.offAllNamed('/home'),
            child: const Text('OK'),
          ),
        ],
      );
    } else {
      Get.snackbar('Error', result['message'], backgroundColor: Colors.red);
    }
  }
}
