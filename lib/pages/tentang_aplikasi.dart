import 'package:flutter/material.dart';

class TentangAplikasiPage
    extends StatelessWidget {
  const TentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tentang Aplikasi',
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          const Icon(
            Icons.location_city,
            size: 72,
          ),

          const SizedBox(height: 16),

          Text(
            'Nusantara Cerdas Mobile',
            textAlign: TextAlign.center,

            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(
                  fontWeight:
                      FontWeight.bold,
                ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Purwarupa aplikasi layanan warga '
            'Smart City untuk memudahkan akses '
            'informasi, layanan publik, dan '
            'laporan warga.',

            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          const Card(
            child: ListTile(
              leading: Icon(
                Icons.code_outlined,
              ),

              title: Text(
                'Versi Purwarupa',
              ),

              subtitle: Text(
                '1.0.0',
              ),
            ),
          ),

          const SizedBox(height: 16),

          OutlinedButton.icon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/route-salah',
              );
            },

            icon: const Icon(
              Icons.warning_amber_outlined,
            ),

            label: const Text(
              'Uji Route Tidak Dikenal',
            ),
          ),
        ],
      ),
    );
  }
}