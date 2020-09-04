import 'package:flutter/material.dart';
import 'package:greycells/flavor_config.dart';
import 'package:greycells/gercells_app.dart';
import 'package:greycells/route/route_name.dart';

void main() {
  FlavorConfig(
      flavor: Flavor.PRODUCTION,
      initialRoute: RouteName.INITIAL,
      flavorValues: FlavorValues(baseUrl: "https://localhost:8080"));

  //  HttpService([
//    //TODO: Check if the build is debug build, then only add this interceptor
//  LoggingInterceptor(),
//  RequestHeaderInterceptor(await SettingsRepository.getInstance())
//  ], () {
//  // on session expired, should add event in bloc,
//  // which will output a state and logout user.
//  });

  runApp(GreyCellsApp());
}
