import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisualisasiTransaksiController extends GetxController {
  late final WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (String url) {
                print('Halaman mulai dimuat: $url');
              },
              onPageFinished: (String url) {
                print('Halaman selesai dimuat: $url');
              },
              onNavigationRequest: (NavigationRequest request) {
                print('Permintaan navigasi: ${request.url}');
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(
            Uri.parse(
              'https://tugasbigdatapertemuan9-rdexxl82r6dnrvc2ywfsmx.streamlit.app/',
            ),
          ); // Ganti dengan URL kamu
  }
}
