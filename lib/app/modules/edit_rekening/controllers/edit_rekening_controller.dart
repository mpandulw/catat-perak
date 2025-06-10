import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/services/account_services.dart';
import 'package:flutter_application_1/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_application_1/app/modules/rekening/controllers/rekening_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditRekeningController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final accountNameController = TextEditingController();
  final accountBalanceController = TextEditingController();
  final isLoading = false.obs;
  late String id;
  final AccountServices _accountServices = AccountServices();

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['id'];
    accountNameController.text = Get.arguments['name'];
    accountBalanceController.text = Get.arguments['balance'].toString();
  }

  Future<void> updateAccount() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final balance = int.tryParse(accountBalanceController.text);

      final response = await _accountServices.updateAccount(
        id,
        token!,
        accountNameController.text,
        balance!,
      );

      isLoading.value = false;

      if (response['success'] == true) {
        // Ganti tab ke rekening
        final rekeningController = Get.find<RekeningController>();
        rekeningController.getAccounts(); // manually trigger refresh

        final homeController = Get.find<HomeController>();
        homeController.changeIndex(1);
        Get.until((route) => Get.currentRoute == '/home');

        Get.snackbar(
          'Success',
          response['message'],
          backgroundColor: Colors.white,
        );
      } else {
        Get.snackbar(
          'Success',
          response['message'],
          backgroundColor: Colors.white,
        );
      }
    }
  }
}
