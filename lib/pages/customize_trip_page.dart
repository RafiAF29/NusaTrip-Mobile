import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/safe_image.dart';
import 'payment_page.dart';

class CustomizeTripPage extends StatelessWidget {
  final Destination destination;

  const CustomizeTripPage({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Pilih Trip & Budget'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Destination Header Summary Card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Row(
                  children: [
                    SafeImageAsset(
                      assetPath: destination.image,
                      width: 70,
                      height: 70,
                      borderRadius: BorderRadius.circular(12),
                      fallbackText: destination.name,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            destination.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.darkBrown,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            destination.location,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            destination.price,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Tanggal Perjalanan Selection UI
              const Text(
                'Tanggal Perjalanan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.calendar_today_rounded, color: AppTheme.primary, size: 20),
                        SizedBox(width: 12),
                        Text(
                          '17 - 18 Jun 2026',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.edit_calendar_rounded, color: AppTheme.primary, size: 20),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Jumlah Peserta Section (Visual Controls)
              const Text(
                'Jumlah Peserta',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 12),

              // Dewasa Counter Row
              _buildCounterRow(
                title: 'Dewasa',
                subtitle: 'Usia 12 tahun ke atas',
                countText: '2',
              ),
              const SizedBox(height: 10),

              // Anak Counter Row
              _buildCounterRow(
                title: 'Anak-anak',
                subtitle: 'Usia 2 - 11 tahun',
                countText: '0',
              ),

              const SizedBox(height: 24),

              // Budget per hari Options (Visual Radio Selection)
              const Text(
                'Budget per Hari',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 12),

              _buildBudgetTile(
                title: 'Ekonomis',
                priceRange: 'Rp 200.000 - 350.000',
                isSelected: false,
              ),
              _buildBudgetTile(
                title: 'Hemat',
                priceRange: 'Rp 350.000 - 700.000',
                isSelected: false,
              ),
              _buildBudgetTile(
                title: 'Normal',
                priceRange: 'Rp 700.000 - 1.200.000',
                isSelected: false,
              ),
              _buildBudgetTile(
                title: 'Premium',
                priceRange: 'Rp 1.200.000 - 1.600.000',
                isSelected: true,
              ),
              _buildBudgetTile(
                title: 'Mewah',
                priceRange: 'Rp 1.600.000 - 2.500.000+',
                isSelected: false,
              ),

              const SizedBox(height: 32),

              // CTA Button -> PaymentPage
              CustomButton(
                text: 'Lanjutkan ke Pembayaran',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(destination: destination),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounterRow({
    required String title,
    required String subtitle,
    required String countText,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.remove, size: 16, color: AppTheme.darkBrown),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  countText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBrown,
                  ),
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, size: 16, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetTile({
    required String title,
    required String priceRange,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? AppTheme.primary : AppTheme.border,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: isSelected ? AppTheme.primary : AppTheme.textMuted,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: AppTheme.darkBrown,
                ),
              ),
            ],
          ),
          Text(
            priceRange,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppTheme.primary : AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
