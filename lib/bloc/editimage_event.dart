part of 'editimage_bloc.dart';

@immutable
sealed class EditimageEvent {}



class EditimagePicker extends EditimageEvent {}

class UploadImagesToCloudinaryEvent extends EditimageEvent{
  final List<File> images;

  UploadImagesToCloudinaryEvent(this.images);
} 


class RemoveImageEvent extends EditimageEvent {
  final int index;

  RemoveImageEvent(this.index);
}

class ClearImagesEvent extends EditimageEvent {}