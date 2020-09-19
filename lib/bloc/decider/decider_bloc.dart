import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'decider_event.dart';
part 'decider_state.dart';

class DeciderBloc extends Bloc<DeciderEvent, DeciderState> {
  DeciderBloc() : super(DeciderInitial());

  @override
  Stream<DeciderState> mapEventToState(
    DeciderEvent event,
  ) async* {

  }
}
