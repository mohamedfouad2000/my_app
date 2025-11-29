import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/core/utils/location_service.dart';

class UberStyleMapScreen extends StatefulWidget {
  const UberStyleMapScreen({super.key});

  @override
  _UberStyleMapScreenState createState() => _UberStyleMapScreenState();
}

class _UberStyleMapScreenState extends State<UberStyleMapScreen> {
  GoogleMapController? _mapController;
  bool _mapReady = false;

  LatLng? _currentPosition;

  final Set<Marker> _markers = {};
  late LocationService locationService;

  @override
  void initState() {
    super.initState();
    locationService = LocationService();

    updateMyLocation();
  }

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationService.getRealTimeLocationData((locationData) {
        locationService.location.changeSettings(
          distanceFilter: 5,
        );
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(locationData.latitude!, locationData.longitude!),
          ),
        );
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(locationData.latitude!, locationData.longitude!),
            infoWindow: const InfoWindow(title: 'You are here'),
          ),
        );
        setState(() {});
      });
    } else {}
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    _mapReady = true;

    try {
      String style = await DefaultAssetBundle.of(context)
          .loadString('assets/map_style.json');
      _mapController?.setMapStyle(style);
    } catch (e) {
      print('Map style error: $e');
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
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
