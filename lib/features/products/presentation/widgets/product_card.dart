import 'package:flutter/material.dart';
import 'package:smartinventory/features/products/domain/entities/product.dart';
import 'package:smartinventory/features/products/presentation/screens/productdetail_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),

        leading: Hero(
          tag: product.id,
          child: Image.network(
            product.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),

        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.category),
            const SizedBox(height: 4),
            Text("⭐ ${product.rating} (${product.ratingCount})"),
            Text(
              "\$${product.price}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          );
        },
      ),
    );
  }
}
