import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:nusantara_cerdas_nav_nim/cubit/favorit_cubit.dart';
import 'package:nusantara_cerdas_nav_nim/cubit/pengajuan_cubit.dart';
import 'package:nusantara_cerdas_nav_nim/cubit/theme_cubit.dart';

void main() {
  group('FavoritCubit', () {
    late FavoritCubit favoritCubit;

    setUp(() {
      favoritCubit = FavoritCubit();
    });

    tearDown(() {
      favoritCubit.close();
    });

    test('Initial state adalah Set kosong', () {
      expect(favoritCubit.state, isEmpty);
    });

    test('tandai menambahkan layanan ke favorit', () {
      favoritCubit.tandai('Izin Usaha Mikro');
      expect(favoritCubit.state, contains('Izin Usaha Mikro'));
    });

    test('batalTandai menghapus layanan dari favorit', () {
      favoritCubit.tandai('Izin Usaha Mikro');
      favoritCubit.batalTandai('Izin Usaha Mikro');
      expect(favoritCubit.state, isNot(contains('Izin Usaha Mikro')));
    });

    test('toggle beralih status favorit', () {
      favoritCubit.toggle('Vaksinasi Warga');
      expect(favoritCubit.state, contains('Vaksinasi Warga'));
      favoritCubit.toggle('Vaksinasi Warga');
      expect(favoritCubit.state, isNot(contains('Vaksinasi Warga')));
    });
  });

  group('PengajuanCubit', () {
    late PengajuanCubit pengajuanCubit;

    setUp(() {
      pengajuanCubit = PengajuanCubit();
    });

    tearDown(() {
      pengajuanCubit.close();
    });

    test('Initial state adalah List kosong dan totalPengajuan 0', () {
      expect(pengajuanCubit.state, isEmpty);
      expect(pengajuanCubit.totalPengajuan, 0);
    });

    test('tambahPengajuan menambahkan item dan menaikkan totalPengajuan', () {
      pengajuanCubit.tambahPengajuan('Izin Usaha Mikro');
      pengajuanCubit.tambahPengajuan('Vaksinasi Warga');
      expect(pengajuanCubit.state, ['Izin Usaha Mikro', 'Vaksinasi Warga']);
      expect(pengajuanCubit.totalPengajuan, 2);
    });

    test('hapusPengajuan menghapus item sesuai indeks', () {
      pengajuanCubit.tambahPengajuan('Layanan A');
      pengajuanCubit.tambahPengajuan('Layanan B');
      pengajuanCubit.hapusPengajuan(0);
      expect(pengajuanCubit.state, ['Layanan B']);
      expect(pengajuanCubit.totalPengajuan, 1);
    });

    test('bersihkanSemua mengosongkan antrean', () {
      pengajuanCubit.tambahPengajuan('Layanan A');
      pengajuanCubit.bersihkanSemua();
      expect(pengajuanCubit.state, isEmpty);
      expect(pengajuanCubit.totalPengajuan, 0);
    });
  });

  group('ThemeCubit', () {
    late ThemeCubit themeCubit;

    setUp(() {
      themeCubit = ThemeCubit();
    });

    tearDown(() {
      themeCubit.close();
    });

    test('Initial state adalah ThemeMode.light', () {
      expect(themeCubit.state, ThemeMode.light);
    });

    test('toggleTheme beralih antara light dan dark', () {
      themeCubit.toggleTheme();
      expect(themeCubit.state, ThemeMode.dark);
      themeCubit.toggleTheme();
      expect(themeCubit.state, ThemeMode.light);
    });
  });
}
