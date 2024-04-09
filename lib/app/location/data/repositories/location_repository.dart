import 'package:eneo_fails/app/location/data/model/location_model/location_model.dart';
import 'package:eneo_fails/app/location/data/services/location_service.dart';
import 'package:flutter/material.dart';

class LocationRepository {
  final LocationService _locationService;

  LocationRepository(this._locationService);

  Future<LocationModel?> getUserLocation(BuildContext context) async {
    Map<String, dynamic>? location = await _locationService.determineCurrentLocation(context: context);
    if (location == null) throw Exception("We could not find your location!");
    return LocationModel.fromJson(location);
  }
}
