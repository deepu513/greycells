import 'package:flutter/material.dart';
import 'package:greycells/flavor_config.dart';
import 'package:greycells/gercells_app.dart';
import 'package:greycells/route/route_name.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.PRODUCTION,
      initialRoute: RouteName.INITIAL,
      flavorValues:
          FlavorValues(baseUrl: "http://www.greycellswellness.com/api/"));

  runApp(GreyCellsApp());
}
