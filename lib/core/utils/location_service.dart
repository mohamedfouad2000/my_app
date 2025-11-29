import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<void> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        throw LocationServiceException();
      }
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw LocationPermissionException();
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        throw LocationPermissionException();
      }
    }
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocation() async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    return await location.getLocation();
  }
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}






  // void updateMyLocation() async {
  //   await locationService.checkAndRequestLocationService();
  //   var hasPermission =
  //       await locationService.checkAndRequestLocationPermission();
  //   if (hasPermission) {
  //     locationService.getRealTimeLocationData((locationData) {
  //       locationService.location.changeSettings(
  //         accuracy: LocationAccuracy.high,
  //         interval: 3000,
  //         distanceFilter: 5,
  //       );
  //       updateCameraPosition(locationData);
  //       _markers.add(
  //         Marker(
  //           markerId: const MarkerId('current_location'),
  //           position: LatLng(locationData.latitude!, locationData.longitude!),
  //           infoWindow: const InfoWindow(title: 'You are here'),
  //         ),
  //       );
  //       setState(() {});
  //     });
  //   } else {}
  // }