import 'package:flutter/material.dart';

class PengaturanKotaPage extends StatefulWidget {
  const PengaturanKotaPage({super.key});

  @override
  State<PengaturanKotaPage> createState() =>
      _PengaturanKotaPageState();
}

class _PengaturanKotaPageState
    extends State<PengaturanKotaPage> {
  bool notifikasi = true;
  bool lokasi = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan Kota',
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          SwitchListTile(
            value: notifikasi,

            title: const Text(
              'Notifikasi layanan',
            ),

            subtitle: const Text(
              'Terima pembaruan status '
              'layanan dan laporan',
            ),

            onChanged: (nilai) {
              setState(() {
                notifikasi = nilai;
              });
            },
          ),

          const Divider(),

          SwitchListTile(
            value: lokasi,

            title: const Text(
              'Gunakan lokasi kota',
            ),

            subtitle: const Text(
              'Sesuaikan informasi transportasi '
              'dan layanan',
            ),

            onChanged: (nilai) {
              setState(() {
                lokasi = nilai;
              });
            },
          ),

          const Divider(),

          const ListTile(
            leading: Icon(
              Icons.location_on_outlined,
            ),

            title: Text(
              'Kota aktif',
            ),

            subtitle: Text(
              'Nusantara',
            ),
          ),
        ],
      ),
    );
  }
}