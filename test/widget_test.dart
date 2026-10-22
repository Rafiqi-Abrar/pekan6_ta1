import 'package:flutter_test/flutter_test.dart';
import 'package:nusantara_cerdas_nav_nim/main.dart';

void main() {
  testWidgets('Aplikasi Nusantara Cerdas memuat halaman beranda', (WidgetTester tester) async {
    await tester.pumpWidget(const NusantaraCerdasApp());
    await tester.pumpAndSettle();

    expect(find.text('Selamat Datang di Nusantara Cerdas Mobile'), findsOneWidget);
  });
}
