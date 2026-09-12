import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/custom_button.dart';
import 'home_page.dart';

class CancellationPage extends StatelessWidget {
  final String destinationName;
  final String bookingId;
  final String travelDate;
  final String totalPrice;

  const CancellationPage({
    super.key,
    this.destinationName = 'Wae Rebo - NTT',
    this.bookingId = 'WR2100398',
    this.travelDate = '17 - 18 Jun 2026',
    this.totalPrice = 'Rp1.500.000',
  });

  void _showCancellationConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: AppTheme.background,
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: AppTheme.primary, size: 28),
            SizedBox(width: 10),
            Text(
              'Konfirmasi Pembatalan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkBrown,
              ),
            ),
          ],
        ),
        content: const Text(
          'Apakah Anda yakin ingin membatalkan booking tiket ini? Dana refund sebesar Rp1.125.000 akan diproses dalam 2x24 jam kerja.',
          style: TextStyle(fontSize: 14, color: AppTheme.darkBrown, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Kembali', style: TextStyle(color: AppTheme.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pembatalan booking berhasil diproses.'),
                  backgroundColor: AppTheme.primary,
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            },
            child: const Text('Ya, Batalkan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Pembatalan Booking'),
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
              // Ticket Header Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          destinationName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          totalPrice,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ID Booking: $bookingId  •  Tanggal: $travelDate',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Warning Box (PERINGATAN: Potongan 25%)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3CD),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFFEEBA)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.report_problem_rounded, color: Color(0xFF856404), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PERINGATAN CANCELLATION',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF856404),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Pembatalan booking dikenakan potongan biaya layanan sebesar 25% sesuai ketentuan.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF856404),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Rincian Refund Calculation Breakdown
              const Text(
                'Rincian Refund',
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
                    _buildRefundRow('Nilai Biaya Terbayar', 'Rp 1.500.000'),
                    const SizedBox(height: 10),
                    _buildRefundRow('Biaya Pembatalan (25%)', '- Rp 375.000', isDeduction: true),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: AppTheme.border),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Jumlah Pengembalian',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                        Text(
                          'Rp 1.125.000',
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

              // Reason Options (Visual Selection)
              const Text(
                'Alasan Pembatalan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 12),

              _buildReasonTile('Perubahan Rencana Perjalanan', isSelected: true),
              _buildReasonTile('Berhalangan Hadir / Urusan Mendadak', isSelected: false),
              _buildReasonTile('Alasan Pribadi', isSelected: false),
              _buildReasonTile('Lainnya', isSelected: false),

              const SizedBox(height: 32),

              // CTA Button -> Show Dialog
              CustomButton(
                text: 'Konfirmasi Batalkan Booking',
                onPressed: () => _showCancellationConfirmation(context),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }

  Widget _buildRefundRow(String label, String amount, {bool isDeduction = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppTheme.textMuted),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDeduction ? Colors.red.shade700 : AppTheme.darkBrown,
          ),
        ),
      ],
    );
  }

  Widget _buildReasonTile(String reason, {required bool isSelected}) {
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
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? AppTheme.primary : AppTheme.textMuted,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            reason,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: AppTheme.darkBrown,
            ),
          ),
        ],
      ),
    );
  }
}
