part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerEvent {}

class PickImage extends ImagePickerEvent {
  final ImageSource source;

  PickImage(this.source);
}

class RemoveSelectedImage extends ImagePickerEvent {}