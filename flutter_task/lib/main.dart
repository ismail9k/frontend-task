import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/core/preferences/pref_manager.dart';
import 'package:flutter_task/core/services/notification_service.dart';
import 'package:flutter_task/firebase_options.dart';
import 'package:flutter_task/presentation/map/providers/location_provider.dart';

import 'package:flutter_task/presentation/map/screens/map_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PrefManager.setupSharedPreferences();
  await NotificationServices().registerNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(create: (context) => LocationProvider(), child: const MapScreen()),
    );
  }
}
