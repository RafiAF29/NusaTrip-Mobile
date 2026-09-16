import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/safe_image.dart';
import 'customize_trip_page.dart';

/// Wireframe placeholder model for a single package option card.
///
/// NOTE: `Destination` model belum punya field harga/deskripsi/checklist
/// per-paket, jadi data di sini masih placeholder (wireframe) yang
/// digenerate dari `destination.packageOptions`. Nanti tinggal disambungkan
/// ke data asli (API / model baru) tanpa perlu ubah struktur widget-nya.
class _PackageOption {
  final String title;
  final double priceValue;
  final String priceUnit;
  final String about;
  final int morePhotosCount;
  final List<String> includes;

  const _PackageOption({
    required this.title,
    required this.priceValue,
    required this.priceUnit,
    required this.about,
    required this.morePhotosCount,
    required this.includes,
  });

  String get priceLabel => 'Rp${_formatCurrency(priceValue)}';

  static String _formatCurrency(double value) {
    final digits = value.toStringAsFixed(0);
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      final posFromEnd = digits.length - i;
      buffer.write(digits[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write('.');
    }
    return buffer.toString();
  }

  factory _PackageOption.placeholder(String title, int index) {
    return _PackageOption(
      title: title,
      priceValue: 150000 + (index * 50000),
      priceUnit: index == 0 ? '/malam' : '/orang',
      about:
          'Deskripsi singkat untuk paket "$title". Ganti teks placeholder '
          'ini dengan penjelasan detail paket setelah data asli tersedia.',
      morePhotosCount: 10 + (index * 5),
      includes: const [
        'Poin yang didapatkan 1',
        'Poin yang didapatkan 2',
        'Poin yang didapatkan 3',
      ],
    );
  }
}

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
  late final List<_PackageOption> _packages;
  late final Map<String, bool> _selectedPackages;
  late final Map<String, int> _packageQuantity;

  @override
  void initState() {
    super.initState();
    _packages = widget.destination.packageOptions
        .asMap()
        .entries
        .map((entry) => _PackageOption.placeholder(entry.value, entry.key))
        .toList();
    _selectedPackages = {for (final p in _packages) p.title: true};
    _packageQuantity = {for (final p in _packages) p.title: 1};
  }

  double get _bundleTotal {
    return _packages.fold<double>(0, (sum, p) {
      final selected = _selectedPackages[p.title] ?? false;
      final qty = _packageQuantity[p.title] ?? 1;
      return sum + (selected ? p.priceValue * qty : 0);
    });
  }

  String get _bundleTitle {
    final titles = _packages
        .where((p) => _selectedPackages[p.title] == true)
        .map((p) => p.title)
        .toList();
    if (titles.isEmpty) return 'Pilih paket di bawah';
    return titles.join(' + ');
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;

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
                      const SizedBox(height: 24),

                      // ===== NEW: Paket Unggulan (ringkasan bundle) =====
                      if (_packages.isNotEmpty) ...[
                        _buildFeaturedPackageCard(),
                        const SizedBox(height: 24),
                      ],

                      // ===== NEW: Kartu tiap opsi paket (wireframe) =====
                      const Text(
                        'Pilih Paket',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkBrown,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ..._packages.map(
                        (option) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildPackageCard(option),
                        ),
                      ),

                      // ===== NEW: Pesan Sekarang (di bawah daftar paket, sesuai referensi) =====
                      CustomButton(
                        text: 'Pesan Sekarang',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _bundleTitle == 'Pilih paket di bawah'
                                    ? 'Pilih minimal satu paket dulu ya'
                                    : 'Pesan: $_bundleTitle',
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Facilities Chips
                      const Text(
                        'Fasilitas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkBrown,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: destination.facilities
                            .map((f) => Chip(
                                  label: Text(f, style: const TextStyle(fontSize: 12, color: AppTheme.darkBrown)),
                                  backgroundColor: AppTheme.surface,
                                  side: BorderSide.none,
                                ))
                            .toList(),
                      ),

                      const SizedBox(height: 100), // Bottom padding for sticky CTA button
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
                        text: 'Customize Trip',
                        icon: Icons.tune_rounded,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomizeTripPage(destination: destination),
                            ),
                          );
                        },
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

  // ---------------------------------------------------------------------
  // Wireframe sections (belum pakai gambar/warna baru — placeholder saja)
  // ---------------------------------------------------------------------

  Widget _buildFeaturedPackageCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'PAKET UNGGULAN',
              style: TextStyle(
                color: AppTheme.primary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _bundleTitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.darkBrown,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Rp${_PackageOption._formatCurrency(_bundleTotal)},00',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(_PackageOption option) {
    final isSelected = _selectedPackages[option.title] ?? false;
    final qty = _packageQuantity[option.title] ?? 1;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header bar: pill/button nama paket + checkbox kotak di sampingnya
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      option.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedPackages[option.title] = !isSelected;
                    });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isSelected ? AppTheme.primary : AppTheme.border,
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: isSelected
                        ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                        : null,
                  ),
                ),
              ],
            ),
          ),

          // Placeholder gambar paket (wireframe — belum pakai foto asli)
          Container(
            height: 150,
            width: double.infinity,
            color: AppTheme.surface,
            alignment: Alignment.center,
            child: const Icon(Icons.image_outlined, size: 36, color: AppTheme.textMuted),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Harga
                Text(
                  '${option.priceLabel}${option.priceUnit}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 10),

                // Stepper jumlah
                Row(
                  children: [
                    _buildStepperButton(
                      icon: Icons.remove,
                      onTap: qty > 1
                          ? () => setState(() => _packageQuantity[option.title] = qty - 1)
                          : null,
                    ),
                    const SizedBox(width: 14),
                    Text(
                      '$qty',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                    const SizedBox(width: 14),
                    _buildStepperButton(
                      icon: Icons.add,
                      onTap: () => setState(() => _packageQuantity[option.title] = qty + 1),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Tentang
                const Text(
                  'Tentang',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  option.about,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textMuted,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 18),

                // Foto lainnya
                const Text(
                  'Foto lainnya',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildPhotoThumbPlaceholder(),
                    const SizedBox(width: 8),
                    _buildPhotoThumbPlaceholder(),
                    const SizedBox(width: 8),
                    _buildPhotoThumbPlaceholder(label: '+${option.morePhotosCount}'),
                  ],
                ),
                const SizedBox(height: 18),

                // Yang didapatkan
                const Text(
                  'Yang didapatkan:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 8),
                ...List.generate(
                  option.includes.length,
                  (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${i + 1}. ',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            option.includes[i],
                            style: const TextStyle(fontSize: 13, color: AppTheme.darkBrown),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperButton({required IconData icon, required VoidCallback? onTap}) {
    final enabled = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: enabled ? AppTheme.primary : AppTheme.border),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 16, color: enabled ? AppTheme.primary : AppTheme.textMuted),
      ),
    );
  }

  Widget _buildPhotoThumbPlaceholder({String? label}) {
    return Expanded(
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: label != null
            ? Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              )
            : const Icon(Icons.photo_outlined, size: 20, color: AppTheme.textMuted),
      ),
    );
  }
}
