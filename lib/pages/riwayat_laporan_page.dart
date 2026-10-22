import 'package:flutter/material.dart';

class RiwayatLaporanPage extends StatelessWidget {
  const RiwayatLaporanPage({super.key});

  static const List<Map<String, String>>
      _laporan = [
    {
      'judul': 'Lampu jalan mati',
      'tanggal': '20 September 2026',
      'status': 'Selesai',
    },
    {
      'judul': 'Halte perlu dibersihkan',
      'tanggal': '17 September 2026',
      'status': 'Diproses',
    },
    {
      'judul': 'Jalan berlubang',
      'tanggal': '12 September 2026',
      'status': 'Diproses',
    },
  ];

  // =========================
  // AKSI
  // =========================

  void _aksi(
    BuildContext context,
    String pesan,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
      ),
    );
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Laporan',
        ),
      ),

      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          100,
        ),

        itemCount: _laporan.length,

        separatorBuilder:
            (context, index) =>
                const SizedBox(height: 10),

        itemBuilder: (context, index) {
          final laporan = _laporan[index];

          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(
                  Icons.report_problem_outlined,
                ),
              ),

              title: Text(
                laporan['judul']!,
              ),

              subtitle: Text(
                '${laporan['tanggal']} '
                '• ${laporan['status']}',
              ),

              trailing: const Icon(
                Icons.chevron_right,
              ),
            ),
          );
        },
      ),

      // =========================
      // FLOATING ACTION BUTTON
      // =========================

      floatingActionButtonLocation:
          FloatingActionButtonLocation
              .centerDocked,

      floatingActionButton:
          FloatingActionButton(
        tooltip: 'Buat laporan',

        onPressed: () {
          _aksi(
            context,
            'Form laporan baru dibuka.',
          );
        },

        child: const Icon(
          Icons.add,
        ),
      ),

      // =========================
      // BOTTOM APP BAR
      // =========================

      bottomNavigationBar: BottomAppBar(
        shape:
            const CircularNotchedRectangle(),

        notchMargin: 8,

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround,

          children: [
            IconButton(
              tooltip: 'Semua laporan',

              onPressed: () {
                _aksi(
                  context,
                  'Menampilkan semua laporan.',
                );
              },

              icon: const Icon(
                Icons.list_alt_outlined,
              ),
            ),

            const SizedBox(width: 48),

            IconButton(
              tooltip: 'Filter laporan',

              onPressed: () {
                _aksi(
                  context,
                  'Filter laporan dipilih.',
                );
              },

              icon: const Icon(
                Icons.filter_list_outlined,
              ),
            ),

            IconButton(
              tooltip: 'Notifikasi',

              onPressed: () {
                _aksi(
                  context,
                  'Notifikasi laporan dibuka.',
                );
              },

              icon: const Icon(
                Icons.notifications_none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}