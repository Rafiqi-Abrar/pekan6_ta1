import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../navigation/app_routes.dart';
import 'layanan_page.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================
          // IDENTITAS WARGA
          // =========================
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    child: Icon(Icons.person, size: 34),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rafiqi Abrar',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        const Text('ID Warga: NC-2026-001'),
                        const Text('Kecamatan Nusantara Tengah'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // =========================
          // PENGATURAN TEMA (MODE TERANG / GELAP)
          // =========================
          Card(
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, mode) {
                final isDark = mode == ThemeMode.dark;
                return SwitchListTile(
                  secondary: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    color: isDark ? Colors.amber : Colors.indigo,
                  ),
                  title: const Text(
                    'Mode Gelap',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    isDark ? 'Tema gelap aktif' : 'Tema terang aktif',
                  ),
                  value: isDark,
                  onChanged: (val) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // =========================
          // KERANJANG PENGAJUAN LAYANAN
          // =========================
          BlocBuilder<PengajuanCubit, List<String>>(
            builder: (context, daftarPengajuan) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.shopping_basket_outlined,
                            color: Colors.indigo,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Keranjang Pengajuan',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Chip(
                            label: Text('${daftarPengajuan.length} Layanan'),
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (daftarPengajuan.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Belum ada layanan yang diajukan. Buka menu Layanan dan pilih "Ajukan Permohonan" untuk menambahkan ke keranjang.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        )
                      else ...[
                        const Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: daftarPengajuan.length,
                          itemBuilder: (context, index) {
                            final namaLayanan = daftarPengajuan[index];
                            return ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              leading: const CircleAvatar(
                                radius: 14,
                                child: Icon(Icons.check, size: 16),
                              ),
                              title: Text(namaLayanan),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                                tooltip: 'Batalkan layanan ini',
                                onPressed: () {
                                  context
                                      .read<PengajuanCubit>()
                                      .hapusPengajuan(index);
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () {
                              final total = daftarPengajuan.length;
                              context.read<PengajuanCubit>().bersihkanSemua();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '$total permohonan layanan berhasil dikirim ke dinas terkait!',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.send_rounded),
                            label: const Text(
                              'Kirim Semua Permohonan ke Dinas',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // =========================
          // LAYANAN FAVORIT
          // =========================
          BlocBuilder<FavoritCubit, Set<String>>(
            builder: (context, daftarFavorit) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Layanan Favorit',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Text(
                            '${daftarFavorit.length} favorit',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (daftarFavorit.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Belum ada layanan yang ditandai sebagai favorit. Klik ikon bintang pada menu Layanan untuk menambahkannya ke sini.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                        )
                      else ...[
                        const Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: daftarFavorit.length,
                          itemBuilder: (context, index) {
                            final nama = daftarFavorit.elementAt(index);
                            final layanan = LayananPage.cariLayanan(nama);

                            return ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              leading: const CircleAvatar(
                                radius: 16,
                                child: Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Colors.amber,
                                ),
                              ),
                              title: Text(
                                nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle:
                                  layanan != null ? Text(layanan.dinas) : null,
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                tooltip: 'Hapus dari favorit',
                                onPressed: () {
                                  context
                                      .read<FavoritCubit>()
                                      .batalTandai(nama);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '$nama dihapus dari favorit',
                                      ),
                                      duration:
                                          const Duration(milliseconds: 900),
                                    ),
                                  );
                                },
                              ),
                              onTap: layanan != null
                                  ? () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.detailLayanan,
                                        arguments: layanan,
                                      );
                                    }
                                  : null,
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // =========================
          // RINGKASAN LAPORAN
          // =========================
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.assignment_turned_in_outlined),
                  title: Text('3 laporan aktif'),
                  subtitle: Text('Laporan yang sedang diproses petugas'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.check_circle_outline),
                  title: Text('8 laporan selesai'),
                  subtitle: Text('Riwayat laporan yang sudah ditangani'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // =========================
          // RIWAYAT LAPORAN
          // =========================
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.riwayatLaporan,
                );
              },
              icon: const Icon(Icons.history),
              label: const Text('Buka Riwayat Laporan'),
            ),
          ),
        ],
      ),
    );
  }
}