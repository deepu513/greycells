import 'package:flutter/material.dart';
import 'package:greycells/flavor_config.dart';
import 'package:greycells/greycells_app.dart';
import 'package:greycells/route/route_name.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.DEVELOPMENT,
      initialRoute: RouteName.INITIAL,
      flavorValues:
          FlavorValues(baseUrl: "https://www.greycellswellness.com/api/"));

  runApp(GreyCellsApp());
}
