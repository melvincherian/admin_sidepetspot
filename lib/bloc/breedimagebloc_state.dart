part of 'breedimagebloc_bloc.dart';

@immutable
sealed class BreedimageblocState {}

final class BreedimageblocInitial extends BreedimageblocState {}



class BreedImgageLoading extends BreedimageblocState {}




class BreedImageSuccess extends BreedimageblocState{

final List<File> images;

BreedImageSuccess(this.images);

}

class BreedImageFailure extends BreedimageblocState{

final String errormessage;

BreedImageFailure(this.errormessage);

}