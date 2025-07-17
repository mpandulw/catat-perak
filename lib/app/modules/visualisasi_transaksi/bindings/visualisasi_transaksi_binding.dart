import 'package:get/get.dart';

import '../controllers/visualisasi_transaksi_controller.dart';

class VisualisasiTransaksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisualisasiTransaksiController>(
      () => VisualisasiTransaksiController(),
    );
  }
}
