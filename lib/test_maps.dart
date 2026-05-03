import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TestMaps extends StatefulWidget {
  const TestMaps({super.key});

  @override
  State<TestMaps> createState() => _TestMapsState();
}

class _TestMapsState extends State<TestMaps> {
  @override
  void initState() {
    _determinePosition().then((value) {
      setState(() {
        markers.add(Marker(markerId: MarkerId('Current Location'),
            position: LatLng(value.latitude, value.longitude)));
        mapController.animateCamera(CameraUpdate.newLatLng(LatLng(value.latitude, value.longitude)));
      });
    });
    super.initState();
  }

  Set<Marker> markers = {};
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) => mapController = controller,
        initialCameraPosition:
        CameraPosition(target: LatLng(31.123, 30.9254), zoom: 10),
        markers: markers,
        onTap: (newLatLng) {
          setState(() {
            markers.add(Marker(
                markerId: MarkerId('tapped Marker'), position: newLatLng));
            mapController.animateCamera(CameraUpdate.newLatLng(newLatLng),
                duration: Duration(seconds: 1));
          });
        },
      ),
    );
  }


  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
