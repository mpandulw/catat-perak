import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/rekening_model.dart';
import 'package:flutter_application_1/app/data/services/account_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class RekeningController extends GetxController {
  final AccountServices _accountServices = AccountServices();
  final rekeningList = <RekeningModel>[].obs;

  final isLoading = false.obs;

  final formatter = NumberFormat("#.###", "id_ID");

  Future<void> getAccounts() async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final response = await _accountServices.getAccount(token!);
      rekeningList.value =
          response.map((item) => RekeningModel.fromJson(item)).toList();

      isLoading.value = false;
    } catch (e) {
      Get.snackbar("Something wrong", "Error : $e");
    }
  }

  Future<void> delAccount(String id) async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await _accountServices.delAccount(id, token!);

      isLoading.value = false;

      if (response['success'] == true) {
        await getAccounts();
        Get.snackbar(
          "Success",
          response['message'],
          backgroundColor: Colors.white,
        );
      } else if (response['success'] == false) {
        Get.snackbar(
          "Failed",
          response['message'],
          backgroundColor: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Something Wrong",
        "Error : $e",
        backgroundColor: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAccounts();
  }
}
