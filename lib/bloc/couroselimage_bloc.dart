// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petspot_admin_side/firebase/slider_image.dart';

part 'couroselimage_event.dart';
part 'couroselimage_state.dart';

class CouroselimageBloc extends Bloc<CouroselimageEvent, CouroselimageState> {

 final CarouselImageRepository repository;

  CouroselimageBloc(this.repository) : super(CouroselimageInitial()) {
    on<LoadCarouselImages>((event, emit)async {
      emit(CarouselImageLoading());
      try{
        final images=await repository.fetchAllImages();
        emit(CarouselImageLoaded(images));
      }catch(e){
        emit(CouroselImagerror('Failed to load images $e'));
      }
    });

    on<AddcarousalImages>((event, emit) async {
      emit(CarouselImageLoading());
      try {
        await repository.addImageUrls(event.imageUrls);
        add(LoadCarouselImages()); // Reload images after adding
      } catch (e) {
        emit(CouroselImagerror('Failed to add images: $e'));
      }
    });

    on<DeleteCarousalImage>((event, emit) async {
      emit(CarouselImageLoading());
      try {
        await repository.deleteImageSet(event.id);
        add(LoadCarouselImages()); // Reload images after deleting
      } catch (e) {
        emit(CouroselImagerror('Failed to delete image: $e'));
      }
    });
  }
}



