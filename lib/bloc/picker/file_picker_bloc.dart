import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'file_picker_event.dart';

part 'file_picker_state.dart';

class FilePickerBloc extends Bloc<FilePickerEvent, FilePickerState> {
  List<PickedFile> pickedFiles;

  FilePickerBloc() : super(FilePickerInitial()) {
    pickedFiles = List<PickedFile>();
  }

  @override
  Stream<FilePickerState> mapEventToState(FilePickerEvent event) async* {
    if (event is PickImageFile) {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 30,
      );

      if (pickedFile != null) {
        var file = File(pickedFile.path);
        String dirName = dirname(file.path);
        String newPath = join(dirName, 'IMG_${DateTime.now().millisecondsSinceEpoch}');
        var renamedFile = file.renameSync(newPath);
        var mPickedFile = PickedFile(SelectableFileType.IMAGE, renamedFile);
        pickedFiles.add(mPickedFile);
        yield ImageFilePicked(mPickedFile);
      } else
        yield FilePickCancelled();
    }

    if (event is PickPdfFile) {
      File file = await FilePicker.getFile(
          type: FileType.custom, allowedExtensions: ["pdf"]);

      if (file != null) {
        if (extension(file.path) == ".pdf") {
          if (file.lengthSync() <= 2097152 /* 2MB */) {
            var pickedFile = PickedFile(SelectableFileType.PDF, file);
            pickedFiles.add(pickedFile);
            yield PdfFilePicked(pickedFile);
          } else
            yield FileSizeTooLarge();
        } else
          yield UnsupportedFilePicked();
      } else
        yield FilePickCancelled();
    }

    if(event is RemoveFile) {
      pickedFiles.remove(event.pickedFile);
      yield FileRemoved();
    }
  }
}

enum SelectableFileType {
  PDF, IMAGE
}

class PickedFile {
  final SelectableFileType selectableFileType;
  final File selectedFile;

  PickedFile(this.selectableFileType, this.selectedFile);
}
