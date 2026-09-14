import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
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
      // Background putih bersih, persis seperti gambar
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Tiket Digital',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          // Fungsi back tetap ada
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            // Fungsi scan tetap ada
            icon: const Icon(
              Icons.qr_code_scanner,
              size: 22,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          child: Column(
            children: [
              // ================== KARTU TIKET (PERSIS GAMBAR) ==================
              _TicketCard(
                destinationName: destinationName,
                location: location,
                customerName: customerName,
                bookingId: bookingId,
                travelDate: travelDate,
                totalPrice: totalPrice,
                packageDetails: 'Homestay, Guide Lokal,\nPengalaman Budaya',
              ),

              const SizedBox(height: 22),

              // ================== BANNER STATUS (fungsi tetap, tampilan minimalis) ==================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.mutedGreen.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppTheme.mutedGreen.withValues(alpha: 0.45),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.verified_rounded,
                      color: AppTheme.mutedGreen,
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'STATUS TIKET: TERKONFIRMASI',
                      style: TextStyle(
                        color: AppTheme.mutedGreen,
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ================== TOMBOL PEMBATALAN (fungsi tetap) ==================
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Fungsi navigasi ke CancellationPage tetap ada
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
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: BorderSide(
                      color: AppTheme.primary.withValues(alpha: 0.45),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Ajukan Pembatalan',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}

// ==================================================================
// ======================= KARTU TIKET ==============================
// ==================================================================
class _TicketCard extends StatelessWidget {
  final String destinationName;
  final String location;
  final String customerName;
  final String bookingId;
  final String travelDate;
  final String totalPrice;
  final String packageDetails;

  const _TicketCard({
    required this.destinationName,
    required this.location,
    required this.customerName,
    required this.bookingId,
    required this.travelDate,
    required this.totalPrice,
    required this.packageDetails,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TicketShadowPainter(),
      child: ClipPath(
        clipper: _TicketClipper(),
        child: Container(
          color: AppTheme.primary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ================= BAGIAN ATAS =================
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama destinasi + ikon share
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '$destinationName - $location',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.share_outlined,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Trip 2 Hari 1 Malam',
                      style: TextStyle(color: Colors.white70, fontSize: 10.5),
                    ),
                    const SizedBox(height: 14),

                    // Garis tipis pemisah
                    Container(
                      height: 0.6,
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                    const SizedBox(height: 14),

                    // Booking ID & Total Harga
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Booking ID',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 9.5,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                bookingId,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Total Harga',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 9.5,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                totalPrice,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Nama Pemesan
                    const Text(
                      'Nama Pemesan',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 9.5,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      customerName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Paket
                    const Text(
                      'Paket',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 9.5,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      packageDetails,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),

              // ================= GARIS PUTUS-PUTUS =================
              _DashedDivider(color: Colors.white.withValues(alpha: 0.55)),

              // ================= BAGIAN BAWAH (QR) =================
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 26),
                child: Column(
                  children: [
                    const Text(
                      'Private QR code ini akan dipindai\nPemindaian saat tiba di lokasi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        height: 1.5,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 18),
                    // QR Code
                    Container(
                      width: 165,
                      height: 165,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.qr_code_2,
                        size: 153,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================================
// ==================== GARIS PUTUS-PUTUS ===========================
// ==================================================================
class _DashedDivider extends StatelessWidget {
  final Color color;
  const _DashedDivider({required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const dashWidth = 4.5;
          const dashSpace = 4.0;
          final dashCount = (constraints.maxWidth / (dashWidth + dashSpace))
              .floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: 1,
                child: DecoratedBox(decoration: BoxDecoration(color: color)),
              );
            }),
          );
        },
      ),
    );
  }
}

// ==================================================================
// ==================== CLIPPER BENTUK TIKET ========================
// ==================================================================
class _TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 26.0; // lengkungan sudut luar (besar, seperti gambar)
    const notchRadius = 13.0; // lubang setengah lingkaran
    const waveHeight = 3.0; // tinggi gerigi atas/bawah
    const waveWidth = 8.0; // lebar satu gerigi

    final notchY = size.height * 0.555; // posisi lubang di garis putus-putus

    // Mulai dari kiri atas setelah lengkungan
    path.moveTo(radius, 0);

    // ===== SISI ATAS (bergerigi tajam) =====
    _addWavyLine(
      path,
      radius,
      0,
      size.width - radius,
      0,
      waveWidth,
      waveHeight,
      true,
    );

    // Sudut kanan atas
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // ===== SISI KANAN ATAS sampai lubang =====
    path.lineTo(size.width, notchY - notchRadius);
    path.arcToPoint(
      Offset(size.width, notchY + notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );

    // ===== SISI KANAN BAWAH =====
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );

    // ===== SISI BAWAH (bergerigi tajam) =====
    _addWavyLine(
      path,
      size.width - radius,
      size.height,
      radius,
      size.height,
      waveWidth,
      waveHeight,
      false,
    );

    // Sudut kiri bawah
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    // ===== SISI KIRI BAWAH sampai lubang =====
    path.lineTo(0, notchY + notchRadius);
    path.arcToPoint(
      Offset(0, notchY - notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );

    // ===== SISI KIRI ATAS =====
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    path.close();
    return path;
  }

  void _addWavyLine(
    Path path,
    double x1,
    double y1,
    double x2,
    double y2,
    double waveWidth,
    double waveHeight,
    bool isTop,
  ) {
    final totalDx = x2 - x1;
    final totalDy = y2 - y1;
    final distance = totalDx.abs();
    final steps = (distance / waveWidth).floor();

    for (int i = 0; i < steps; i++) {
      final startX = x1 + (totalDx / steps) * i;
      final startY = y1 + (totalDy / steps) * i;
      final midX = startX + (totalDx / steps) / 2;
      final midY =
          startY + (totalDy / steps) / 2 + (isTop ? -waveHeight : waveHeight);
      final endX = startX + (totalDx / steps);
      final endY = startY + (totalDy / steps);
      path.quadraticBezierTo(midX, midY, endX, endY);
    }
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// ==================================================================
// ==================== SHADOW PAINTER ==============================
// ==================================================================
class _TicketShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.13)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final path = _TicketClipper().getClip(size);
    canvas.drawPath(path.shift(const Offset(0, 5)), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
