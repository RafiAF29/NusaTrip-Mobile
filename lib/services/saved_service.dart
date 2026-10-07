import 'package:flutter/foundation.dart';
import '../models/destination.dart';

/// Service terpusat untuk mengelola daftar Destinasi Favorit (Saved/Bookmark).
///
/// Menggunakan `ValueNotifier` agar seluruh layar dapat merespons perubahan favorit
/// secara real-time tanpa perlu mengubah halaman menjadi `StatefulWidget`!
class SavedService {
  static final ValueNotifier<List<Destination>> savedDestinationsNotifier =
      ValueNotifier<List<Destination>>([]);

  /// Cek apakah suatu destinasi sudah ada di dalam daftar favorit
  static bool isSaved(Destination destination) {
    return savedDestinationsNotifier.value
        .any((item) => item.id == destination.id);
  }

  /// Menambah atau menghapus destinasi dari daftar favorit
  static void toggleBookmark(Destination destination) {
    final currentList = List<Destination>.from(savedDestinationsNotifier.value);
    if (isSaved(destination)) {
      currentList.removeWhere((item) => item.id == destination.id);
    } else {
      currentList.add(destination);
    }
    savedDestinationsNotifier.value = currentList;
  }
}
