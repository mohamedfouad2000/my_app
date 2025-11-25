import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UberStyleMapScreen extends StatefulWidget {
  const UberStyleMapScreen({super.key});

  @override
  _UberStyleMapScreenState createState() => _UberStyleMapScreenState();
}

class _UberStyleMapScreenState extends State<UberStyleMapScreen> {
  GoogleMapController? _mapController;
  bool _mapReady = false;

  LatLng? _currentPosition;
  StreamSubscription<Position>? _positionStream;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    _updateUserLocation(position);

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position pos) {
      _updateUserLocation(pos);
    });
  }

  void _updateUserLocation(Position position) {
    LatLng newPos = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentPosition = newPos;

      _markers.removeWhere((m) => m.markerId.value == 'me');
      _markers.add(
        Marker(
          markerId: const MarkerId("me"),
          position: newPos,
          infoWindow: const InfoWindow(title: "Your Location"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
    });

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(newPos),
      );
    }
  }

  ontap() {}

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    _mapReady = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        String style = await DefaultAssetBundle.of(context)
            .loadString('assets/map_style.json');
        _mapController?.setMapStyle(style);
      } catch (e) {
        print('Map style error: $e');
      }
    });
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.0444, 31.2357),
          zoom: 14,
        ),
        markers: _markers,
        myLocationEnabled: false,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
      ),
    );
  }
}
