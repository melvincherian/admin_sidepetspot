// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'foodeditimage_event.dart';
part 'foodeditimage_state.dart';

class FoodeditimageBloc extends Bloc<FoodeditimageEvent, FoodeditimageState> {

   final ImagePicker _picker = ImagePicker();

  FoodeditimageBloc() : super(FoodeditimageInitial()) {
    on<FoodeditimageEvent>((event, emit)async {
       try {
        final List<XFile>? pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles != null && pickedFiles.isNotEmpty) {
          emit(FoodEditImageSuccess(
              pickedFiles.map((file) => File(file.path)).toList()));
        } else {
          emit(FoodEditImageFailure("No images selected"));
        }
      } catch (e) {
        emit(FoodEditImageFailure("Failed to pick images: ${e.toString()}"));
      }
    });
    on<ClearImagesEvent>((event, emit) {
      emit(FoodeditimageInitial());
    });
  }
}