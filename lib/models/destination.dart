class Destination {
  final String id;
  final String name;
  final String location;
  final String image;
  final String category;
  final String description;
  final double rating;
  final String price;
  final int reviewsCount;
  final List<String> highlights;
  final List<String> facilities;
  final List<String> packageOptions;

  const Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.category,
    required this.description,
    required this.rating,
    required this.price,
    required this.reviewsCount,
    required this.highlights,
    required this.facilities,
    required this.packageOptions,
  });

  /// Factory constructor untuk parsing data JSON dari Database (Firebase/Supabase/REST API)
  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      price: json['price']?.toString() ?? '',
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      highlights: json['highlights'] != null
          ? List<String>.from(json['highlights'])
          : const [],
      facilities: json['facilities'] != null
          ? List<String>.from(json['facilities'])
          : const [],
      packageOptions: json['packageOptions'] != null
          ? List<String>.from(json['packageOptions'])
          : const [],
    );
  }

  /// Konversi Objek Dart ke Map JSON untuk dikirim ke Database
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'image': image,
      'category': category,
      'description': description,
      'rating': rating,
      'price': price,
      'reviewsCount': reviewsCount,
      'highlights': highlights,
      'facilities': facilities,
      'packageOptions': packageOptions,
    };
  }
}
