// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petspot_admin_side/firebase/breed_session.dart';
import 'package:petspot_admin_side/infrastructure/models/breed_model.dart';

part 'breed_event.dart';
part 'breed_state.dart';

class BreedBloc extends Bloc<BreedEvent, BreedState> {
  final BreedRepository breedRepository;

  BreedBloc(this.breedRepository) : super(BreedInitial()) {
    on<FetchBreedsEvent>((event, emit) async {
      emit(BreedLoading());
      try {
        final breedStream = breedRepository.fetchBreeds();
        await emit.forEach<List<BreedModel>>(breedStream, onData: (breeds) {
          return BreedLoaded(breeds);
        });
      } catch (e) {
        emit(BreedError('Failed to fetch breeds $e'));
      }
    });

    on<AddBreedEvent>((event, emit) async {
      emit(BreedLoading());
      try {
        await breedRepository.addBreed(event.breed);
        emit(BreedSuccess('Breed Added Successfully'));
      } catch (e) {
        emit(BreedError('Failed to Add breeds$e'));
      }
    });

    on<UpdateBreedEvent>((event, emit) async {
      emit(BreedLoading());
      try {
        await breedRepository.updateBreed(event.breed);
        emit(BreedSuccess('Breed Updated Successfully'));
      } catch (e) {
        emit(BreedError('Failed to update breeds$e'));
      }
    });

    on<DeleteBreedEvent>(
      (event, emit) async {
        emit(BreedLoading());
        try {
          await breedRepository.deleteBreed(event.id);
          emit(BreedSuccess('Breed Deleted Successfully'));
        } catch (e) {
          emit(BreedError('Failed to delete Breeds $e'));
        }
      },
    );
  }
}
