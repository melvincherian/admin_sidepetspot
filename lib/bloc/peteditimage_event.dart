part of 'peteditimage_bloc.dart';

@immutable
sealed class PeteditimageEvent {}


class PetEditImagePicker extends PeteditimageEvent {}

class UploadImagesToCloudinaryEvent extends PeteditimageEvent{
  final List<File> images;

  UploadImagesToCloudinaryEvent(this.images);
} 

class ClearImagesEvent extends PeteditimageEvent {}