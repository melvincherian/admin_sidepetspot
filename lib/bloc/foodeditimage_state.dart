part of 'foodeditimage_bloc.dart';

@immutable
sealed class FoodeditimageState {}

final class FoodeditimageInitial extends FoodeditimageState {}



class FoodEditImageLoading extends FoodeditimageState {}




class FoodEditImageSuccess extends FoodeditimageState{

final List<File> images;

FoodEditImageSuccess(this.images);

}

class FoodEditImageFailure extends FoodeditimageState{

final String errormessage;

FoodEditImageFailure(this.errormessage);

}