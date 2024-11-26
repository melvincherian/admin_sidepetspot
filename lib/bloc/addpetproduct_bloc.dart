// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petspot_admin_side/firebase/add_pet_pro.dart';
import 'package:petspot_admin_side/infrastructure/models/pet_add_model.dart';

part 'addpetproduct_event.dart';
part 'addpetproduct_state.dart';

class AddpetproductBloc extends Bloc<AddpetproductEvent, AddpetproductState> {

final ProductRepository productRepository;
// final _addedProductController = StreamController<petProductModel>.broadcast();

//   // Expose the stream to listen to it
//   Stream<petProductModel> get addedProductStream => _addedProductController.stream;


  AddpetproductBloc({required this.productRepository}) : super(AddpetproductInitial()) {
    on<AddproductEvent>(_onAddPetProduct);
     
    }

    Future<void>_onAddPetProduct(AddproductEvent event,Emitter<AddpetproductState>emit)async{
       emit(ProductLoading());
       try{
        await productRepository.addProduct(event.productModel);
        emit(AddpetproductSuccess());
       }catch(e){
        emit(ProductError('Failed to add pet products$e'));
       }
    }
  }

