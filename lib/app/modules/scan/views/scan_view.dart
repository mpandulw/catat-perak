import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/scan_controller.dart';

class ScanView extends GetView<ScanController> {
  const ScanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 150,
              height: 270,
              decoration: BoxDecoration(border: Border.all()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {}, child: const Text("Camera")),
                TextButton(onPressed: () {}, child: const Text("Gallery")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
