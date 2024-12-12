part of 'couroselimage_bloc.dart';

@immutable
sealed class CouroselimageState {}

final class CouroselimageInitial extends CouroselimageState {}


class CarouselImageLoading extends CouroselimageState {}

class CarouselImageLoaded extends CouroselimageState {
  final List<Map<String, dynamic>> images;

  CarouselImageLoaded(this.images);

}

class CouroselImagerror extends CouroselimageState{
  final String error;

  CouroselImagerror(this.error);
}

class CouroselImageSuccess extends CouroselimageState{
  final String message;

  CouroselImageSuccess(this.message);
}
