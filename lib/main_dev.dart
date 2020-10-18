import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greycells/bloc/notification/bloc/notification_bloc.dart';
import 'package:greycells/flavor_config.dart';
import 'package:greycells/greycells_app.dart';
import 'package:greycells/route/route_name.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.DEVELOPMENT,
      initialRoute: RouteName.INITIAL,
      flavorValues:
          FlavorValues(baseUrl: "https://www.greycellswellness.com/api/"));

  runApp(BlocProvider(
    create: (context) => NotificationBloc(),
    child: GreyCellsApp(),
  ));
}
