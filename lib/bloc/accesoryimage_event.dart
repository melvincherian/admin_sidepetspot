part of 'accesoryimage_bloc.dart';

@immutable
sealed class AccesoryimageEvent {}


class AccesoryImagepicker extends AccesoryimageEvent {}

class UploadImagesToCloudinaryEvent extends AccesoryimageEvent {
  final List<File> images;

  UploadImagesToCloudinaryEvent(this.images);
} 

class ClearImagesEvent extends AccesoryimageEvent {}
