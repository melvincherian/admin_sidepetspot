part of 'imagepicker_bloc.dart';

@immutable
sealed class ImagepickerState {}

final class ImagepickerInitial extends ImagepickerState {}

class ImagepickerLoading extends ImagepickerState {}

final class ImagepickerSuccess extends ImagepickerState{
  final File imageFile;

  ImagepickerSuccess(this.imageFile);
}

final class ImagepickerFailure extends ImagepickerState{
final  String message;

ImagepickerFailure(this.message);
}

final class CloudinaryUploadSuccess extends ImagepickerState {
  final String imageUrl; // URL of the uploaded image

  CloudinaryUploadSuccess(this.imageUrl);
}

final class ImageUploadMessage extends ImagepickerState {
  final String message;

  ImageUploadMessage(this.message);
}
