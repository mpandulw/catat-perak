import 'package:get/get.dart';

class DetailRekeningController extends GetxController {
  // final formKey = GlobalKey<FormState>();
  // final accountNameController = TextEditingController();
  // final accountBalanceController = TextEditingController();
  late String id;
  late String accountName;
  late int accountBalance;

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['id'];
    accountName = Get.arguments['name'];
    accountBalance = Get.arguments['balance'];
  }
}
