// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';


part 'accesoryimage_event.dart';
part 'accesoryimage_state.dart';

class AccesoryimageBloc extends Bloc<AccesoryimageEvent, AccesoryimageState> {

 final ImagePicker _picker=ImagePicker();

  AccesoryimageBloc() : super(AccesoryimageInitial()) {
    on<AccesoryimageEvent>((event, emit)async {
            try {
        final List<XFile>? pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles != null && pickedFiles.isNotEmpty) {
          emit(AccessoryImageSuccess(pickedFiles.map((file) => File(file.path)).toList()));
        } else {
          emit(AccessoryImageFailure("No images selected"));
        }
      } catch (e) {
        emit(AccessoryImageFailure("Failed to pick images: ${e.toString()}"));
      }
    });
    on<ClearImagesEvent>((event, emit) {
      emit(AccesoryimageInitial());
    });
    
  }
}
