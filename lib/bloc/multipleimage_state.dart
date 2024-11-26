part of 'multipleimage_bloc.dart';

@immutable
sealed class MultipleimageState {}

final class MultipleimageInitial extends MultipleimageState {}

class MultipleImageUploading extends MultipleimageState {}




class MultipleImagesuccess extends MultipleimageState{

final List<File> images;

MultipleImagesuccess(this.images);

}

class MultipleImageFailure extends MultipleimageState{

final String errormessage;

MultipleImageFailure(this.errormessage);

}