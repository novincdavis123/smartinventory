import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartinventory/features/products/presentation/widgets/product_card.dart';
import '../providers/product_provider.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Product Discovery'), centerTitle: true),

      body: Column(
        children: [
          /// SEARCH UI
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                // handled fully inside Notifier
                ref.read(productProvider.notifier).search(value);
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          /// LIST UI
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),

              error: (error, _) => Center(
                child: Text(
                  'Something went wrong\n$error',
                  textAlign: TextAlign.center,
                ),
              ),

              data: (products) {
                if (products.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(productProvider.notifier).refresh();
                  },
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return ProductCard(product: product);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
