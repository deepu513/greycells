import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greycells/constants/strings.dart';
import 'package:greycells/models/therapist/all_therapists.dart';
import 'package:greycells/models/therapist/therapist.dart';
import 'package:greycells/repository/therapist_repository.dart';

part 'therapist_event.dart';
part 'therapist_state.dart';

class TherapistBloc extends Bloc<TherapistEvent, TherapistState> {
  TherapistRepository _therapistRepository;

  TherapistBloc() : super(TherapistInitial()) {
    _therapistRepository = TherapistRepository();
  }

  @override
  Stream<TherapistState> mapEventToState(
    TherapistEvent event,
  ) async* {
    if (event is LoadTherapists) {
      yield TherapistsLoading();
      try {
        AllTherapists allTherapists =
            await _therapistRepository.getTherapists(1);
        yield TherapistsLoaded(allTherapists.availableTherapists);
      } catch (e) {
        yield TherapistsLoadError(ErrorMessages.GENERIC_ERROR_MESSAGE);
      }
    }
  }
}
