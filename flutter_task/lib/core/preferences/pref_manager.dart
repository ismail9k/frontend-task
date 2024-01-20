import 'dart:convert';

import 'package:flutter_task/core/models/notification.dart';
import 'package:flutter_task/core/preferences/pref_manager_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  static SharedPreferences? prefs;

  static Future setupSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void clearSharedPreferences() async {
    await prefs?.clear();
  }

  static void setString(String data, String key) async {
    final result = await prefs?.setString(key, data);
  }

  static String? getStringWithKey(String key) {
    return prefs?.getString(key);
  }

  static Future<void> saveNotifications(List<NotificationModel> notifications) async {
    final List<Map<String, dynamic>> jsonList = notifications.map((notification) => notification.toMap()).toList();
    await prefs?.setString(PrefManagerConstants.notifications, json.encode(jsonList));
  }

  static List<NotificationModel> getAllNotiifcations() {
    String? data = prefs?.getString(PrefManagerConstants.notifications);
    if (data != null) return (json.decode(data) as List<dynamic>).map((e) => NotificationModel.fromJson(e)).toList();
    return [];
  }
}
