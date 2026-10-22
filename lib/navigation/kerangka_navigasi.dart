import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../pages/beranda_page.dart';
import '../pages/layanan_page.dart';
import '../pages/warga_page.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksAktif = 0;

  final List<Widget> _halaman = const [
    BerandaPage(),
    LayananPage(),
    WargaPage(),
  ];

  final List<String> _judul = const [
    'Beranda',
    'Layanan',
    'Warga',
  ];

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksAktif = indeks;
    });
  }

  Future<void> _bukaMenuPendukung(String route) async {
    Navigator.of(context).pop();

    await Future<void>.delayed(
      const Duration(milliseconds: 120),
    );

    if (!mounted) return;

    await Navigator.of(context).pushNamed(route);
  }

  void _keluar() {
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Menu Keluar masih berupa simulasi pada purwarupa.',
        ),
      ),
    );
  }

  /// Membangun ikon Warga dengan Badge reaktif via BlocSelector
  Widget _buildWargaIcon({required bool selected}) {
    return BlocSelector<PengajuanCubit, List<String>, int>(
      selector: (state) => state.length,
      builder: (context, total) {
        return Badge(
          isLabelVisible: total > 0,
          label: Text('$total'),
          child: Icon(
            selected ? Icons.person : Icons.person_outline,
          ),
        );
      },
    );
  }

  Widget _drawer(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: _indeksAktif,
      onDestinationSelected: (indeks) {
        Navigator.of(context).pop();
        _pilihTujuan(indeks);
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
          child: Text(
            'Nusantara Cerdas',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Beranda'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.miscellaneous_services_outlined),
          selectedIcon: Icon(Icons.miscellaneous_services),
          label: Text('Layanan'),
        ),
        NavigationDrawerDestination(
          icon: _buildWargaIcon(selected: false),
          selectedIcon: _buildWargaIcon(selected: true),
          label: const Text('Warga'),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Divider(),
        ),
        ListTile(
          leading: const Icon(Icons.location_city_outlined),
          title: const Text('Pengaturan Kota'),
          onTap: () => _bukaMenuPendukung(AppRoutes.pengaturanKota),
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Tentang Aplikasi'),
          onTap: () => _bukaMenuPendukung(AppRoutes.tentangAplikasi),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Keluar'),
          onTap: _keluar,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.sizeOf(context).width;
    final layarLebar = lebar >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_indeksAktif]),
        leading: Builder(
          builder: (context) {
            return IconButton(
              tooltip: 'Buka menu',
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            );
          },
        ),
      ),
      drawer: _drawer(context),
      body: Row(
        children: [
          if (layarLebar)
            NavigationRail(
              selectedIndex: _indeksAktif,
              onDestinationSelected: _pilihTujuan,
              labelType: NavigationRailLabelType.all,
              leading: Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: IconButton(
                      tooltip: 'Buka drawer',
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.menu_open),
                    ),
                  );
                },
              ),
              destinations: [
                const NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Beranda'),
                ),
                const NavigationRailDestination(
                  icon: Icon(Icons.miscellaneous_services_outlined),
                  selectedIcon: Icon(Icons.miscellaneous_services),
                  label: Text('Layanan'),
                ),
                NavigationRailDestination(
                  icon: _buildWargaIcon(selected: false),
                  selectedIcon: _buildWargaIcon(selected: true),
                  label: const Text('Warga'),
                ),
              ],
            ),
          if (layarLebar) const VerticalDivider(width: 1),
          Expanded(
            child: IndexedStack(
              index: _indeksAktif,
              children: _halaman,
            ),
          ),
        ],
      ),
      bottomNavigationBar: layarLebar
          ? null
          : NavigationBar(
              selectedIndex: _indeksAktif,
              onDestinationSelected: _pilihTujuan,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.miscellaneous_services_outlined),
                  selectedIcon: Icon(Icons.miscellaneous_services),
                  label: 'Layanan',
                ),
                NavigationDestination(
                  icon: _buildWargaIcon(selected: false),
                  selectedIcon: _buildWargaIcon(selected: true),
                  label: 'Warga',
                ),
              ],
            ),
    );
  }
}