import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greycells/models/address/address.dart';
import 'package:meta/meta.dart';

part 'address_details_event.dart';
part 'address_details_state.dart';

class AddressDetailsBloc
    extends Bloc<AddressDetailsEvent, AddressDetailsState> {
  Address address;

  AddressDetailsBloc() : super(AddressDetailsInitial()) {
    address = Address();
  }

  @override
  Stream<AddressDetailsState> mapEventToState(
    AddressDetailsEvent event,
  ) async* {}
}