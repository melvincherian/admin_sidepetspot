// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'peteditimage_event.dart';
part 'peteditimage_state.dart';

class PeteditimageBloc extends Bloc<PeteditimageEvent, PeteditimageState> {

  final ImagePicker _picker = ImagePicker();

  PeteditimageBloc() : super(PeteditimageInitial()) {
    on<PeteditimageEvent>((event, emit)async {
           try {
        final List<XFile>? pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles != null && pickedFiles.isNotEmpty) {
          emit(PetEditImageSuccess(
              pickedFiles.map((file) => File(file.path)).toList()));
        } else {
          emit(PetEditImageFailure("No images selected"));
        }
      } catch (e) {
        emit(PetEditImageFailure("Failed to pick images: ${e.toString()}"));
      }
    });
    on<ClearImagesEvent>((event, emit) {
      emit(PeteditimageInitial());
    });
  }
    

}