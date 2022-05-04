import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mylife/models/product.dart';

import '../../resources/product/product_service.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    final ProductService productService = ProductService();

    on<GetProductListEvent>((event, emit) async {
      try {
        emit(ProductLoading());
        var products = await productService.fetchProductList();
        emit(ProductLoaded(products));
      } catch (msg) {
        emit(ProductError("Erro ao carregar produtos: $msg"));
      }
    });

    on<GetProductDetailEvent>((event, emit) async {
      try {
        if (event.id == null) {
          emit(ProductSingleLoaded(ProductModel()));
        } else {
          emit(ProductLoading());
          var product = await productService.fetchDetailProduct(event.id!);
          emit(ProductSingleLoaded(product));
        }
      } catch (msg) {
        emit(ProductError("Erro ao carregar produtos: $msg"));
      }
    });

    on<RegisterProductEvent>((event, emit) async {
      try {
        emit(ProductProcessLoading());
        ProductModel product =
            await productService.createProduct(event.productModel!);

        if (event.image != null) {
          await productService.addImageProduct(event.image!, product.id!);
        }

        var products = await productService.fetchProductList();
        emit(ProductLoaded(products));
      } catch (msg) {
        emit(ProductError('Erro ao cadastrar produto: $msg'));
      }
    });

    on<UpdateProductEvent>((event, emit) async {
      try {
        emit(ProductProcessLoading());

        await productService.updateProduct(event.productModel, event.id);

        if (event.image != null) {
          await productService.addImageProduct(event.image!, event.id);
        }

        // else if(event.image!.path == ''){
        //   await productService.removeImageProduct(event.id);
        // }

        var products = await productService.fetchProductList();
        emit(ProductLoaded(products));
      } catch (msg) {
        emit(ProductError('Erro ao atualizar produto: $msg'));
      }
    });

    on<DeleteProductEvent>((event, emit) async {
      try {
        final products = (state as ProductLoaded).productsModel;
        if (state is ProductLoaded) {
          emit(ProductLoading());
          await productService
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
}
