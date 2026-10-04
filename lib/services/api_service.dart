import '../data/dummy_data.dart';
import '../models/destination.dart';
import '../models/ticket_model.dart';
import '../models/user_model.dart';

/// Centralized API / Database Service Provider
///
/// Siap dihubungkan langsung ke Firebase, Supabase, atau REST API HTTP.
/// Saat ini memiliki fallback data lokal agar aplikasi tetap 100% berjalan offline.
class ApiService {
  static const String baseUrl = 'https://api.nusatrip.com/v1';

  /// Mengambil daftar destinasi wisata dari Database / API
  static Future<List<Destination>> getDestinations({String? category}) async {
    // Simulasi delay request jaringan (dapat diganti dengan panggilan http / firebase / supabase)
    await Future.delayed(const Duration(milliseconds: 300));
    
    final allDestinations = DummyData.destinations;
    if (category == null || category.isEmpty || category == 'Semua') {
      return allDestinations;
    }
    return allDestinations
        .where((d) => d.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  /// Autentikasi Pengguna (Login) ke Database
  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (email.isNotEmpty && password.isNotEmpty) {
      return UserModel(
        id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
        name: email.split('@').first,
        email: email,
        rewardPoints: 1250,
      );
    }
    return null;
  }

  /// Pendaftaran Pengguna Baru (Register) ke Database
  static Future<UserModel?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      rewardPoints: 500,
    );
  }

  /// Pembuatan & Simpan Tiket Pemesanan ke Database
  static Future<TicketModel> createTicketBooking({
    required Destination destination,
    required String bookingDate,
    required int guestCount,
    required String totalPrice,
    required String paymentMethod,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final ticketId = 'NT-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';
    return TicketModel(
      id: ticketId,
      destinationName: destination.name,
      location: destination.location,
      bookingDate: bookingDate,
      guestCount: guestCount,
      totalPrice: totalPrice,
      paymentMethod: paymentMethod,
      qrCodeData: 'NUSATRIP-VOUCHER-$ticketId-${destination.id.toUpperCase()}',
      status: 'LUNAS',
    );
  }
}
