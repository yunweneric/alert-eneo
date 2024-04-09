import 'package:eneo_fails/app/location/data/model/location_model/location_model.dart';

class UserOutage {
  final bool? hasElectricity;
  final LocationModel? userLocation;

  UserOutage({required this.hasElectricity, required this.userLocation});

  factory UserOutage.fromJson(Map<String, dynamic> json) {
    return UserOutage(
      hasElectricity: json['hasElectricity'],
      userLocation: LocationModel.fromJson(json['userLocation']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "hasElectricity": hasElectricity,
      "userLocation": userLocation?.toJson(),
    };
  }
}
