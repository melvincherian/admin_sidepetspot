part of 'foodproduct_bloc.dart';

@immutable
sealed class FoodproductState {}

final class FoodproductInitial extends FoodproductState {}

final class FoodproductLoading extends FoodproductState{}

final class FoodProductSuccess extends FoodproductState{
  final String message;

 FoodProductSuccess(this.message);
}

final class FoodProductFailure extends FoodproductState{
  final String error;

  FoodProductFailure(this.error);
}

