import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengaturanController extends GetxController {
  final isDarkMode = false.obs;

  final username = ''.obs;
  final email = ''.obs;

  Future<void> getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString("username")!;
    email.value = prefs.getString("email")!;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserCredentials();
  }

  void changeTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  Future<void> doLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('username');
    prefs.remove('password');
    prefs.remove('email');
    Get.offNamed('/login');
  }
}
