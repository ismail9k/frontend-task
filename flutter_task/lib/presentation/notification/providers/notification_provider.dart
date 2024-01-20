import 'package:flutter/material.dart';
import 'package:flutter_task/core/models/notification.dart';
import 'package:flutter_task/core/preferences/pref_manager.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;
  NotificationProvider() {
    loadNotifications();
  }

  void loadNotifications() {
    _notifications = PrefManager.getAllNotiifcations();
    notifyListeners();
  }
}
