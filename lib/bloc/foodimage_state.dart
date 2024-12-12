part of 'foodimage_bloc.dart';

@immutable
sealed class FoodimageState {}

final class FoodimageInitial extends FoodimageState {}


class FoodImageLoading extends FoodimageState {}




class FoodImageSuccess extends FoodimageState{

final List<File> images;

FoodImageSuccess(this.images);

}

class FoodImageFailure extends FoodimageState{

final String errormessage;

FoodImageFailure(this.errormessage);

}