import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/category_card.dart';
import '../widgets/destination_card.dart';
import 'destination_detail_page.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CategoryCard(
                    title: 'Semua',
                    iconFileName: 'nature.png',
                    isSelected: true,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  ...DummyData.categories.map((cat) {
                    final name = cat['name'] as String;
                    final icon = cat['icon'] as String;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CategoryCard(
                        title: name,
                        iconFileName: icon,
                        isSelected: false,
                        onTap: () {},
                      ),
                    );
                  }),
                ],
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
