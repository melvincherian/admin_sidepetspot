part of 'breed_bloc.dart';

@immutable
sealed class BreedState {}

final class BreedInitial extends BreedState {}


class BreedLoading extends BreedState{}

class BreedLoaded extends BreedState{

final List<BreedModel>breeds;

BreedLoaded(this.breeds);


}

class BreedError extends BreedState{
  final String error;

  BreedError(this.error);
}

class BreedSuccess extends BreedState{
  final String message;

  BreedSuccess(this.message);
}