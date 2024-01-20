import 'package:flutter/material.dart';
import 'package:flutter_task/core/services/notification_service.dart';
import 'package:flutter_task/core/utilities/location_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier {
  LatLng? _selectedLocation;
  Position? _position;

  LatLng? get selectedLocation => _selectedLocation;
  Position? get currentPosition => _position;

  Future<void> setSelectedLocation(LatLng? location) async {
    _selectedLocation = location;
    notifyListeners();
    await checkDistance();
  }

  Future<void> getLocation(BuildContext context) async {
    _position = await LocationUtils.getCurrentPosition(context);
    notifyListeners();
  }

  Future<void> checkDistance() async {
    double distance = LocationUtils.getDistance(
      startLatitude: _position!.latitude,
      startLongitude: _position!.longitude,
      endLatitude: _selectedLocation!.latitude,
      endLongitude: _selectedLocation!.longitude,
    );
    if (distance <= 1000) {
      String? token = await NotificationServices().updateFCMToken();
      await NotificationServices().sendNotification(
          "location", " location near me (${_selectedLocation!.latitude},${_selectedLocation!.longitude}) ", token!);
    }
  }
}
