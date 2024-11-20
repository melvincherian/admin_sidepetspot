// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petspot_admin_side/firebase/accesory_product.dart';
import 'package:petspot_admin_side/infrastructure/models/product_accessories_model.dart';
part 'accessories_event.dart';
part 'accessories_state.dart';

class AccessoriesBloc extends Bloc<AccessoriesEvent, AccessoriesState> {

  final AccessoryRepository accessoryRepository;


  AccessoriesBloc({required this.accessoryRepository})
    : super(AccessoriesInitial()) {
    on<AddAccessoriesevent>(_onAddAccessories);
    // on<LoadAccessoriesevent>(_onLoadAccessories);
    // on<UpdateAccessoriesEvent>(_onUpdateAccessories);
    // on<DeleteAccesoriesEvent>(_onDeleteAccessories);
  }

  Future<void> _onAddAccessories(
      AddAccessoriesevent event, Emitter<AccessoriesState> emit) async {
    emit(AccessoriesLoading());
    try {
      await accessoryRepository.addAccessories(event.accesories);
      emit(AccessoriesSuccess('Accessory added successfully'));
    } catch (e) {
      emit(AccessoriesFailure('Failed to add accessory: $e'));
    }
  }

  // Future<void> _onLoadAccessories(
  //     LoadAccessoriesevent event, Emitter<AccessoriesState> emit) async {
  //   emit(AccessoriesLoading());

  //   try {
  //     await emit.forEach<List<ProductAccessoriesModel>>(
  //       accessoryRepository.fetchAccesories(), // Stream from the repository
  //       onData: (accessories) => AccessoriesLoaded(accessories),
  //       onError: (error, stackTrace) =>
  //           AccessoriesFailure('Failed to load accessories: $error'),
  //     );
  //   } catch (e) {
  //     emit(AccessoriesFailure('Failed to load accessories: $e'));
  //   }
  // }

  // Future<void> _onUpdateAccessories(
  //   UpdateAccessoriesEvent event,
  //   Emitter<AccessoriesState> emit,
  // ) async {
  //   emit(AccessoriesLoading());
  //   try {
  //     await accessoryRepository.updateAccessories(event.accesories);
  //     emit(AccessoriesSuccess('Accessory updated successfully'));
  //     await emit.forEach<List<ProductAccessoriesModel>>(
  //       accessoryRepository.fetchAccesories(),
  //       onData: (accessories) => AccessoriesLoaded(accessories),
  //       onError: (error, stackTrace) =>
  //           AccessoriesFailure('Failed to fetch updated accessories: $error'),
  //     );
  //   } catch (e) {
  //     emit(AccessoriesFailure('Failed to update accessory: $e'));
  //   }
  // }

  // Future<void> _onDeleteAccessories(
  //   DeleteAccesoriesEvent event,
  //   Emitter<AccessoriesState> emit,
  // ) async {
  //   emit(AccessoriesLoading());
  //   try {
  //     await accessoryRepository.deleteAccessories(event.id);

  //     emit(AccessoriesSuccess('Accessory deleted successfully'));
  //     await emit.forEach<List<ProductAccessoriesModel>>(
  //       accessoryRepository.fetchAccesories(),
  //       onData: (accessories) => AccessoriesLoaded(accessories),
  //       onError: (error, stackTrace) =>
  //           AccessoriesFailure('Failed to fetch updated accessories: $error'),
  //     );
  //   } catch (e) {
  //     emit(AccessoriesFailure('Failed to delete accessory: $e'));
  //   }
  // }
}
