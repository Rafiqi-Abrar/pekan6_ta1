import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import 'layanan_page.dart';

class DetailLayananPage extends StatefulWidget {
  final DataLayanan layanan;

  const DetailLayananPage({
    super.key,
    required this.layanan,
  });

  @override
  State<DetailLayananPage> createState() => _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  // State lokal untuk menandai status sedang mengirim
  bool _sedangMengirim = false;

  // =========================
  // AJUKAN PERMOHONAN
  // =========================
  Future<void> _ajukan() async {
    setState(() {
      _sedangMengirim = true;
    });

    // Menampilkan indikator singkat sebelum permohonan tercatat
    await Future<void>.delayed(
      const Duration(milliseconds: 900),
    );

    if (!mounted) return;

    // Memasukkan layanan ke state PengajuanCubit
    context.read<PengajuanCubit>().tambahPengajuan(widget.layanan.nama);

    setState(() {
      _sedangMengirim = false;
    });

    // Nilai balik melalui Navigator.pop(context, nilai) sesuai Modul II
    Navigator.pop(
      context,
      'Permohonan ${widget.layanan.nama.toLowerCase()} telah diajukan.',
    );
  }

  // =========================
  // KOMPONEN INFORMASI
  // =========================
  Widget _info(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(label),
      subtitle: Text(
        value,
        style: Theme.of(context).textTheme.bodyLarge,
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
        title: const Text('Rincian Layanan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.layanan.nama,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 18),
                  _info(
                    context,
                    'Dinas Penanggung Jawab',
                    widget.layanan.dinas,
                    Icons.account_balance_outlined,
                  ),
                  _info(
                    context,
                    'Jam Operasional',
                    widget.layanan.jamOperasional,
                    Icons.schedule_outlined,
                  ),
                  _info(
                    context,
                    'Keterangan',
                    widget.layanan.keterangan,
                    Icons.description_outlined,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _sedangMengirim ? null : _ajukan,
                      icon: _sedangMengirim
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.send_outlined),
                      label: Text(
                        _sedangMengirim
                            ? 'Sedang mengirim...'
                            : 'Ajukan Permohonan',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}