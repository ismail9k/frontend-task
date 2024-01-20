import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter_task/core/services/app_local_notification.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_constant.dart';

/// [NotificationServices] is a class that contains all the notification services functions
class NotificationServices {
  factory NotificationServices() => _instance;
  NotificationServices._internal();
  // Initialising firebase message plugin.
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final NotificationServices _instance = NotificationServices._internal();

  /// [registerNotification] is a function that register the notification services in firebase.
  Future<void> registerNotification() async {
    await messaging.requestPermission();
    await LocalNotificationManager.shared.init();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    firebaseInit();
    setupInteractMessage();
  }

  /// [firebaseInit] is a function that initialize the firebase messaging.
  /// And it listen to the messages that are received from firebase when the app is in foreground.
  void firebaseInit() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async => await LocalNotificationManager.shared
          .showNotificationWithNoBody(title: message.notification?.title, body: message.notification?.body),
    );
  }

  /// [updateFCMToken] is a function that updates the firebase token in the server.
  Future<String?> updateFCMToken() async {
    try {
      final String? token = await messaging.getToken();
      debugPrint('FCM token $token');

      return token;
    } catch (e) {
      developer.log('FCM token error $e');
      return null;
    }
  }

  // Handle tap on notification when app is in background or terminated.
  /// [setupInteractMessage] is a function that handle the tap on notification when app is in background or terminated.
  Future<void> setupInteractMessage() async {
    // When app is terminated.
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      developer.log('Handling a background message: 111 ${initialMessage.toMap()}');

      handleMessage(initialMessage);
    }

    // When app is in background.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      developer.log('Handling a background message: 22 ${event.toMap()}');

      handleMessage(event);
    });
  }

  /// [handleMessage] is a function that handle the tap on notification when app is in background or terminated.
  Future<void> handleMessage(RemoteMessage message) async {
    debugPrint('Handling a background message:   ${message.data}');
  }

  Future<void> sendNotification(String title, String body, String token) async {
    final Map<String, dynamic> notification = {
      'title': title,
      'body': body,
      'sound': 'default',
    };

    final Map<String, dynamic> payload = {
      'notification': notification,
      'to': token,
    };

    final http.Response response = await http.post(
      Uri.parse(AppConstants.fcmUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${AppConstants.serverKey}',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      developer.log('Response body: ${response.body}');
    } else {
      developer.log('Response body: ${response.body}');
    }
  }

  void subscribeToTopic(String topic) {
    messaging.subscribeToTopic(topic);
  }

  void unsubscribeFromTopic(String topic) {
    messaging.unsubscribeFromTopic(topic);
  }
}

/// [_firebaseMessagingBackgroundHandler] is a function that handle the background message.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  developer.log('Handling a background message: 77 ${message.toMap()}');
}
