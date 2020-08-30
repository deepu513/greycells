import 'package:flutter/material.dart';
import 'package:mental_health/flavor_config.dart';
import 'package:mental_health/mental_health_app.dart';
import 'package:mental_health/route/route_name.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.DEVELOPMENT,
      initialRoute: RouteName.INITIAL,
      flavorValues: FlavorValues(baseUrl: "http://192.168.0.106:8080"));

  WidgetsFlutterBinding.ensureInitialized();

//  HttpService([
//    //TODO: Check if the build is debug build, then only add this interceptor
//  LoggingInterceptor(),
//  RequestHeaderInterceptor(await SettingsRepository.getInstance())
//  ], () {
//  // on session expired, should add event in bloc,
//  // which will output a state and logout user.
//  });

  runApp(MentalHealthApp());
}
