part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductListEvent extends ProductEvent {
  @override
  List<Object> get props => [];
}

class RegisterProductEvent extends ProductEvent {
  final ProductModel? productModel;
  final File? image;
  const RegisterProductEvent(this.productModel, this.image);

  @override
  List<Object> get props => [productModel!];
}

// class RegisterImageProductEvent extends ProductEvent {
//   final File image;

//   const RegisterImageProductEvent(this.image);

//   @override
//   List<Object> get props => [];
// }

class UpdateProductEvent extends ProductEvent {
  final ProductModel productModel;
  final File image;
  const UpdateProductEvent(this.productModel, this.image);

  @override
  List<Object> get props => [productModel];
}

class DeleteProductEvent extends ProductEvent {
  final ProductModel productModel;

  const DeleteProductEvent(this.productModel);

  @override
  List<Object> get props => [productModel];
}
