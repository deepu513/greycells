import 'package:flutter/material.dart';
import 'package:mental_health/constants/route_name.dart';
import 'package:mental_health/flavor_config.dart';
import 'package:mental_health/mental_health_app.dart';

void main() {
  FlavorConfig(flavor: Flavor.PRODUCTION,
      initialRoute: RouteName.INITIAL,
      flavorValues: FlavorValues(baseUrl: "https://localhost:8080"));

  runApp(MentalHealthApp());
}