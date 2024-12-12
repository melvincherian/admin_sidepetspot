part of 'foodeditimage_bloc.dart';

@immutable
sealed class FoodeditimageEvent {}



class FoodEditImagePicker extends FoodeditimageEvent {}

class UploadImagesToCloudinaryEvent extends FoodeditimageEvent{
  final List<File> images;

  UploadImagesToCloudinaryEvent(this.images);
} 

class ClearImagesEvent extends FoodeditimageEvent {}