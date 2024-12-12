part of 'editimage_bloc.dart';

@immutable
sealed class EditimageEvent {}



class EditimagePicker extends EditimageEvent {}

class UploadImagesToCloudinaryEvent extends EditimageEvent{
  final List<File> images;

  UploadImagesToCloudinaryEvent(this.images);
} 

class ClearImagesEvent extends EditimageEvent {}