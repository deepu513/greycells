import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:greycells/constants/strings.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/services.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const MethodChannel platform = MethodChannel('greycells_local_notifications');

class LocalNotifications {
  static LocalNotifications _instance;

  LocalNotifications._();

  static Future<LocalNotifications> getInstance() async {
    if (_instance == null) {
      await _configureLocalTimeZone();

      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');

      final InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      _instance = LocalNotifications._();
    }

    return _instance;
  }

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await platform.invokeMethod('getTimeZoneName');
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> zonedScheduleNotification(
      String title, String description, DateTime dateTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        description,
        tz.TZDateTime.from(dateTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            Strings.channelId,
            Strings.channelName,
            Strings.channelDescription,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
