import 'package:get/get.dart';

class PengaturanController extends GetxController {
  final isDarkMode = false.obs;

  void changeTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  void doLogout() {}
}
