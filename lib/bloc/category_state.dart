part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryAddedsuccess extends CategoryState {}

final class CategoryError extends CategoryState{
  final String message;

  CategoryError(this.message);
}

class CategoriesFetched extends CategoryState {
  final List<Category> categories;
  CategoriesFetched(this.categories);
}

class CategoryLoadeded extends CategoryState {
  final List<String> categories;
  final String? selectedCategory;
  CategoryLoadeded(this.categories, this.selectedCategory);
}




// class CategoryLoaded extends CategoryState {
//   final List<Category> categories;

//   CategoryLoaded(this.categories);
// }







