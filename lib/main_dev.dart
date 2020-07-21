import 'package:flutter/material.dart';
import 'package:mental_health/route/route_name.dart';
import 'package:mental_health/flavor_config.dart';
import 'package:mental_health/mental_health_app.dart';


void main() {
  FlavorConfig(flavor: Flavor.DEVELOPMENT,
      initialRoute: RouteName.INITIAL,
      flavorValues: FlavorValues(baseUrl: "http://192.168.0.106:8080"));

  runApp(MentalHealthApp());
}