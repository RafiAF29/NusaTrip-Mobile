import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/destination_card.dart';
import 'destination_detail_page.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  // Icon lokal per kategori, dipakai supaya chip kategori di halaman ini
  // tidak bergantung pada asset gambar (yang sebelumnya bikin overflow
  // karena SafeImageAsset menampilkan ikon fallback ukuran 36px di dalam
  // box tinggi 20px saat asset-nya gagal dimuat).
  static IconData _categoryIcon(String title) {
    switch (title.toLowerCase()) {
      case 'alam':
        return Icons.landscape_rounded;
      case 'budaya':
        return Icons.theater_comedy_rounded;
      case 'sejarah':
        return Icons.account_balance_rounded;
      case 'religi':
        return Icons.temple_buddhist_rounded;
      default:
        return Icons.explore_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final destinations = DummyData.destinations;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Eksplor Destinasi'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Field
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari destinasi, kota, atau budaya...',
                  prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.primary),
                  suffixIcon: const Icon(Icons.tune_rounded, color: AppTheme.darkBrown),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppTheme.border),
                  ),
                ),
              ),
            ),

            // Category Chips Row
            SizedBox(
              height: 44,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ExploreCategoryChip(
                      title: 'Semua',
                      icon: Icons.explore_rounded,
                      isSelected: true,
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                    ...DummyData.categories.map((cat) {
                      final name = cat['name'] as String;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _ExploreCategoryChip(
                          title: name,
                          icon: _categoryIcon(name),
                          isSelected: false,
                          onTap: () {},
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Destination Count Tag & Filter Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${destinations.length} Destinasi Ditemukan',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.swap_vert_rounded, size: 16, color: AppTheme.primary),
                      SizedBox(width: 4),
                      Text(
                        'Rating Teratas',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // List of Destinations
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  final destination = destinations[index];
                  return DestinationCard(
                    destination: destination,
                    isHorizontal: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DestinationDetailPage(destination: destination),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}

// Chip kategori khusus untuk ExplorePage.
// Dibuat lokal (bukan pakai CategoryCard/SafeImageAsset) supaya tidak lagi
// tergantung file asset icon yang belum ada, sekaligus menghilangkan
// "BOTTOM OVERFLOWED" yang muncul akibat ikon fallback lebih besar
// daripada tinggi box-nya.
class _ExploreCategoryChip extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ExploreCategoryChip({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isSelected ? AppTheme.primary : Colors.white;
    final Color textColor = isSelected ? Colors.white : AppTheme.darkBrown;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.border,
            width: 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: textColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}