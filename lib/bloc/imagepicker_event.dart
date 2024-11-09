// ignore_for_file: camel_case_types

part of 'imagepicker_bloc.dart';

@immutable
sealed class ImagepickerEvent {}

class PickImageEvent extends ImagepickerEvent{}

