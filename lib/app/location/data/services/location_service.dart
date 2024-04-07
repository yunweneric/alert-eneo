import 'package:eneo_fails/app/location/data/model/location_model/location_model.dart';
import 'package:eneo_fails/shared/components/bottom_sheets.dart';
import 'package:eneo_fails/shared/data/services/base_service.dart';
import 'package:eneo_fails/shared/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationService extends BaseService {
  LocationService({required super.dio});

  Future<LocationModel?> determineCurrentLocation({required BuildContext context}) async {
    try {
      // Test if location services are enabled.
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        AppSheet.showErrorSheet(context: context, desc: "Please enable location services on your device", title: "Enable LocationModel");
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          AppSheet.showErrorSheet(context: context, desc: "Please enable location services on your device", title: "Enable LocationModel");
          permission = await Geolocator.requestPermission();
        }
        return null;
      }

      if (permission == LocationPermission.deniedForever) {
        AppSheet.showErrorSheet(
          context: context,
          desc: "Your location permissions have been denied. Please enable them now!",
          title: "Enable LocationModel",
          onOkay: () => Geolocator.openAppSettings(),
        );
        return null;
      }
      logI("Finding location2");

      Position position = await Geolocator.getCurrentPosition(timeLimit: Duration(seconds: 20));

      logI(position.toJson());

      String? locationName = await getStreetNameFromCoordinates(position.latitude, position.longitude);

      LocationModel location = LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
        name: locationName ?? "",
      );

      logI(location.toJson());

      return location;
    } catch (e) {
      logError(e);
      return null;
    }
  }

  static double getGeolocatorDistance({required context, required LocationModel initialLocation, required LocationModel endLocation}) {
    var distance = Geolocator.distanceBetween(
      initialLocation.latitude!,
      initialLocation.longitude!,
      endLocation.latitude!,
      endLocation.longitude!,
    );
    return distance;
  }

  Future<String?> getCountryFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> place = await placemarkFromCoordinates(latitude, longitude);
      if (place.isNotEmpty) {
        return place[0].name;
      }
    } catch (e) {
      logI('getCountryFromCoordinates: $e');
      return null;
    }
    return null;
  }

  Future<String?> getStreetNameFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> place = await placemarkFromCoordinates(latitude, longitude);
      if (place.isNotEmpty) {
        logI(place[0].toJson());
        return place[0].street;
      }
    } catch (e) {
      logI('getCountryFromCoordinates: $e');
      return null;
    }
    return null;
  }

  Future<void> openMapsAndPlotCourse(BuildContext context, String? location) async {
    try {
      if (location == null) {
        AppSheet.showErrorSheet(
          context: context,
          title: "Open location",
          desc: "This location does not have a valid name",
        );
      } else {
        bool launched = await MapsLauncher.launchQuery(location);
        if (!launched) {
          AppSheet.showErrorSheet(
            context: context,
            title: "Open location",
            desc: "There was an error opening the location. Please ensure you have google maps app installed",
          );
        }
      }
    } catch (e) {}
  }

  Future<void> openCoordinates(BuildContext context, LocationModel location) async {
    try {
      bool launched = await MapsLauncher.launchCoordinates(
        location.latitude!,
        location.longitude!,
        location.name,
      );
      if (!launched) {
        AppSheet.showErrorSheet(
          context: context,
          title: "Open location",
          desc: "There was an error opening the location. Please ensure you have google maps app installed",
        );
      }
    } catch (e) {}
  }

  showMapPlot({
    required BuildContext context,
    required LocationModel LocationModel,
    required LocationModel stopLocation,
  }) async {
    final raw_url = 'https://www.google.com/maps/dir/?api=1&origin=${LocationModel.latitude},${LocationModel.longitude}&destination=${stopLocation.latitude},${stopLocation.longitude}&travelmode=w';
    Uri url = Uri.parse(raw_url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      AppSheet.showErrorSheet(
        context: context,
        title: "Open location",
        desc: "There was an error opening the location. Please ensure you have google maps app installed",
      );
    }
  }
}
