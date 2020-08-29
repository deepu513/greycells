part of 'file_picker_bloc.dart';

abstract class FilePickerEvent {}

class PickImageFile extends FilePickerEvent {}

class PickPdfFile extends FilePickerEvent {}

class RemoveFile extends FilePickerEvent {
  final PickedFile pickedFile;

  RemoveFile(this.pickedFile);
}
