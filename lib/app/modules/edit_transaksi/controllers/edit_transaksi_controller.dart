import 'package:get/get.dart';

class EditTransaksiController extends GetxController {
  final totalColumn = 1.obs;
  var accountList = ['BRI', 'BCA', 'Mandiri'].obs;
  var selectedAccount = 'BRI'.obs;

  void delColum() {
    if (totalColumn.value == 1) {
      Get.showSnackbar(GetSnackBar(message: "Error"));
    } else {
      totalColumn.value--;
    }
  }
}
