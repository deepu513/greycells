part of 'image_picker_bloc.dart';

abstract class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {}

class StateImagePickInProgress extends ImagePickerState {}

class StateImagePicked extends ImagePickerState {
  final File pickedImageFile;

  StateImagePicked(this.pickedImageFile);
}
