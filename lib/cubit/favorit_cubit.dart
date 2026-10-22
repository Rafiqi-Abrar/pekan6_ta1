import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit untuk mengelola kumpulan nama layanan favorit warga.
/// State berupa [Set<String>] yang berisi nama-nama layanan terpilih.
class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(<String>{});

  /// Menandai layanan sebagai favorit dan meng-emit salinan baru dari Set.
  void tandai(String namaLayanan) {
    final baru = Set<String>.from(state)..add(namaLayanan);
    emit(baru);
  }

  /// Membatalkan tanda favorit pada layanan dan meng-emit salinan baru dari Set.
  void batalTandai(String namaLayanan) {
    final baru = Set<String>.from(state)..remove(namaLayanan);
    emit(baru);
  }

  /// Beralih status favorit (tandai jika belum, batalkan jika sudah).
  void toggle(String namaLayanan) {
    if (state.contains(namaLayanan)) {
      batalTandai(namaLayanan);
    } else {
      tandai(namaLayanan);
    }
  }
}