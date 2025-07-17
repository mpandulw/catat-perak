import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
            Obx(
              () => Container(
                width: 150,
                height: 270,
                decoration: BoxDecoration(border: Border.all()),
                child:
                    controller.selectedImage.value != null
                        ? Image.file(
                          controller.selectedImage.value!,
                          fit: BoxFit.fill,
                        )
                        : Center(child: const Text('No Image')),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => controller.pickImage(ImageSource.camera),
                  child: const Text("Camera"),
                ),
                TextButton(
                  onPressed: () => controller.pickImage(ImageSource.gallery),
                  child: const Text("Gallery"),
                ),
              ],
            ),
            TextButton(
              onPressed: () => controller.receiptScan(),
              child: const Text("Cihuy"),
            ),
          ],
        ),
      ),
    );
  }
}
