import 'package:get/get.dart';

class EditProfilController extends GetxController {
  final currentPasswordObsecure = true.obs;
  final newPasswordObsecure = true.obs;
  final confirmationPasswordObsecure = true.obs;

  void toggleCurrentPass() {
    currentPasswordObsecure.value = !currentPasswordObsecure.value;
  }

  void toggleNewPass() {
    newPasswordObsecure.value = !newPasswordObsecure.value;
  }
}
