import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notification_event.dart';
part 'notification_state.dart';

// TODO: Setup for iOS if supporting in future.
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  FirebaseMessaging _firebaseMessaging;

  NotificationBloc() : super(NotificationInitial()) {
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((value) => print(value));
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
  ) async* {}

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
