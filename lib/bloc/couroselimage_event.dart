part of 'couroselimage_bloc.dart';

@immutable
sealed class CouroselimageEvent {}

class LoadCarouselImages extends CouroselimageEvent {}

class AddcarousalImages extends CouroselimageEvent{

final List<String>imageUrls;

AddcarousalImages(this.imageUrls);

}

class DeleteCarousalImage extends CouroselimageEvent{
  final String id;

  DeleteCarousalImage(this.id);
}
