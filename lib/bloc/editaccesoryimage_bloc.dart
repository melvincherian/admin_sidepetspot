// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'editaccesoryimage_event.dart';
part 'editaccesoryimage_state.dart';

class EditaccesoryimageBloc extends Bloc<EditaccesoryimageEvent, EditaccesoryimageState> {

final ImagePicker _picker = ImagePicker();

  EditaccesoryimageBloc() : super(EditaccesoryimageInitial()) {
    on<EditaccesoryimageEvent>((event, emit)async {
        try {
        final List<XFile>? pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles != null && pickedFiles.isNotEmpty) {
          emit(EditaccessoryImageSuccess(
              pickedFiles.map((file) => File(file.path)).toList()));
        } else {
          emit(EditaccessoryImageFailure("No images selected"));
        }
      } catch (e) {
        emit(EditaccessoryImageFailure("Failed to pick images: ${e.toString()}"));
      }
    });
    on<ClearImagesEvent>((event, emit) {
      emit(EditaccesoryimageInitial());
    });
  }
}
