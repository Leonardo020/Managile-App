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

class ProductLoaded extends ProductState {
  final List<ProductModel> productModel;

  ProductLoaded(this.productModel);

  @override
  List<Object> get props => [productModel];
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);

  @override
  List<Object> get props => [message];
}

// class ProductRegisterState extends ProductState {
//   final bool isBusy;
//   final FieldError? titleError;
//   final bool submissionSuccess;
//   ProductRegisterState({
//     this.isBusy = false,
//     this.titleError,
//     this.submissionSuccess = false,
//   });
// }
