import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mylife/models/product.dart';
import 'package:mylife/service/product/product_repository.dart';

class ProductService {
  final _provider = ProductRepository();

  Future<List<ProductModel>> fetchProductList() async {
    return await _provider.fetchProductList();
  }

  Future<ProductModel> fetchDetailProduct(int id) async {
    return await _provider.fetchDetailProduct(id);
  }

  Future<ProductModel> createProduct(ProductModel model) async {
    return await _provider.createProduct(model);
  }

  Future<void> updateProduct(ProductModel model, int id) async {
    await _provider.updateProduct(model, id);
  }

  Future<void> deleteProduct(int id) {
    return _provider.deleteProduct(id);
  }

  Future<void> addImageProduct(File image, int id) async {
    FormData formData = FormData.fromMap(
        {"urlImage": await MultipartFile.fromFile(image.path)});
    await _provider.addImageProduct(formData, id);
  }
}

class NetworkError extends Error {}
