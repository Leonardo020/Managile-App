import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mylife/models/product.dart';
import 'package:mylife/models/dev.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://fefa-modaintima.herokuapp.com/api';

  Future<List<DevModel>> fetchDevList() async {
    try {
      Response response = await _dio.get(_url + '/dev');
      var array = jsonDecode(response.data) as List;
      var devs = List<DevModel>.empty();
      if (array.isNotEmpty) {
        devs = (array).map((data) => DevModel.fromJson(data)).toList();
      }
      return devs;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      throw Exception(error);
    }
  }

  Future<List<ProductModel>> fetchProductList() async {
    try {
      Response response = await _dio.get(_url + '/product');
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
      Response response = await _dio.get(_url + '/product/$id');
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
          await _dio.post(_url + '/product/register', data: model.toJson());
      ProductModel product = ProductModel.fromJson(response.data['data']);
      return product;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<void> addImageProduct(FormData formData, int id) async {
    try {
      await _dio.post(
        _url + '/product/addImage/$id',
        data: formData,
      );
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<void> deleteProduct(id) async {
    try {
      Response response = await _dio.delete(_url + '/product/delete/$id');
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }
}
