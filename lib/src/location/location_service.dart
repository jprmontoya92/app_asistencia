import 'dart:async';

import 'package:asistencia/src/model/userlocation_model.dart';
import 'package:location/location.dart';

class LocationService {
  

  var location = Location();

  Future<UserLocation> getLocation() async {
    UserLocation _currentLocation;

    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {

       _currentLocation = UserLocation(
         latitude: 0,
         longitude: 0
       );
    }

    return _currentLocation;
  }
}