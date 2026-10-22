import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../navigation/app_routes.dart';

class DataLayanan {
  final String nama;
  final String dinas;
  final String jamOperasional;
  final String keterangan;

  const DataLayanan({
    required this.nama,
    required this.dinas,
    required this.jamOperasional,
    required this.keterangan,
  });
}

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  // =========================
  // DATA PERIZINAN
  // =========================
  static const List<DataLayanan> _perizinan = [
    DataLayanan(
      nama: 'Izin Usaha Mikro',
      dinas: 'Dinas Penanaman Modal dan Pelayanan Terpadu',
      jamOperasional: 'Senin–Jumat, 08.00–15.00',
      keterangan: 'Pengajuan izin usaha mikro secara digital untuk warga kota.',
    ),
    DataLayanan(
      nama: 'Izin Mendirikan Bangunan',
      dinas: 'Dinas Cipta Karya dan Tata Ruang',
      jamOperasional: 'Senin–Jumat, 08.00–15.00',
      keterangan: 'Layanan permohonan persetujuan pembangunan dan bangunan.',
    ),
    DataLayanan(
      nama: 'Izin Reklame',
      dinas: 'Dinas Pelayanan Terpadu',
      jamOperasional: 'Senin–Jumat, 08.00–15.00',
      keterangan: 'Pengajuan izin pemasangan reklame pada wilayah kota.',
    ),
  ];

  // =========================
  // DATA KESEHATAN
  // =========================
  static const List<DataLayanan> _kesehatan = [
    DataLayanan(
      nama: 'Pendaftaran Puskesmas',
      dinas: 'Dinas Kesehatan Kota',
      jamOperasional: 'Senin–Sabtu, 07.30–14.00',
      keterangan: 'Pendaftaran kunjungan dan antrean layanan puskesmas.',
    ),
    DataLayanan(
      nama: 'Vaksinasi Warga',
      dinas: 'Dinas Kesehatan Kota',
      jamOperasional: 'Senin–Jumat, 08.00–14.00',
      keterangan: 'Informasi dan pendaftaran layanan vaksinasi warga.',
    ),
    DataLayanan(
      nama: 'Konsultasi Kesehatan',
      dinas: 'Dinas Kesehatan Kota',
      jamOperasional: 'Senin–Jumat, 09.00–15.00',
      keterangan: 'Konsultasi awal mengenai kebutuhan kesehatan masyarakat.',
    ),
  ];

  // =========================
  // DATA TRANSPORTASI
  // =========================
  static const List<DataLayanan> _transportasi = [
    DataLayanan(
      nama: 'Kartu Transportasi Kota',
      dinas: 'Dinas Perhubungan Kota',
      jamOperasional: 'Senin–Jumat, 08.00–16.00',
      keterangan: 'Pengajuan dan informasi kartu layanan transportasi publik.',
    ),
    DataLayanan(
      nama: 'Pengaduan Halte',
      dinas: 'Dinas Perhubungan Kota',
      jamOperasional: 'Setiap hari, 24 jam',
      keterangan: 'Pelaporan kondisi fasilitas halte dan sarana transportasi.',
    ),
    DataLayanan(
      nama: 'Informasi Rute Bus',
      dinas: 'Dinas Perhubungan Kota',
      jamOperasional: 'Setiap hari, 24 jam',
      keterangan: 'Informasi rute, titik pemberhentian, dan jadwal bus kota.',
    ),
  ];

  /// Menggabungkan seluruh layanan lintas bidang
  static List<DataLayanan> get semuaLayanan => [
        ..._perizinan,
        ..._kesehatan,
        ..._transportasi,
      ];

  static DataLayanan? cariLayanan(String nama) {
    try {
      return semuaLayanan.firstWhere((item) => item.nama == nama);
    } catch (_) {
      return null;
    }
  }

  // =========================
  // BUKA DETAIL
  // =========================
  Future<void> _bukaDetail(
    BuildContext context,
    DataLayanan layanan,
  ) async {
    final hasil = await Navigator.pushNamed<String>(
      context,
      AppRoutes.detailLayanan,
      arguments: layanan,
    );

    if (!context.mounted || hasil == null || hasil.isEmpty) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(hasil)),
    );
  }

  // =========================
  // DAFTAR LAYANAN
  // =========================
  Widget _daftar(
    BuildContext context,
    List<DataLayanan> data,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final layanan = data[index];

        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 8,
            ),
            leading: const CircleAvatar(
              child: Icon(Icons.article_outlined),
            ),
            title: Text(
              layanan.nama,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(layanan.keterangan),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocSelector<FavoritCubit, Set<String>, bool>(
                  selector: (state) => state.contains(layanan.nama),
                  builder: (context, isFavorit) {
                    return IconButton(
                      icon: Icon(
                        isFavorit ? Icons.star : Icons.star_border,
                        color: isFavorit ? Colors.amber : Colors.grey,
                      ),
                      tooltip: isFavorit
                          ? 'Batalkan tanda favorit'
                          : 'Tandai sebagai favorit',
                      onPressed: () {
                        final cubit = context.read<FavoritCubit>();
                        if (isFavorit) {
                          cubit.batalTandai(layanan.nama);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${layanan.nama} dihapus dari favorit',
                              ),
                              duration: const Duration(milliseconds: 900),
                            ),
                          );
                        } else {
                          cubit.tandai(layanan.nama);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${layanan.nama} ditandai sebagai favorit',
                              ),
                              duration: const Duration(milliseconds: 900),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {
              _bukaDetail(context, layanan);
            },
          ),
        );
      },
    );
  }

  // =========================
  // BUILD
  // =========================
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const Material(
            color: Colors.transparent,
            child: TabBar(
              isScrollable: false,
              tabs: [
                Tab(
                  text: 'Perizinan',
                  icon: Icon(Icons.assignment_outlined),
                ),
                Tab(
                  text: 'Kesehatan',
                  icon: Icon(Icons.health_and_safety_outlined),
                ),
                Tab(
                  text: 'Transportasi',
                  icon: Icon(Icons.directions_bus_outlined),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _daftar(context, _perizinan),
                _daftar(context, _kesehatan),
                _daftar(context, _transportasi),
              ],
            ),
          ),
        ],
      ),
    );
  }
}