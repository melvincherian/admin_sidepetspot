part of 'addpetproduct_bloc.dart';

@immutable
sealed class AddpetproductEvent {}

final class AddproductEvent extends AddpetproductEvent {
  final petProductModel productModel;

  AddproductEvent(this.productModel);
}

class FetchProductsEvent extends AddpetproductEvent {}

class UpdateProductEvent extends AddpetproductEvent {
  final petProductModel productModel;

  UpdateProductEvent(this.productModel);
}

class DeleteproductEvent extends AddpetproductEvent {
  final petProductModel productModel;

  DeleteproductEvent(this.productModel);
}
