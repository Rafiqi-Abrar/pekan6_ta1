import 'package:flutter/material.dart';

import '../pages/detail_layanan_page.dart';
import '../pages/pengaturan_kota_page.dart';
import '../pages/riwayat_laporan_page.dart';
import '../pages/route_tidak_dikenal_page.dart';
import '../pages/tentang_aplikasi.dart';
import '../pages/layanan_page.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/beranda';
  static const String layanan = '/layanan';
  static const String warga = '/warga';
  static const String pengaturanKota = '/pengaturan-kota';
  static const String tentangAplikasi = '/tentang-aplikasi';
  static const String riwayatLaporan = '/riwayat-laporan';
  static const String detailLayanan = '/detail-layanan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    switch (settings.name) {
      case detailLayanan:
        final args = settings.arguments;

        if (args is DataLayanan) {
          return MaterialPageRoute<String>(
            settings: settings,
            builder: (context) => DetailLayananPage(
              layanan: args,
            ),
          );
        }

        return MaterialPageRoute(
          builder: (context) => const RouteTidakDikenalPage(
            routeName: '$detailLayanan (arguments tidak valid)',
          ),
        );

      case pengaturanKota:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const PengaturanKotaPage(),
        );

      case tentangAplikasi:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const TentangAplikasiPage(),
        );

      case riwayatLaporan:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const RiwayatLaporanPage(),
        );

      default:
        return null;
    }
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => RouteTidakDikenalPage(
        routeName: settings.name ?? '(kosong)',
      ),
    );
  }
}
