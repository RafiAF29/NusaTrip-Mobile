import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../models/tour_package.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/package_option_card.dart';
import '../widgets/safe_image.dart';
import 'ticket_page.dart';

/// Destination detail page — StatefulWidget version.
///
/// Lists each bookable service (Paket Budaya, Guide Lokal, Homestay) as its
/// own rich [PackageOptionCard]. Every card now shares the same functional
/// quantity stepper (+/-) — Guide Lokal behaves exactly like Homestay and
/// Paket Budaya, each with its own quantity kept in this page's state.
///
/// The per-card "Pesan Sekarang" buttons have been removed (there used to
/// be 3, one per package). Booking now happens only through the single
/// sticky bottom CTA, which is labeled "Pesan Sekarang" and takes the user
/// straight to [TicketPage].
class DestinationDetailPage extends StatefulWidget {
  final Destination destination;

  const DestinationDetailPage({
    super.key,
    required this.destination,
  });

  @override
  State<DestinationDetailPage> createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage> {
  /// Quantity per package, keyed by index in [_buildPackages] (0 = Paket
  /// Budaya, 1 = Guide Lokal, 2 = Homestay). All three start at 1 and use
  /// the exact same +/- stepper behaviour.
  final Map<int, int> _quantities = {0: 1, 1: 1, 2: 1};

  /// Builds the list of bookable packages for this destination.
  ///
  /// Falls back to sensible default copy (matching the reference designs)
  /// whenever the destination doesn't have enough of its own data, so this
  /// works for every destination in DummyData, not just Wae Rebo.
  List<TourPackage> _buildPackages() {
    final destination = widget.destination;
    return [
      TourPackage(
        badge: 'Paket Budaya',
        title: destination.name,
        price: 'Rp200.000,00',
        priceUnit: '/orang',
        imagePath: destination.image,
        description:
            'Rumah adat ${destination.name}, yang dikenal sebagai Mbaru Niang, '
            'adalah rumah tradisional berbentuk kerucut khas suku Manggarai '
            'di Flores, Nusa Tenggara Timur.',
        gallery: [destination.image, destination.image, destination.image],
        items: destination.highlights.isNotEmpty
            ? destination.highlights
            : const [
                'Workshop tenun ikat tradisional Manggarai bersama pengrajin lokal (2 jam)',
                'Mengikuti ritual adat Todo (jika sedang berlangsung)',
                'Sesi memasak makanan tradisional bersama ibu-ibu desa',
                'Membawa pulang satu hasil kerajinan tangan mini sebagai kenang-kenangan',
              ],
      ),
      TourPackage(
        badge: 'Guide Lokal',
        title: 'Guide Lokal Berpengalaman',
        price: 'Rp150.000,00',
        priceUnit: '/orang/grup(5)',
        imagePath: destination.image,
        description: destination.description,
        gallery: [destination.image, destination.image, destination.image],
        galleryExtraLabel: '15+',
        items: const [
          'Pemandu warga asli yang fasih berbahasa Indonesia',
          'Tur keliling beserta penjelasan sejarah dan filosofi arsitektur',
          'Cerita adat yang tidak ada di internet',
          'Foto eksklusif di sudut-sudut terbaik yang hanya diketahui warga lokal',
        ],
      ),
      TourPackage(
        badge: 'Homestay',
        title: 'Homestay & Pengalaman Budaya',
        price: destination.price,
        priceUnit: '/malam',
        imagePath: destination.image,
        description: destination.description,
        gallery: [destination.image, destination.image, destination.image],
        galleryExtraLabel: '20+',
        items: destination.facilities.isNotEmpty
            ? destination.facilities
            : const [
                'Menginap di rumah keluarga lokal warga desa',
                'Interaksi langsung dengan keluarga tuan rumah',
                'Kasur, selimut, dan perlengkapan tidur tradisional',
                'Makan bersama keluarga tuan rumah',
                'Menu masakan tradisional berbahan lokal',
              ],
      ),
    ];
  }

  void _goToTicketPage(BuildContext context) {
    final destination = widget.destination;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketPage(
          destinationName: destination.name,
          location: destination.location,
          totalPrice: destination.price,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;
    final packages = _buildPackages();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Scrollable Page Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image Header Area
                Stack(
                  children: [
                    SafeImageAsset(
                      assetPath: destination.image,
                      height: 320,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      fallbackIcon: Icons.landscape_rounded,
                      fallbackText: destination.name,
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.4),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.6),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    // Back & Favorite Header Buttons
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black.withValues(alpha: 0.5),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black.withValues(alpha: 0.5),
                              child: const Icon(Icons.favorite_border_rounded, color: Colors.white, size: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Rating Badge Positioned Bottom Right
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${destination.rating} (${destination.reviewsCount} Ulasan)',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Main Details Body
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Tag
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          destination.category.toUpperCase(),
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Title & Location
                      Text(
                        destination.name,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkBrown,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, color: AppTheme.primary, size: 16),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              destination.location,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Description Section
                      const Text(
                        'Deskripsi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkBrown,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        destination.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.darkBrown,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Paket & Layanan — rich package cards
                      // (Paket Budaya / Guide Lokal / Homestay), each with
                      // its own working +/- quantity stepper and no
                      // per-card order button anymore.
                      const Text(
                        'Paket & Layanan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkBrown,
                        ),
                      ),
                      const SizedBox(height: 14),
                      ...List.generate(packages.length, (index) {
                        return PackageOptionCard(
                          package: packages[index],
                          quantity: _quantities[index] ?? 1,
                          onQuantityChanged: (newQty) {
                            setState(() {
                              _quantities[index] = newQty;
                            });
                          },
                        );
                      }),

                      const SizedBox(height: 90), // Bottom padding for sticky CTA button
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Sticky CTA Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.darkBrown.withValues(alpha: 0.12),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mulai Dari',
                          style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
                        ),
                        Text(
                          destination.price,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        text: 'Pesan Sekarang',
                        icon: Icons.confirmation_number_outlined,
                        onPressed: () => _goToTicketPage(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
