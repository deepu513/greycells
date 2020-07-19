import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/models/city/city.dart';
import 'package:mental_health/repository/city/city_repository.dart';

import './bloc.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityRepository _cityRepository;

  CityBloc() {
    _cityRepository = CityRepository();
  }

  @override
  CityState get initialState => CityStateInitial();

  @override
  Stream<CityState> mapEventToState(CityEvent event) async* {
    if (event is LoadCities) {
      yield CityStateLoading();
      List<City> cities = await _cityRepository.getAll();
      yield CitiesLoaded(cityList: cities);
    }
  }
}
