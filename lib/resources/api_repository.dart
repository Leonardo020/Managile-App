import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mylife/models/product.dart';

import '../models/dev.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<DevModel>> fetchDevList() {
    return _provider.fetchDevList();
  }

  Future<List<ProductModel>> fetchProductList() async {
    return await _provider.fetchProductList();
  }

  Future<ProductModel> fetchDetailProduct(int id) async {
    return await _provider.fetchDetailProduct(id);
  }

  Future<ProductModel?> createProduct(ProductModel model) async {
    return await _provider.createProduct(model);
  }

  Future<void> addImageProduct(File image, int id) async {
    FormData formData = FormData.fromMap(
        {"urlImage": await MultipartFile.fromFile(image.path)});
    await _provider.addImageProduct(formData, id);
  }

  Future<void> deleteProduct(int id) {
    return _provider.deleteProduct(id);
  }
}

class NetworkError extends Error {}
