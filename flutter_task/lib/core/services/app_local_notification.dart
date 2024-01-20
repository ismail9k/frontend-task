import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_task/core/models/notification.dart';
import 'package:flutter_task/core/preferences/pref_manager.dart';

class LocalNotificationManager {
  static final LocalNotificationManager shared = LocalNotificationManager._();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  LocalNotificationManager._();

  Future<void> init() async {
    await _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(),
        macOS: null,
      ),
      //notificationTapBackground
      onDidReceiveBackgroundNotificationResponse: _onDidReceiveBackgroundNotificationResponse,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  Future<void> showNotificationWithNoBody({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      _getNotificationDetails(),
      payload: payload ?? '',
    );
    await saveNotifications(title: title, body: body);
  }

  Future<void> saveNotifications({
    String? title,
    String? body,
  }) async {
    List<NotificationModel>? notifications = PrefManager.getAllNotiifcations();
    notifications.add(NotificationModel(body: body!, title: title!));
    await PrefManager.saveNotifications(notifications);
  }

  Future<void> cancelAllNotifications() async {
    try {
      return _flutterLocalNotificationsPlugin.cancelAll();
    } catch (e, st) {
      if (kDebugMode) {
        print(st);
      }
    }
  }

  Future<void> _onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    print("_onDidReceiveNotificationResponse: ${notificationResponse.payload}");
  }

  NotificationDetails _getNotificationDetails() {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'com.example.task',
      'task',
      channelDescription: 'task Notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'task',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );
    return platformChannelSpecifics;
  }
}

@pragma('vm:entry-point')
Future<void> _onDidReceiveBackgroundNotificationResponse(
  NotificationResponse notificationResponse,
) async {
  // Handle background notification response here
  print('Background notification action tapped: '
      '${notificationResponse.payload}');
}
