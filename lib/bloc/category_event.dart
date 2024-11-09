part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}


class AddcategoryEvent extends CategoryEvent{
  final Category category;
  
  AddcategoryEvent(this.category);
}

class FetchCategoriesEvent extends CategoryEvent {} 