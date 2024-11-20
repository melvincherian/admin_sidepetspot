// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petspot_admin_side/firebase/food_product_model.dart';
import 'package:petspot_admin_side/infrastructure/models/food_product_model.dart';

part 'foodproduct_event.dart';
part 'foodproduct_state.dart';

class FoodproductBloc extends Bloc<FoodproductEvent, FoodproductState> {

final Foodrepository repository;

  FoodproductBloc({required this.repository}) : super(FoodproductInitial()) {
    on<AddfoodEvent>(_onAddFoodproduct);
    
       
    
  }
  Future<void>_onAddFoodproduct(AddfoodEvent event,Emitter<FoodproductState>emit)async{
    emit(FoodproductLoading());
    try{
      await repository.addFoodproduct(event.foodproduct);
      emit(FoodProductSuccess('Food Product Added Successfully'));
    }catch(e){
      emit(FoodProductFailure('Error adding Food Product$e'));
    }
  }
}
