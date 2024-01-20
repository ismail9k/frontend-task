import 'dart:convert';

class NotificationModel {
  final String title;

  final String body;

  NotificationModel({required this.title, required this.body});
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
    };
  }
}
