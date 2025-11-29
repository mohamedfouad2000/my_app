import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:my_app/core/utils/location_service.dart';

class UberStyleMapScreen extends StatefulWidget {
  const UberStyleMapScreen({super.key});

  @override
  _UberStyleMapScreenState createState() => _UberStyleMapScreenState();
}

class _UberStyleMapScreenState extends State<UberStyleMapScreen> {
  GoogleMapController? _mapController;
  bool _mapReady = false;
  bool _firstCall = true;

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
    try {
      locationService.getRealTimeLocationData((locationData) {
        setState(() {
          _currentPosition =
              LatLng(locationData.latitude!, locationData.longitude!);

          updateCameraPosition(locationData);
          _markers.add(
            Marker(
              markerId: const MarkerId('current_location'),
              position: _currentPosition!,
              infoWindow: const InfoWindow(title: 'موقعي الحالي'),
            ),
          );
        });
      });
    } on LocationServiceException catch (e) {
      print('خدمة الموقع معطلة. يرجى تمكينها.');
    } on LocationPermissionException catch (e) {
      print('إذن الموقع مرفوض. يرجى منح الإذن.');
    } catch (e) {
      print('خطأ غير متوقع: $e');
    }
  }

  void updateCameraPosition(LocationData locationData) {
    if (_firstCall) {
      _firstCall = false;
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(locationData.latitude!, locationData.longitude!),
            zoom: 14,
          ),
        ),
      );
    } else {
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!),
        ),
      );
    }
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
          target: LatLng(0, 0),
        ),
        markers: _markers,
        myLocationEnabled: false,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
      ),
    );
  }
}
