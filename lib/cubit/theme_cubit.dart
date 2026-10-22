import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit untuk mengelola preferensi mode tema aplikasi (terang atau gelap).
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  /// Berpindah antara mode terang dan mode gelap.
  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  /// Menetapkan mode tema secara eksplisit.
  void setMode(ThemeMode mode) {
    emit(mode);
  }
}