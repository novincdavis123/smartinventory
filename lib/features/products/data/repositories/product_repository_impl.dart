import 'dart:io';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts() async {
    try {
      final products = await remoteDataSource.getProducts();
      return products; // Model extends Entity → direct return
    } on SocketException {
      throw Exception('No Internet connection');
    } on ServerException {
      throw Exception('Server error occurred');
    } catch (e) {
      throw Exception('Unexpected error');
    }
  }
}
