part of 'editimage_bloc.dart';

@immutable
sealed class EditimageState {}

final class EditimageInitial extends EditimageState {}


class EditImageLoading extends EditimageState {}




class EditImageSuccess extends EditimageState{

final List<File> images;

EditImageSuccess(this.images);

}

class EditImageFailure extends EditimageState{

final String errormessage;

EditImageFailure(this.errormessage);

}
