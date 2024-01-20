import 'package:flutter/material.dart';

import 'package:flutter_task/core/utilities/navigator.dart';
import 'package:flutter_task/presentation/map/providers/location_provider.dart';
import 'package:flutter_task/presentation/notification/providers/notification_provider.dart';
import 'package:flutter_task/presentation/notification/screens/notification_screen.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).getLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    var mapProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
        actions: [
          IconButton(
            onPressed: () => pushView(
              context,
              ChangeNotifierProvider(
                create: (context) => NotificationProvider(),
                child: const NotificationScreen(),
              ),
            ),
            icon: const Icon(Icons.notification_add),
          ),
        ],
      ),
      body: mapProvider.currentPosition != null
          ? GoogleMap(
              onMapCreated: (controller) => _controller = controller,
              initialCameraPosition: CameraPosition(
                target: LatLng(mapProvider.currentPosition!.latitude, mapProvider.currentPosition!.longitude),
                zoom: 12,
              ),
              onTap: (latLng) async =>
                  await Provider.of<LocationProvider>(context, listen: false).setSelectedLocation(latLng),
              markers: mapProvider.selectedLocation != null
                  ? {
                      Marker(
                        markerId: const MarkerId("selected-location"),
                        position: mapProvider.selectedLocation!,
                        infoWindow: const InfoWindow(title: "Selected Location"),
                      ),
                    }
                  : {},
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
