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





