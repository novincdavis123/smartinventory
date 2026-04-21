import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartinventory/features/products/domain/usecases/get_products.dart';
import '../../domain/entities/product.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/datasources/product_remote_data_source.dart';
import 'package:http/http.dart' as http;

/// DEPENDENCY INJECTION

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSourceImpl>((
  ref,
) {
  return ProductRemoteDataSourceImpl(client: ref.read(httpClientProvider));
});

final productRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  return ProductRepositoryImpl(
    remoteDataSource: ref.read(productRemoteDataSourceProvider),
  );
});

final getProductsProvider = Provider<GetProducts>((ref) {
  return GetProducts(ref.read(productRepositoryProvider));
});

/// NOTIFIER (Riverpod 3)

final productProvider =
    NotifierProvider<ProductNotifier, AsyncValue<List<Product>>>(
      ProductNotifier.new,
    );

class ProductNotifier extends Notifier<AsyncValue<List<Product>>> {
  late final GetProducts _getProducts;

  List<Product> _allProducts = [];

  @override
  AsyncValue<List<Product>> build() {
    _getProducts = ref.read(getProductsProvider);
    fetchProducts();
    return const AsyncLoading();
  }

  /// FETCH PRODUCTS
  Future<void> fetchProducts() async {
    try {
      state = const AsyncLoading();

      final products = await _getProducts();

      _allProducts = products;

      state = AsyncData(products);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  /// SEARCH
  void search(String query) {
    if (query.isEmpty) {
      state = AsyncData(_allProducts);
      return;
    }

    final filtered = _allProducts.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase()) ||
          product.category.toLowerCase().contains(query.toLowerCase());
    }).toList();

    state = AsyncData(filtered);
  }

  /// REFRESH
  Future<void> refresh() async {
    await fetchProducts();
  }
}
