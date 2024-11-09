part of 'imagepicker_bloc.dart';

@immutable
sealed class ImagepickerState {}

final class ImagepickerInitial extends ImagepickerState {}

final class ImagepickerSuccess extends ImagepickerState{
  final File imageFile;

  ImagepickerSuccess(this.imageFile);
}

final class ImagepickerFailure extends ImagepickerState{
final  String message;

ImagepickerFailure(this.message);
}