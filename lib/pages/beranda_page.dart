import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  static const List<Map<String, dynamic>> _pilar = [
    {
      'nama': 'Smart Governance',
      'ikon': Icons.account_balance_outlined,
    },
    {
      'nama': 'Smart Branding',
      'ikon': Icons.campaign_outlined,
    },
    {
      'nama': 'Smart Economy',
      'ikon': Icons.trending_up_outlined,
    },
    {
      'nama': 'Smart Living',
      'ikon': Icons.home_work_outlined,
    },
    {
      'nama': 'Smart Society',
      'ikon': Icons.groups_outlined,
    },
    {
      'nama': 'Smart Environment',
      'ikon': Icons.eco_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final jumlahKolom = constraints.maxWidth >= 900 ? 3 : 2;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang di Nusantara Cerdas Mobile',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Akses layanan publik dan informasi Smart City dalam satu aplikasi.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              Text(
                'Enam Pilar Smart City',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _pilar.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: jumlahKolom,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final pilar = _pilar[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            pilar['ikon'] as IconData,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            pilar['nama'] as String,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
