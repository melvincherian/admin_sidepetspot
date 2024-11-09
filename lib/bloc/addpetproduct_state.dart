part of 'addpetproduct_bloc.dart';

@immutable
sealed class AddpetproductState {}

final class AddpetproductInitial extends AddpetproductState {}

final class ProductLoading extends AddpetproductState{}

final class AddpetproductSuccess extends AddpetproductState {
  
}

final class ProductLoaded extends AddpetproductState{

final List<petProductModel>products;
ProductLoaded(this.products);

}

final class ProductError extends AddpetproductState{
  final String errormessage;

  ProductError(this.errormessage);
}

final class ProductAdded extends AddpetproductState {}

final class UpdateProduct extends AddpetproductState{}

final class DeleteProduct extends AddpetproductState{}


