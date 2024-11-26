part of 'accessories_bloc.dart';

@immutable
sealed class AccessoriesState {}

final class AccessoriesInitial extends AccessoriesState {}

class AccessoriesLoading extends AccessoriesState{}

class AccessoriesLoaded extends AccessoriesState{
  final List<ProductAccessoriesModel>accesories;

  AccessoriesLoaded(this.accesories);
}

class AccessoriesSuccess extends AccessoriesState{
  final String message;

  AccessoriesSuccess(this.message);
}

class AccessoriesFailure extends AccessoriesState{
  final String error;

  AccessoriesFailure(this.error);
}


// class AccessoriesCategoriesLoaded extends AccessoriesState {
//   final List<Category> categories;
//   AccessoriesCategoriesLoaded(this.categories);
// }
