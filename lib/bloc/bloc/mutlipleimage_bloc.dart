import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mutlipleimage_event.dart';
part 'mutlipleimage_state.dart';

class MutlipleimageBloc extends Bloc<MutlipleimageEvent, MutlipleimageState> {
  MutlipleimageBloc() : super(MutlipleimageInitial()) {
    on<MutlipleimageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
