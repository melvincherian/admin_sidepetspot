import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'foodproduct_event.dart';
part 'foodproduct_state.dart';

class FoodproductBloc extends Bloc<FoodproductEvent, FoodproductState> {
  FoodproductBloc() : super(FoodproductInitial()) {
    on<FoodproductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
