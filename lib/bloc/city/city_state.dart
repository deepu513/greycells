import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mental_health/models/city/city.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityStateInitial extends CityState {}

class CityStateLoading extends CityState {}

class CitiesLoaded extends CityState {
  final List<City> cityList;

  CitiesLoaded({@required this.cityList});

  @override
  List<Object> get props => [cityList];

  @override
  bool get stringify => false;
}

class CityStateError extends CityState {}
