part of 'accessories_bloc.dart';

@immutable
sealed class AccessoriesEvent {}


class LoadAccessoriesevent extends AccessoriesEvent{}

class AddAccessoriesevent extends AccessoriesEvent{
  final ProductAccessoriesModel accesories;

  AddAccessoriesevent(this.accesories);

}

class UpdateAccessoriesEvent extends AccessoriesEvent{
  final ProductAccessoriesModel accesories;

  UpdateAccessoriesEvent(this.accesories);
}

class DeleteAccesoriesEvent extends AccessoriesEvent{
  final String id;

  DeleteAccesoriesEvent(this.id);
}