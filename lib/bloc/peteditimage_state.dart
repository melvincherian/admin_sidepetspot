part of 'peteditimage_bloc.dart';

@immutable
sealed class PeteditimageState {}

final class PeteditimageInitial extends PeteditimageState {}



class PetEditImageLoading extends PeteditimageState {}




class PetEditImageSuccess extends PeteditimageState{

final List<File> images;

PetEditImageSuccess(this.images);

}

class PetEditImageFailure extends PeteditimageState{

final String errormessage;

PetEditImageFailure(this.errormessage);

}
