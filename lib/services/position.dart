import 'dart:async';
import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/location/location.dart';
import 'package:huawei_location/location/location_availability.dart';
import 'package:huawei_location/location/location_request.dart';
import 'package:huawei_location/permission/permission_handler.dart';
import 'package:logger/logger.dart';

class Position {
  double latitude;
  double longitude;
  FusedLocationProviderClient locationProviderClient = FusedLocationProviderClient();
  PermissionHandler _permissionHandler = PermissionHandler();
  Location location;


  Future<void> getCurrentLocation() async {
    bool hasLocationPermission = await _permissionHandler.hasLocationPermission();
    if (hasLocationPermission != true) {
      _permissionHandler.requestLocationPermission();
    }

    try {
      location = await locationProviderClient.getLastLocation();
      if (location == null) {
        LocationRequest locationRequest = LocationRequest();
        // PRIORITY_LOW_POWER: 104 - Used to request the city-level location.
        locationRequest.priority = 104;
        try {
          int requestCode = await locationProviderClient.requestLocationUpdates(locationRequest);
          StreamSubscription<Location> streamSubscription =
              locationProviderClient.onLocationData.listen((event) {
            print(event);
          });
          location = await locationProviderClient.getLastLocation();
          longitude = location.longitude;
          latitude = location.latitude;
          await locationProviderClient.removeLocationUpdates(requestCode);
          streamSubscription.cancel();
        } catch (e) {
          print("Error: $e");
        }
      } else {
        location = await locationProviderClient.getLastLocation();
        longitude = location.longitude;
        latitude = location.latitude;
      }
    } catch (e) {
      var logger = Logger();
      logger.e(e.toString());
    }
  }
}
