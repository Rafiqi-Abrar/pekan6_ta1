import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit untuk mengelola daftar layanan yang sedang diajukan oleh warga.
/// State berupa [List<String>] yang memuat nama-nama permohonan layanan.
class PengajuanCubit extends Cubit<List<String>> {
  PengajuanCubit() : super(const []);

  /// Turunan total permohonan yang sedang diajukan.
  int get totalPengajuan => state.length;

  /// Menambahkan nama layanan baru ke dalam antrean/keranjang pengajuan.
  void tambahPengajuan(String namaLayanan) {
    final baru = List<String>.from(state)..add(namaLayanan);
    emit(baru);
  }

  /// Menghapus layanan tertentu dari daftar pengajuan berdasarkan indeks.
  void hapusPengajuan(int index) {
    if (index >= 0 && index < state.length) {
      final baru = List<String>.from(state)..removeAt(index);
      emit(baru);
    }
  }

  /// Mengirimkan dan mengosongkan seluruh antrean pengajuan setelah diproses.
  void bersihkanSemua() {
    emit(const []);
  }
}