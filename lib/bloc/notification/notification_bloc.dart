import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:greycells/constants/setting_key.dart';
import 'package:greycells/models/token/token.dart';
import 'package:greycells/repository/settings_repository.dart';
import 'package:greycells/repository/user_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

// TODO: Setup for iOS if supporting in future.
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  FirebaseMessaging _firebaseMessaging;
  SettingsRepository _settingsRepository;
  UserRepository _userRepository;

  NotificationBloc() : super(NotificationInitial()) {
    _firebaseMessaging = FirebaseMessaging();
    _userRepository = UserRepository();

    _firebaseMessaging.getToken().then((value) => print("FCM token " + value));

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is SafelyUpdateToken) {
      _settingsRepository = await SettingsRepository.getInstance();
      String firebaseToken = await _firebaseMessaging.getToken();
      String existingToken =
          _settingsRepository.get(SettingKey.KEY_FCM_TOKEN, defaultValue: "");
      if (_settingsRepository.get(SettingKey.KEY_IS_LOGGED_IN,
          defaultValue: false)) {
        if (firebaseToken != existingToken) {
          await _settingsRepository.saveValue(
              SettingKey.KEY_FCM_TOKEN, firebaseToken);
          try {
            bool result = await _userRepository.updateToken(
                token: Token()
                  ..token = firebaseToken
                  ..userId = _settingsRepository.get(SettingKey.KEY_USER_ID));

            if (result == true) {
              print("FCM token updated");
              yield TokenUpdated();
            } else
              yield TokenUpdateFailed();
          } catch (e) {
            debugPrint(e);
            yield TokenUpdateFailed();
          }
        }
      }
    }
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print("Data: $data");
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print("Notification: $notification");
    }
    // Or do other work.
  }
}
