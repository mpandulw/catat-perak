import 'package:get/get.dart';

import '../controllers/tambah_rekening_controller.dart';

class TambahRekeningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahRekeningController>(
      () => TambahRekeningController(),
    );
  }
}
