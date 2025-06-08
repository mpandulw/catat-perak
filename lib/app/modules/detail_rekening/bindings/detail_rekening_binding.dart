import 'package:get/get.dart';

import '../controllers/detail_rekening_controller.dart';

class DetailRekeningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailRekeningController>(
      () => DetailRekeningController(),
    );
  }
}
