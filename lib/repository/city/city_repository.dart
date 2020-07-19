import 'package:mental_health/models/city/city.dart';
import 'package:mental_health/models/city/city_serializable.dart';
import 'package:mental_health/networking/http_service.dart';

class CityRepository {
  var _citySerializable;

  HttpService<City, CitySerializable> _cityHttpService;

  CityRepository() {
    _citySerializable = CitySerializable();
    _cityHttpService = HttpService(_citySerializable);
  }

  Future<List<City>> getAll() async {
    return _cityHttpService.getAll("/city/all");
  }
}