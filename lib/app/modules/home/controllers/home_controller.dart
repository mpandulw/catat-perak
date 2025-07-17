import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/models/rekening_model.dart';
import 'package:flutter_application_1/app/data/models/transaksi_model.dart';
import 'package:flutter_application_1/app/data/services/transaction_service.dart';

import 'package:flutter_application_1/app/modules/home/views/home_view.dart';
import 'package:flutter_application_1/app/modules/rekap/controllers/rekap_controller.dart';
import 'package:flutter_application_1/app/modules/rekap/views/rekap_view.dart';
import 'package:flutter_application_1/app/modules/rekening/controllers/rekening_controller.dart';
import 'package:flutter_application_1/app/modules/rekening/views/rekening_view.dart';
import 'package:flutter_application_1/app/modules/riwayat/controllers/riwayat_controller.dart';
import 'package:flutter_application_1/app/modules/riwayat/views/riwayat_view.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var currentIndexMarquee = 0.obs;
  // late Timer _timer;
  final isLoading = false.obs;

  final formatter = NumberFormat("#,###", "id_ID");

  final rekeningList = <RekeningModel>[].obs;

  // Pages for bottom navigation bar
  final pages = [
    const Home(),
    const RekeningView(),
    const RekapView(),
    const RiwayatView(),
  ];
  // Index for navigation over pages
  final currentIndex = 0.obs;

  final transactionsList = <Transaction>[].obs;

  // Total saldo
  final totalBalance = 0.obs;

  final TransactionService _transactionService = TransactionService();

  @override
  void onInit() {
    super.onInit();
    getTransaction();
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (currentIndexMarquee.value < rekeningList.length - 1) {
        currentIndexMarquee.value++;
      } else {
        currentIndexMarquee.value = 0;
      }
    });

    final rekeningController = Get.put(RekeningController());
    ever(rekeningController.rekeningList, (list) {
      rekeningList.assignAll(list);
    });
  }

  Future<void> getTransaction() async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token')!;

      final response = await _transactionService.getTransaction(token);
      transactionsList.value =
          response
              .map((transaction) => Transaction.fromJson(transaction))
              .toList();

      isLoading.value = false;
    } catch (e) {
      Get.snackbar("Error", "Error : $e");
    }
  }

  Future<void> delTransaction(String id) async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      final response = await _transactionService.delTransaction(token!, id);
      await getTransaction();

      isLoading.value = false;

      if (response['success'] == true) {
        Get.back();
        Get.snackbar(
          "Success",
          response['message'],
          backgroundColor: Colors.white,
        );
      } else {
        Get.snackbar(
          "Failed",
          response['message'],
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      Get.snackbar("Failed", "Error : $e");
    }
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
