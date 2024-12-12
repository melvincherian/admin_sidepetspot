// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'breedimagebloc_event.dart';
part 'breedimagebloc_state.dart';

class BreedimageblocBloc extends Bloc<BreedimageblocEvent, BreedimageblocState> {

   final ImagePicker _picker=ImagePicker();
  BreedimageblocBloc() : super(BreedimageblocInitial()) {
    on<BreedimageblocEvent>((event, emit)async {
        try {
        final List<XFile>? pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles != null && pickedFiles.isNotEmpty) {
          emit(BreedImageSuccess(pickedFiles.map((file) => File(file.path)).toList()));
        } else {
          emit(BreedImageFailure("No images selected"));
        }
      } catch (e) {
        emit(BreedImageFailure("Failed to pick images: ${e.toString()}"));
      }
    });
    on<ClearImagesEvent>((event, emit) {
      emit(BreedimageblocInitial());
    });
    
  }
}
