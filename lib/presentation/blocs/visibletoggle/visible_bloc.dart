import 'package:flutter_bloc/flutter_bloc.dart';
import 'visible_state.dart';

class BottomNavCubit extends Cubit<VisibleState> {
  // Konstruktor yang menerima nilai awal
  BottomNavCubit() : super(VisibleState(true));

  // Fungsi untuk menampilkan bottom nav
  void show() {
    emit(VisibleState(true)); // Mengubah state menjadi visible
  }

  // Fungsi untuk menyembunyikan bottom nav
  void hide() {
    emit(VisibleState(false)); // Mengubah state menjadi tidak visible
  }
}
