import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:greycells/flavor_config.dart';
import 'package:greycells/greycells_app.dart';
import 'package:greycells/route/route_name.dart';
import 'package:greycells/time_watcher.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);

  FlavorConfig(
      flavor: Flavor.PRODUCTION,
      initialRoute: RouteName.INITIAL,
      flavorValues:
          FlavorValues(baseUrl: "https://www.greycellswellness.com/api/"));

  TimeWatcher.getInstance().start();
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );
  }).sendPort);

  runApp(GreyCellsApp());
}
