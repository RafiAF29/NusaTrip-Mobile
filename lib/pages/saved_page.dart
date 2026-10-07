import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../services/saved_service.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/destination_card.dart';
import 'destination_detail_page.dart';

/// Halaman Destinasi Favorit (Saved/Bookmark Page)
///
/// Murni `StatelessWidget` yang menggunakan `ValueListenableBuilder` untuk
/// mendengarkan perubahan favorit dari `SavedService` secara real-time!
class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text(
          'Destinasi Favorit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.darkBrown,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ValueListenableBuilder<List<Destination>>(
          valueListenable: SavedService.savedDestinationsNotifier,
          builder: (context, savedList, child) {
            if (savedList.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          size: 64,
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Belum Ada Destinasi Favorit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkBrown,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tekan ikon hati pada tempat wisata yang Anda sukai untuk menyimpannya di sini.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textMuted,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: savedList.length,
              itemBuilder: (context, index) {
                final destination = savedList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DestinationCard(
                    destination: destination,
                    isHorizontal: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DestinationDetailPage(destination: destination),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}
