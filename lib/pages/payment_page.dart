import 'package:flutter/material.dart';

import '../models/destination.dart';
import '../theme/app_theme.dart';
import '../widgets/safe_image.dart';
import 'ticket_page.dart';

class PaymentPage extends StatefulWidget {
  final Destination destination;

  const PaymentPage({super.key, required this.destination});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // State untuk metode pembayaran yang dipilih
  int _selectedMethod = 0; // 0 = QRIS, 1 = VA, 2 = E-Wallet

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Detail Pembayaran',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          // FUNGSI BACK — tetap berjalan
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            // FUNGSI MENU — tetap berjalan (siap diisi)
            icon: const Icon(Icons.menu, size: 22, color: Colors.black87),
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Menu dibuka')));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================== HEADER CARD MERAH ==================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.destination.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '17 - 18 Jun 2026 • 2 Dewasa',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Gambar destinasi
                    SafeImageAsset(
                      assetPath: widget.destination.image,
                      width: 56,
                      height: 56,
                      borderRadius: BorderRadius.circular(12),
                      fallbackText: widget.destination.name,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ================== KARTU RINCIAN BIAYA ==================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Column(
                  children: [
                    _buildCostRow('Homestay', 'Rp 250.000'),
                    const SizedBox(height: 14),
                    _buildCostRow('Guide Lokal', 'Rp 150.000'),
                    const SizedBox(height: 14),
                    _buildCostRow('Paket Budaya', 'Rp 600.000'),
                    const SizedBox(height: 14),
                    // Baris Total dengan background abu
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Rp 1.000.000',
                            style: TextStyle(
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

              const SizedBox(height: 22),

              // ================== JUDUL METODE PEMBAYARAN ==================
              const Text(
                'Metode Pembayaran',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // ================== KARTU METODE PEMBAYARAN ==================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Column(
                  children: [
                    // ---------- QRIS ----------
                    _buildPaymentMethod(
                      index: 0,
                      title: 'QRIS',
                      logos: const ['QRIS'],
                    ),
                    const SizedBox(height: 16),

                    // ---------- Virtual Account ----------
                    _buildPaymentMethod(
                      index: 1,
                      title: 'Virtual Account',
                      logos: const ['BCA', 'BRI', 'Mandiri'],
                    ),
                    const SizedBox(height: 16),

                    // ---------- E-Wallet ----------
                    _buildPaymentMethod(
                      index: 2,
                      title: 'E-Wallet',
                      logos: const ['Gopay', 'OVO'],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ================== TOMBOL BAYAR SEKARANG ==================
              Center(
                child: SizedBox(
                  width: 220,
                  height: 44,
                  child: ElevatedButton(
                    // FUNGSI BAYAR — navigasi ke TicketPage, tetap berjalan
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicketPage(
                            destinationName: widget.destination.name,
                            location: widget.destination.location,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text(
                      'Bayar Sekarang',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ================== WIDGET: BARIS BIAYA ==================
  Widget _buildCostRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12.5, color: Colors.black54),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // ================== WIDGET: METODE PEMBAYARAN ==================
  Widget _buildPaymentMethod({
    required int index,
    required String title,
    required List<String> logos,
  }) {
    final bool isSelected = _selectedMethod == index;

    return GestureDetector(
      // FUNGSI PILIH METODE — tetap berjalan
      onTap: () {
        setState(() {
          _selectedMethod = index;
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Radio button
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppTheme.primary : Colors.black26,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),

          // Judul + logo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                // Baris logo
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: logos.map((logo) {
                    return _buildLogoBadge(logo);
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================== WIDGET: BADGE LOGO ==================
  Widget _buildLogoBadge(String label) {
    // Warna & gaya logo sederhana sebagai placeholder
    Color bgColor;
    Color textColor;
    switch (label) {
      case 'QRIS':
        bgColor = const Color(0xFFE53935);
        textColor = Colors.white;
        break;
      case 'BCA':
        bgColor = const Color(0xFF0066AE);
        textColor = Colors.white;
        break;
      case 'BRI':
        bgColor = const Color(0xFF00529C);
        textColor = Colors.white;
        break;
      case 'Mandiri':
        bgColor = const Color(0xFFF9A825);
        textColor = Colors.white;
        break;
      case 'Gopay':
        bgColor = const Color(0xFF00AA13);
        textColor = Colors.white;
        break;
      case 'OVO':
        bgColor = const Color(0xFF4C3494);
        textColor = Colors.white;
        break;
      default:
        bgColor = Colors.grey.shade300;
        textColor = Colors.black87;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: textColor,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
