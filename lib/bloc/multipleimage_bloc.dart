// ignore_for_file: depend_on_referenced_packages, unnecessary_nullable_for_final_variable_declarations

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'multipleimage_event.dart';
part 'multipleimage_state.dart';

class MultipleimageBloc extends Bloc<MultipleimageEvent, MultipleimageState> {

 final ImagePicker _picker=ImagePicker();


  MultipleimageBloc() : super(MultipleimageInitial()) {
    on<MultipleimageEvent>((event, emit)async {
      try {
        final List<XFile>? pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles != null && pickedFiles.isNotEmpty) {
          emit(MultipleImagesuccess(pickedFiles.map((file) => File(file.path)).toList()));
        } else {
          emit(MultipleImageFailure("No images selected"));
        }
      } catch (e) {
        emit(MultipleImageFailure("Failed to pick images: ${e.toString()}"));
      }
    });
    
  }
}
