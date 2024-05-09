import 'dart:convert';

import 'package:eneo_fails/app/location/data/model/location_model/location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  void saveInit(bool init) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('init', init);
  }

  Future<bool> getInit() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('init') ?? false;
  }

  static Future<bool> saveLocation(LocationModel location) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString('location', json.encode(location.toJson()));
  }

  static Future<LocationModel?> getLocation() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? location_str = await preferences.getString('location');
    if (location_str == null) return null;
    Map<String, dynamic> location = json.decode(location_str);
    return LocationModel.fromJson(location);
  }
}
