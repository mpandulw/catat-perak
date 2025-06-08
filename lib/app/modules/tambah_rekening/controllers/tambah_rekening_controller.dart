import 'package:flutter_application_1/app/data/models/rekening_model.dart';
import 'package:get/get.dart';

class TambahRekeningController extends GetxController {
  var rekeningList = <RekeningModel>[].obs;
  var name = ''.obs;
  var balance = 0.obs;

  Future<void> addRekening(RekeningModel rekening) async {}

  void clearForm() {
    name.value = '';
    balance.value = 0;
  }

  // void updateValue(String value) {
  //   balance.value = value; //int.tryParse(value) ?? 0;
  // }
}
