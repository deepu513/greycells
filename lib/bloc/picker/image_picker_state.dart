part of 'image_picker_bloc.dart';

abstract class ImagePickerState {
  final File pickedImageFile;

  const ImagePickerState(this.pickedImageFile);
}

class ImagePickerInitial extends ImagePickerState {
  ImagePickerInitial() : super(null);
}

class StateImagePicked extends ImagePickerState {
  final File pickedImageFile;

  StateImagePicked(this.pickedImageFile) : super(pickedImageFile);
}

class StateImagePickCancelled extends ImagePickerState {
  StateImagePickCancelled() : super(null);
}

class StateImageRemoved extends ImagePickerState {
  StateImageRemoved() : super(null);
}
