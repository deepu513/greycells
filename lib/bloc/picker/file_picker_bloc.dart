import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'file_picker_event.dart';
part 'file_picker_state.dart';

class FilePickerBloc extends Bloc<FilePickerEvent, FilePickerState> {

  FilePickerBloc() {

  }

  @override
  FilePickerState get initialState => FilePickerInitial();

  @override
  Stream<FilePickerState> mapEventToState(
    FilePickerEvent event,
  ) async* {

  }
}
