import 'package:flutter/material.dart';
import 'package:greycells/flavor_config.dart';
import 'package:greycells/gercells_app.dart';
import 'package:greycells/networking/http_service.dart';
import 'package:greycells/networking/logging_interceptor.dart';
import 'package:greycells/networking/request_header_interceptor.dart';
import 'package:greycells/repository/settings/settings_repository.dart';
import 'package:greycells/route/route_name.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.DEVELOPMENT,
      initialRoute: RouteName.INITIAL,
      flavorValues:
          FlavorValues(baseUrl: "http://www.greycellswellness.com/api/"));

  WidgetsFlutterBinding.ensureInitialized();

  HttpService([
    //TODO: Check if the build is debug build, then only add this interceptor
    LoggingInterceptor(),
    RequestHeaderInterceptor(await SettingsRepository.getInstance())
  ], () {
    // on session expired, should add event in bloc,
    // which will output a state and logout user.
  });

  runApp(GreyCellsApp());
}
