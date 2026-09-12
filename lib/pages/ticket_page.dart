import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/ticket_card.dart';
import 'cancellation_page.dart';

class TicketPage extends StatelessWidget {
  final String destinationName;
  final String location;
  final String customerName;
  final String bookingId;
  final String travelDate;
  final String totalPrice;

  const TicketPage({
    super.key,
    this.destinationName = 'Wae Rebo',
    this.location = 'NTT',
    this.customerName = 'Aisyah',
    this.bookingId = 'WR2100398',
    this.travelDate = '17 - 18 Jun 2026',
    this.totalPrice = 'Rp1.500.000',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Tiket Digital'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // Ticket Status Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppTheme.mutedGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.mutedGreen),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.verified_rounded, color: AppTheme.mutedGreen, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'STATUS TIKET: TERKONFIRMASI',
                      style: TextStyle(
                        color: AppTheme.mutedGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Digital Ticket Card Component
              TicketCard(
                destinationName: destinationName,
                location: location,
                customerName: customerName,
                bookingId: bookingId,
                travelDate: travelDate,
                totalPrice: totalPrice,
                packageDetails: 'Homestay, Guide Lokal, Pengalaman Budaya',
                onCancelTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CancellationPage(
                        destinationName: destinationName,
                        bookingId: bookingId,
                        travelDate: travelDate,
                        totalPrice: totalPrice,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
