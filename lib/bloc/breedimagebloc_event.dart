part of 'breedimagebloc_bloc.dart';

@immutable
sealed class BreedimageblocEvent {}




class BreedImagepicker extends BreedimageblocEvent {}

class UploadImagesToCloudinaryEvent extends BreedimageblocEvent{
  final List<File> images;

  UploadImagesToCloudinaryEvent(this.images);
} 

class ClearImagesEvent extends BreedimageblocEvent {}