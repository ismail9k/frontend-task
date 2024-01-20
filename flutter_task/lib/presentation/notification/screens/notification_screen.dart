import 'package:flutter/material.dart';

import 'package:flutter_task/presentation/notification/providers/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var notificationProvider = Provider.of<NotificationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Screen'),
      ),
      body: Column(
        children: notificationProvider.notifications.map((n) {
          return ListTile(
            title: Text(n.title),
            subtitle: Text(n.body),
          );
        }).toList(),
      ),
    );
  }
}
