part of 'editaccesoryimage_bloc.dart';

@immutable
sealed class EditaccesoryimageEvent {}



class EditAccessoryImagePicker extends EditaccesoryimageEvent {}

class UploadImagesToCloudinaryEvent extends EditaccesoryimageEvent{
  final List<File> images;

  UploadImagesToCloudinaryEvent(this.images);
} 

class ClearImagesEvent extends EditaccesoryimageEvent {}