import 'package:mental_health/models/city/city.dart';
import 'package:mental_health/networking/serializable.dart';

class CitySerializable implements Serializable<City> {
  @override
  City fromJson(Map<String, dynamic> json) {
    return City.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(City city) {
    return city.toJson();
  }

  @override
  List<City> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray?.map((cityMap) =>
    cityMap == null ? null : fromJson(cityMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<City> cityList) {
    return cityList?.map((user) => user?.toJson())?.toList();
  }
}
