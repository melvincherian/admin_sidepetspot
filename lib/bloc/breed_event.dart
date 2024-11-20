part of 'breed_bloc.dart';

@immutable
sealed class BreedEvent {}

final class FetchBreedsEvent extends BreedEvent{}

class AddBreedEvent extends BreedEvent{

final BreedModel breed;

AddBreedEvent(this.breed);

}

class UpdateBreedEvent extends BreedEvent{

final BreedModel breed;

UpdateBreedEvent(this.breed);

}

class DeleteBreedEvent extends BreedEvent{

final String id;

DeleteBreedEvent(this.id);

}
