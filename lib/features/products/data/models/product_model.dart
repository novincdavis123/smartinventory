import '../../domain/entities/product.dart';

class ProductModel extends Product {
  final RatingModel ratingModel;

  ProductModel({
    required int id,
    required String title,
    required String description,
    required String category,
    required String image,
    required double price,
    required this.ratingModel,
  }) : super(
         id: id,
         title: title,
         description: description,
         category: category,
         image: image,
         price: price,
         rating: ratingModel.rate,
         ratingCount: ratingModel.count,
       );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final ratingJson = json['rating'] ?? {};

    return ProductModel(
      id: json['id'] as int,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] as num).toDouble(),
      ratingModel: RatingModel.fromJson(ratingJson),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'image': image,
      'price': price,
      'rating': ratingModel.toJson(),
    };
  }
}

class RatingModel {
  final double rate;
  final int count;

  const RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: (json['rate'] ?? 0).toDouble(),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'rate': rate, 'count': count};
  }
}
