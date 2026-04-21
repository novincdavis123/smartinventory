import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -----------------------
            /// PRODUCT IMAGE (HERO)
            /// -----------------------
            Hero(
              tag: product.id,
              child: Container(
                width: double.infinity,
                height: 300,
                padding: const EdgeInsets.all(16),
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// -----------------------
            /// DETAILS SECTION
            /// -----------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// CATEGORY
                  Text(
                    product.category.toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// PRICE
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// RATING
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        "${product.rating} / 5",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "(${product.ratingCount} reviews)",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// DESCRIPTION HEADER
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  /// DESCRIPTION
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
