import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/visualisasi_transaksi_controller.dart';

class VisualisasiTransaksiView extends GetView<VisualisasiTransaksiController> {
  const VisualisasiTransaksiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualisasi Transaksi'),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: controller.webViewController),
    );
  }
}
