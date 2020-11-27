import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:greycells/flavor_config.dart';
import 'package:greycells/greycells_app.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/time_watcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);

  FlavorConfig(
      flavor: Flavor.PRODUCTION,
      initialRoute: RouteName.INITIAL,
      flavorValues:
          FlavorValues(baseUrl: "https://www.greycellswellness.com/api/"));

  TimeWatcher.getInstance().start();

  runApp(GreyCellsApp());
}
