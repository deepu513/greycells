import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greycells/models/therapist/therapist_type.dart';
import 'package:greycells/repository/therapist_repository.dart';

part 'therapist_type_event.dart';
part 'therapist_type_state.dart';

class TherapistTypeBloc extends Bloc<TherapistTypeEvent, TherapistTypeState> {
  TherapistRepository _therapistRepository;
  List<TherapistType> cachedTherapistTypes;

  TherapistTypeBloc() : super(TherapistTypeInitial()) {
    _therapistRepository = TherapistRepository();
  }

  @override
  Stream<TherapistTypeState> mapEventToState(
    TherapistTypeEvent event,
  ) async* {
    if (event is LoadTherapistTypes) {
      yield TherapistTypesLoading();
      try {
        if (cachedTherapistTypes == null) {
          var result = await _therapistRepository.getTherapistTypes();
          cachedTherapistTypes = result.therapytypes;
          cachedTherapistTypes.insert(
              0,
              TherapistType()
                ..name = "All"
                ..id = -1);
        }

        if (cachedTherapistTypes != null && cachedTherapistTypes.isNotEmpty) {
          yield TherapistTypesLoaded(cachedTherapistTypes);
        } else
          yield TherapistTypesEmpty();
      } catch (e) {
        yield TherapistTypesError();
      }
    }
  }
}
