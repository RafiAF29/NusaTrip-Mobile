class TicketModel {
  final String id;
  final String destinationName;
  final String location;
  final String bookingDate;
  final int guestCount;
  final String totalPrice;
  final String paymentMethod;
  final String qrCodeData;
  final String status;

  const TicketModel({
    required this.id,
    required this.destinationName,
    required this.location,
    required this.bookingDate,
    required this.guestCount,
    required this.totalPrice,
    required this.paymentMethod,
    required this.qrCodeData,
    this.status = 'LUNAS',
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id']?.toString() ?? '',
      destinationName: json['destinationName']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      bookingDate: json['bookingDate']?.toString() ?? '',
      guestCount: (json['guestCount'] as num?)?.toInt() ?? 1,
      totalPrice: json['totalPrice']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? 'QRIS',
      qrCodeData: json['qrCodeData']?.toString() ?? '',
      status: json['status']?.toString() ?? 'LUNAS',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'destinationName': destinationName,
      'location': location,
      'bookingDate': bookingDate,
      'guestCount': guestCount,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
      'qrCodeData': qrCodeData,
      'status': status,
    };
  }
}
