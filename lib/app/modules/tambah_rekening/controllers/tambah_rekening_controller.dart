import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/rekening_model.dart';
import 'package:flutter_application_1/app/data/services/account_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahRekeningController extends GetxController {
  var rekeningList = <RekeningModel>[].obs;
  var name = ''.obs;
  var balance = 0.obs;

  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final accountNameController = TextEditingController();
  final accountBalanceController = TextEditingController();

  final AccountServices _accountServices = AccountServices();

  final prefs = SharedPreferences.getInstance();

  Future<void> addRekening() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await _accountServices.addAccount(
        accountNameController.text,
        int.tryParse(accountBalanceController.text) ?? 0,
        token ?? '',
      );

      isLoading.value = false;

      if (response['success'] == true) {
        Get.snackbar(
          'Success',
          'Berhasil menambahkan rekening baru!',
          backgroundColor: Colors.white,
        );
        Get.offAllNamed('/rekening');
      } else if (response["success"] == false) {
        Get.snackbar(
          'Failed',
          response['message'],
          backgroundColor: Colors.white,
        );
      } else {
        Get.snackbar(
          'Failed',
          response['message'],
          backgroundColor: Colors.white,
        );
      }
    }
  }

  void clearForm() {
    name.value = '';
    balance.value = 0;
  }

  // void updateValue(String value) {
  //   balance.value = value; //int.tryParse(value) ?? 0;
  // }
}
