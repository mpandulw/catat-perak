import 'package:get/get.dart';

import '../modules/daftar/bindings/daftar_binding.dart';
import '../modules/daftar/views/daftar_view.dart';
import '../modules/detail_rekening/bindings/detail_rekening_binding.dart';
import '../modules/detail_rekening/views/detail_rekening_view.dart';
import '../modules/edit_rekening/bindings/edit_rekening_binding.dart';
import '../modules/edit_rekening/views/edit_rekening_view.dart';
import '../modules/edit_transaksi/bindings/edit_transaksi_binding.dart';
import '../modules/edit_transaksi/views/edit_transaksi_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/info_app/bindings/info_app_binding.dart';
import '../modules/info_app/views/info_app_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/pengaturan/bindings/pengaturan_binding.dart';
import '../modules/pengaturan/views/pengaturan_view.dart';
import '../modules/rekap/bindings/rekap_binding.dart';
import '../modules/rekap/views/rekap_view.dart';
import '../modules/rekening/bindings/rekening_binding.dart';
import '../modules/rekening/views/rekening_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/riwayat/bindings/riwayat_binding.dart';
import '../modules/riwayat/views/riwayat_view.dart';
import '../modules/scan/bindings/scan_binding.dart';
import '../modules/scan/views/scan_view.dart';
import '../modules/tambah_rekening/bindings/tambah_rekening_binding.dart';
import '../modules/tambah_rekening/views/tambah_rekening_view.dart';
import '../modules/tambah_transaksi/bindings/tambah_transaksi_binding.dart';
import '../modules/tambah_transaksi/views/tambah_transaksi_view.dart';
import '../modules/visualisasi_transaksi/bindings/visualisasi_transaksi_binding.dart';
import '../modules/visualisasi_transaksi/views/visualisasi_transaksi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REKENING,
      page: () => const RekeningView(),
      binding: RekeningBinding(),
    ),
    GetPage(
      name: _Paths.REKAP,
      page: () => const RekapView(),
      binding: RekapBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => const RiwayatView(),
      binding: RiwayatBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN,
      page: () => const PengaturanView(),
      binding: PengaturanBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_TRANSAKSI,
      page: () => const TambahTransaksiView(),
      binding: TambahTransaksiBinding(),
      children: [
        GetPage(
          name: _Paths.TAMBAH_TRANSAKSI,
          page: () => const TambahTransaksiView(),
          binding: TambahTransaksiBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SCAN,
      page: () => const ScanView(),
      binding: ScanBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_REKENING,
      page: () => const TambahRekeningView(),
      binding: TambahRekeningBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_REKENING,
      page: () => const DetailRekeningView(),
      binding: DetailRekeningBinding(),
    ),
    GetPage(
      name: _Paths.INFO_APP,
      page: () => const InfoAppView(),
      binding: InfoAppBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR,
      page: () => const DaftarView(),
      binding: DaftarBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_REKENING,
      page: () => const EditRekeningView(),
      binding: EditRekeningBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_TRANSAKSI,
      page: () => const EditTransaksiView(),
      binding: EditTransaksiBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VISUALISASI_TRANSAKSI,
      page: () => const VisualisasiTransaksiView(),
      binding: VisualisasiTransaksiBinding(),
    ),
  ];
}
