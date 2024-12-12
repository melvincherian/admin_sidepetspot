part of 'accesoryimage_bloc.dart';

@immutable
sealed class AccesoryimageState {}

final class AccesoryimageInitial extends AccesoryimageState {}


class AccessoryImageLoading extends AccesoryimageState {}




class AccessoryImageSuccess extends AccesoryimageState{

final List<File> images;

AccessoryImageSuccess(this.images);

}

class AccessoryImageFailure extends AccesoryimageState{

final String errormessage;

AccessoryImageFailure(this.errormessage);

}