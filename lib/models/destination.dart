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
}
