import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

enum Flavor {
  DEVELOPMENT,
  QA,
  PRODUCTION,
}

/// This class can hold values which can be different for different flavors.
class FlavorValues {
  final String baseUrl;

  FlavorValues({@required this.baseUrl});
}

/// Singleton class which holds the app configuration till the app is running.
class FlavorConfig {
  final Flavor flavor;
  final String initialRoute;
  final FlavorValues flavorValues;

  static FlavorConfig _instance;

  factory FlavorConfig(
      {@required Flavor flavor,
      @required String initialRoute,
      @required FlavorValues flavorValues}) {
    _instance ??= FlavorConfig._internal(flavor, initialRoute, flavorValues);
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.initialRoute, this.flavorValues);

  static FlavorConfig get instance => _instance;

  /// Helper methods
  static bool isProduction() => _instance.flavor == Flavor.PRODUCTION;

  static bool isDevelopment() => _instance.flavor == Flavor.DEVELOPMENT;

  static bool isQA() => _instance.flavor == Flavor.QA;

  static String getBaseUrl() => _instance.flavorValues.baseUrl;
}
