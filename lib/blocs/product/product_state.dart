part of 'product_bloc.dart';

@immutable
abstract class ProductState extends Equatable {}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductProcessLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  final List<ProductModel> productsModel;

  ProductLoaded(this.productsModel);

  @override
  List<Object> get props => [productsModel];
}

class ProductSingleLoaded extends ProductState {
  final ProductModel productModel;

  ProductSingleLoaded(this.productModel);

  @override
  List<Object> get props => [productModel];
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);

  @override
  List<Object> get props => [message];
}
