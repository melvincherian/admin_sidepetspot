part of 'foodimage_bloc.dart';

@immutable
sealed class FoodimageEvent {}



class FoodImagePicker extends FoodimageEvent {}

class UploadImagesToCloudinaryEvent extends FoodimageEvent{
  final List<File> images;

  UploadImagesToCloudinaryEvent(this.images);
} 

class ClearImagesEvent extends FoodimageEvent {}