class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String image;
  final double price;
  final double rating;
  final int ratingCount;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    required this.rating,
    required this.ratingCount,
  });
}
