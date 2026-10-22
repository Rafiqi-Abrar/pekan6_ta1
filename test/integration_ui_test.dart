import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nusantara_cerdas_nav_nim/main.dart';

void main() {
  testWidgets('Integrasi Favorit, Keranjang Pengajuan, Badge, dan Mode Gelap', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const NusantaraCerdasApp());
    await tester.pumpAndSettle();

    // 1. Pindah ke tab Layanan via icon navigasi
    await tester.tap(find.byIcon(Icons.miscellaneous_services_outlined));
    await tester.pumpAndSettle();

    // 2. Tandai layanan 'Izin Usaha Mikro' sebagai favorit via ikon bintang
    final starButtons = find.byTooltip('Tandai sebagai favorit');
    expect(starButtons, findsWidgets);
    await tester.tap(starButtons.first);
    await tester.pumpAndSettle();

    // Ikon sekarang harus menjadi batal tanda favorit
    expect(find.byTooltip('Batalkan tanda favorit'), findsOneWidget);

    // 3. Buka detail layanan 'Izin Usaha Mikro' dengan mengetuk kartu/teks
    await tester.tap(find.text('Izin Usaha Mikro'));
    await tester.pumpAndSettle();
    expect(find.text('Rincian Layanan'), findsOneWidget);

    // 4. Tekan tombol Ajukan Permohonan
    await tester.tap(find.text('Ajukan Permohonan'));
    // Selama proses 900ms, tombol menampilkan 'Sedang mengirim...'
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Sedang mengirim...'), findsOneWidget);

    // Tunggu selesai kirim dan pop kembali ke halaman layanan
    await tester.pumpAndSettle(const Duration(milliseconds: 1000));
    expect(find.text('Rincian Layanan'), findsNothing);

    // 5. Periksa apakah badge pada ikon Warga bernilai 1
    expect(find.text('1'), findsWidgets);

    // 6. Pindah ke halaman Warga
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    // Pastikan Layanan Favorit tampil di halaman Warga
    expect(find.text('Layanan Favorit'), findsOneWidget);
    expect(find.text('1 favorit'), findsOneWidget);
    expect(find.text('Izin Usaha Mikro'), findsWidgets);

    // Pastikan Keranjang Pengajuan menampilkan layanan yang baru diajukan
    expect(find.text('Keranjang Pengajuan'), findsOneWidget);
    expect(find.text('Kirim Semua Permohonan ke Dinas'), findsOneWidget);

    // 7. Uji tombol kirim semua permohonan
    await tester.tap(find.text('Kirim Semua Permohonan ke Dinas'));
    await tester.pumpAndSettle();

    // Keranjang sekarang kosong
    expect(
      find.text(
        'Belum ada layanan yang diajukan. Buka menu Layanan dan pilih "Ajukan Permohonan" untuk menambahkan ke keranjang.',
      ),
      findsOneWidget,
    );

    // 8. Uji beralih ke Mode Gelap
    expect(find.text('Mode Gelap'), findsOneWidget);
    expect(find.text('Tema terang aktif'), findsOneWidget);
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(find.text('Tema gelap aktif'), findsOneWidget);
  });
}
