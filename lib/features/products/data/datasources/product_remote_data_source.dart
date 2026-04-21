import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await client
          .get(Uri.parse('https://fakestoreapi.com/products'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List decoded = json.decode(response.body);

        return decoded.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw const SocketException('No Internet connection');
    } on FormatException {
      throw ServerException(); // invalid JSON
    } catch (e) {
      throw ServerException(); // fallback
    }
  }
}
