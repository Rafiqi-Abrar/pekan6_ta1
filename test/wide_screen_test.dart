import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nusantara_cerdas_nav_nim/main.dart';

void main() {
  testWidgets('Tampilan layar lebar (NavigationRail) dengan Badge dan Favorit', (WidgetTester tester) async {
    // Ukuran layar lebar (>= 600 px)
    tester.view.physicalSize = const Size(1000, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const NusantaraCerdasApp());
    await tester.pumpAndSettle();

    // Verifikasi keberadaan NavigationRail
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    // Buka menu Layanan via NavigationRail
    await tester.tap(find.byIcon(Icons.miscellaneous_services_outlined));
    await tester.pumpAndSettle();

    // Pindah ke tab Kesehatan
    await tester.tap(find.text('Kesehatan'));
    await tester.pumpAndSettle();

    // Buka detail permohonan
    await tester.tap(find.text('Pendaftaran Puskesmas'));
    await tester.pumpAndSettle();

    // Ajukan permohonan
    await tester.tap(find.text('Ajukan Permohonan'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Sedang mengirim...'), findsOneWidget);

    await tester.pumpAndSettle(const Duration(milliseconds: 1000));

    // Badge 1 harus tampak pada ikon Warga di NavigationRail
    expect(find.text('1'), findsWidgets);

    // Pindah ke Warga
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    expect(find.text('Pendaftaran Puskesmas'), findsOneWidget);
    expect(find.text('1 Layanan'), findsOneWidget);
  });
}
