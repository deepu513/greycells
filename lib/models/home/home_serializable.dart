import 'package:greycells/models/home/home.dart';
import 'package:greycells/networking/serializable.dart';

class HomeSerializable implements Serializable<Home> {
  @override
  Home fromJson(Map<String, dynamic> json) {
    return Home.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Home home) {
    return home.toJson();
  }

  @override
  List<Home> fromJsonArray(List<dynamic> jsonArray) {
    return jsonArray
        ?.map((homeMap) => homeMap == null ? null : fromJson(homeMap))
        ?.toList();
  }

  @override
  List<dynamic> toJsonArray(List<Home> homeList) {
    return homeList?.map((home) => home?.toJson())?.toList();
  }
}
