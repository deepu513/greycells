import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/models/address/address.dart';
import 'package:meta/meta.dart';

part 'address_details_event.dart';
part 'address_details_state.dart';

class AddressDetailsBloc extends Bloc<AddressDetailsEvent, AddressDetailsState> {
  Address address;

  AddressDetailsBloc() : super(AddressDetailsInitial());

  @override
  Stream<AddressDetailsState> mapEventToState(
    AddressDetailsEvent event,
  ) async* {

  }
}
