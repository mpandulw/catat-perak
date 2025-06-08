import 'package:get/get.dart';

import '../controllers/edit_rekening_controller.dart';

class EditRekeningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditRekeningController>(
      () => EditRekeningController(),
    );
  }
}
