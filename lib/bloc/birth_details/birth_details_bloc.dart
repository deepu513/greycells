import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/models/birth_details/birth_details.dart';
import 'package:meta/meta.dart';

part 'birth_details_event.dart';
part 'birth_details_state.dart';

class BirthDetailsBloc extends Bloc<BirthDetailsEvent, BirthDetailsState> {

  BirthDetails birthDetails;

  BirthDetailsBloc() : super(BirthDetailsInitial()) {
   birthDetails = BirthDetails();
  }

  @override
  Stream<BirthDetailsState> mapEventToState(
    BirthDetailsEvent event,
  ) async* {

  }
}
