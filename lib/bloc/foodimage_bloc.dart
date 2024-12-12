// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'foodimage_event.dart';
part 'foodimage_state.dart';

class FoodimageBloc extends Bloc<FoodimageEvent, FoodimageState> {
  final ImagePicker _picker = ImagePicker();

  FoodimageBloc() : super(FoodimageInitial()) {
    on<FoodimageEvent>((event, emit) async {
      try {
        final List<XFile>? pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles != null && pickedFiles.isNotEmpty) {
          emit(FoodImageSuccess(
              pickedFiles.map((file) => File(file.path)).toList()));
        } else {
          emit(FoodImageFailure("No images selected"));
        }
      } catch (e) {
        emit(FoodImageFailure("Failed to pick images: ${e.toString()}"));
      }
    });
    on<ClearImagesEvent>((event, emit) {
      emit(FoodimageInitial());
    });
  }
}
