part of 'foodproduct_bloc.dart';

@immutable
sealed class FoodproductEvent {}

 class AddfoodEvent extends FoodproductEvent{
  final FoodProductModel foodproduct;

  AddfoodEvent(this.foodproduct);
}

 class FetchFoodEvent extends FoodproductEvent{}

 class UpdateFoodEvent extends FoodproductEvent{
  final FoodProductModel foodproduct;

  UpdateFoodEvent(this.foodproduct);

}

final class DeleteFoodEvent extends FoodproductEvent{

final FoodProductModel foodproduct;

DeleteFoodEvent(this.foodproduct);
 
}

