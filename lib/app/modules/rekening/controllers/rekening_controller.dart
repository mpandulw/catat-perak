import 'package:flutter_application_1/app/data/models/rekening_model.dart';
import 'package:get/get.dart';

class RekeningController extends GetxController {
  // Dummy data
  final List<RekeningModel> dummyAccount = [
    RekeningModel(name: "BRI", balance: 100000),
    RekeningModel(name: "BCA", balance: 100000),
    RekeningModel(name: "Saldo Tunai", balance: 250000),
  ];

  var rekeningList = <RekeningModel>[].obs;

  void loadDummyData() {
    rekeningList.assignAll(dummyAccount);
  }

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }
}
