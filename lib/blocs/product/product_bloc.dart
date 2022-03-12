import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mylife/models/product.dart';
import 'package:mylife/resources/api_repository.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetProductListEvent>((event, emit) async {
      try {
        emit(ProductLoading());
        var products = await _apiRepository.fetchProductList();
        emit(ProductLoaded(products));
      } catch (msg) {
        emit(ProductError("Erro ao carregar produtos: $msg"));
      }
    });

    on<RegisterProductEvent>((event, emit) async {
      try {
        emit(ProductLoading());
        ProductModel? product =
            await _apiRepository.createProduct(event.productModel!);

        if (event.image != null) {
          await _apiRepository.addImageProduct(
              event.image!, int.parse(product!.id.toString()));
        }

        if (product != null) {
          var products = await _apiRepository.fetchProductList();
          emit(ProductLoaded(products));
        }
      } catch (msg) {
        emit(ProductError('Erro ao cadastrar produto: $msg'));
      }
    });

    on<DeleteProductEvent>((event, emit) async {
      try {
        final products = (state as ProductLoaded).productModel;
        if (state is ProductLoaded) {
          emit(ProductLoading());
          await _apiRepository
              .deleteProduct(int.parse(event.productModel.id.toString()));
          final deleteProduct = products
              .where((productModel) => productModel.id != event.productModel.id)
              .toList();
          emit(ProductLoaded(deleteProduct));
        }
      } catch (msg) {
        emit(ProductError("Erro ao deletar produto: $msg"));
      }
    });
  }

  // Future<void> _mapProductAddedToState(
  //     RegisterProductEvent event, Emitter<ProductState> emit) async {
  //   try {
  //     if (state is ProductLoaded) {
  //       var newProduct =
  //           (await _apiRepository.createProduct(event.productModel));
  //       List<ProductModel> updatedProducts;
  //       if (newProduct != null) {
  //         updatedProducts = List.from((state as ProductLoaded).productModel)
  //           ..add(newProduct);

  //         emit(ProductLoaded(updatedProducts.reversed.toList()));
  //       }
  //     }
  //   } catch (_) {
  //     emit(ProductError("error Add Product"));
  //   }
  // }

  // Future<void> _mapProductUpdatedToState(
  //     UpdateProductEvent event, Emitter<ProductState> emit) async {
  //   try {
  //     if (state is ProductLoaded) {
  //       // var updatedProduct = (await _apiRepository.updateProduct(event.productModel));
  //       // if (updatedProduct != null) {
  //       //   final List<ProductModel> updatedProducts =
  //       //       (state as ProductLoaded).productModel.map((productModel) {
  //       //     return productModel.id == updatedProduct.id ? updatedProduct : productModel;
  //       //   }).toList();

  //       //   yield ProductLoaded(updatedProducts);
  //       // }
  //     }
  //   } catch (_) {
  //     emit(ProductError("error update productModel"));
  //   }
  // }

  // Future<void> _mapProductDeletedToState(
  //     DeleteProductEvent event, Emitter<ProductState> emit) async {
  //   try {
  //     if (state is ProductLoaded) {
  //       final deletelbum = (state as ProductLoaded)
  //           .productModel
  //           .where((productModel) => productModel.id != event.productModel.id)
  //           .toList();
  //       emit(ProductLoaded(deletelbum));
  //     }
  //   } catch (_) {
  //     emit(ProductError("error delete productModel"));
  //   }
  // }
}
