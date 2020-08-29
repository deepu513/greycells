part of 'file_picker_bloc.dart';

@immutable
abstract class FilePickerState {}

class FilePickerInitial extends FilePickerState {}

class ImageFilePicked extends FilePickerState {
  final PickedFile pickedFile;

  ImageFilePicked(this.pickedFile);
}

class PdfFilePicked extends FilePickerState {
  final PickedFile pickedFile;

  PdfFilePicked(this.pickedFile);
}

class FileRemoved extends FilePickerState {}

class UnsupportedFilePicked extends FilePickerState {}

class FileSizeTooLarge extends FilePickerState {}

class FilePickCancelled extends FilePickerState {}
