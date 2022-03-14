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

    on<GetProductDetailEvent>((event, emit) async {
      try {
        if (event.id == null) {
          emit(ProductSingleLoaded(ProductModel()));
        } else {
          emit(ProductLoading());
          var product = await _apiRepository.fetchDetailProduct(event.id!);
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
            await _apiRepository.createProduct(event.productModel!);

        if (event.image != null) {
          await _apiRepository.addImageProduct(event.image!, product.id!);
        }

        var products = await _apiRepository.fetchProductList();
        emit(ProductLoaded(products));
      } catch (msg) {
        emit(ProductError('Erro ao cadastrar produto: $msg'));
      }
    });

    on<UpdateProductEvent>((event, emit) async {
      try {
        emit(ProductProcessLoading());

        await _apiRepository.updateProduct(event.productModel, event.id);

        if (event.image != null) {
          await _apiRepository.addImageProduct(event.image!, event.id);
        }

        // else if(event.image!.path == ''){
        //   await _apiRepository.removeImageProduct(event.id);
        // }

        var products = await _apiRepository.fetchProductList();
        emit(ProductLoaded(products));
      } catch (msg) {
        emit(ProductError('Erro ao cadastrar produto: $msg'));
      }
    });

    on<DeleteProductEvent>((event, emit) async {
      try {
        final products = (state as ProductLoaded).productsModel;
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
}
