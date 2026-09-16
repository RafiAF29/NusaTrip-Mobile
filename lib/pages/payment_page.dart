import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/safe_image.dart';
import 'ticket_page.dart';

class PaymentPage extends StatelessWidget {
  final Destination destination;

  const PaymentPage({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Detail Pembayaran'),
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
              // Header Summary Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SafeImageAsset(
                      assetPath: destination.image,
                      width: 64,
                      height: 64,
                      borderRadius: BorderRadius.circular(14),
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            destination.location,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '17 - 18 Jun 2026 • 2 Dewasa',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Rincian Biaya
              const Text(
                'Rincian Biaya',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Column(
                  children: [
                    _buildCostRow('Akomodasi Homestay', 'Rp 250.000'),
                    const SizedBox(height: 10),
                    _buildCostRow('Guide Lokal (2 hari)', 'Rp 150.000'),
                    const SizedBox(height: 10),
                    _buildCostRow('Paket Budaya & Konsumsi', 'Rp 600.000'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: AppTheme.border),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Total Pembayaran',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                        Text(
                          'Rp 1.000.000',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Metode Pembayaran Options (Visual Only Prototype)
              const Text(
                'Metode Pembayaran',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 12),

              _buildPaymentOptionTile(
                title: 'QRIS',
                subtitle: 'Scan QRIS via Gopay, OVO, Dana, ShopeePay',
                icon: Icons.qr_code_scanner_rounded,
                isSelected: true,
              ),
              _buildPaymentOptionTile(
                title: 'Virtual Account BCA / BRI / Mandiri',
                subtitle: 'Transfer otomatis via M-Banking',
                icon: Icons.account_balance_rounded,
                isSelected: false,
              ),
              _buildPaymentOptionTile(
                title: 'E-Wallet',
                subtitle: 'Gopay, OVO, ShopeePay',
                icon: Icons.account_balance_wallet_rounded,
                isSelected: false,
              ),

              const SizedBox(height: 32),

              // CTA Button -> TicketPage
              CustomButton(
                text: 'Bayar Sekarang',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketPage(
                        destinationName: destination.name,
                        location: destination.location,
                      ),
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

  Widget _buildCostRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, color: AppTheme.textMuted),
        ),
        Text(
          amount,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.darkBrown),
        ),
      ],
    );
  }

  Widget _buildPaymentOptionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? AppTheme.primary : AppTheme.border,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? AppTheme.primary : AppTheme.textMuted,
            size: 20,
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primary.withValues(alpha: 0.12) : AppTheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
