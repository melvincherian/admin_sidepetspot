part of 'editaccesoryimage_bloc.dart';

@immutable
sealed class EditaccesoryimageState {}

final class EditaccesoryimageInitial extends EditaccesoryimageState {}


class EditaccessoryImageLoading extends EditaccesoryimageState {}




class EditaccessoryImageSuccess extends EditaccesoryimageState{

final List<File> images;

EditaccessoryImageSuccess(this.images);

}

class EditaccessoryImageFailure extends EditaccesoryimageState{

final String errormessage;

EditaccessoryImageFailure(this.errormessage);

}

