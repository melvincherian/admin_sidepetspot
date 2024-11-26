part of 'multipleimage_bloc.dart';

@immutable
sealed class MultipleimageEvent {}


class MultiPickImageEvent extends MultipleimageEvent {}

class UploadImagesToCloudinaryEvent extends MultipleimageEvent {
  final List<File> images;

  UploadImagesToCloudinaryEvent(this.images);
} 