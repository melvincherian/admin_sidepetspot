// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'editimage_event.dart';
part 'editimage_state.dart';

class EditimageBloc extends Bloc<EditimageEvent, EditimageState> {
   final ImagePicker _picker = ImagePicker();
  EditimageBloc() : super(EditimageInitial()) {
    on<EditimageEvent>((event, emit)async {
       try {
        final List<XFile>? pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles != null && pickedFiles.isNotEmpty) {
          emit(EditImageSuccess(
              pickedFiles.map((file) => File(file.path)).toList()));
        } else {
          emit(EditImageFailure("No images selected"));
        }
      } catch (e) {
        emit(EditImageFailure("Failed to pick images: ${e.toString()}"));
      }
    });
    on<ClearImagesEvent>((event, emit) {
      emit(EditimageInitial());
    });

    
  }
}