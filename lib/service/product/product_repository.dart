import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mylife/models/product.dart';
import 'package:mylife/service/base_repository.dart';

class ProductRepository extends BaseRepository {
  Future<List<ProductModel>> fetchProductList() async {
    try {
      Response response = await dio.get(url[env]! + '/product');
      var array = jsonDecode(response.data) as List;
      var product = List<ProductModel>.empty();
      if (array.isNotEmpty) {
        product = (array).map((data) => ProductModel.fromJson(data)).toList();
      }
      return product;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      throw Exception(error);
    }
  }

  Future<ProductModel> fetchDetailProduct(int id) async {
    try {
      Response response = await dio.get(url[env]! + '/product/$id');
      ProductModel product = ProductModel.fromJson(response.data);
      return product;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<ProductModel> createProduct(ProductModel model) async {
    try {
      Response response =
          await dio.post(url[env]! + '/product/register', data: model.toJson());
      ProductModel product = ProductModel.fromJson(response.data['data']);
      return product;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<void> updateProduct(ProductModel model, int id) async {
    try {
      await dio.put(url[env]! + '/product/update/$id', data: model.toJson());
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<void> deleteProduct(id) async {
    try {
      await dio.delete(url[env]! + '/product/delete/$id');
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<void> addImageProduct(FormData formData, int id) async {
    try {
      await dio.post(
        url[env]! + '/product/addImage/$id',
        data: formData,
      );
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }
}
