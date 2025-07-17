import 'dart:io';

import 'package:flutter_application_1/app/data/services/transaction_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanController extends GetxController {
  final _service = TransactionService();

  final imagePicker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);
  final isLoading = false.obs;

  Future<void> pickImage(ImageSource source) async {
    final picked = await imagePicker.pickImage(source: source);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  Future<void> receiptScan() async {
    if (selectedImage.value != null) {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await _service.scanTransaction(
        selectedImage.value!,
        token!,
      );

      isLoading.value = false;

      if (response['success'] == true) {
        print(response['data']['hasil']);
        Get.toNamed(
          '/tambah-transaksi',
          arguments: {'data': response['data']['hasil']},
        );
      } else {
        Get.snackbar("Error", response['message']);
        print(response['message']);
      }
    }
  }
}
