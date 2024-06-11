import 'package:geocoding/geocoding.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'location_model.g.dart';

// @JsonSerializable(explicitToJson: true)
class LocationModel {
  Placemark? placemark;
  double? latitude;
  double? longitude;

  LocationModel({this.placemark, this.latitude, this.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      placemark: Placemark.fromMap(json['placemark']),
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placemark': placemark?.toJson(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  LocationModel copyWith({
    Placemark? placemark,
    double? latitude,
    double? longitude,
  }) {
    return LocationModel(
      placemark: placemark ?? this.placemark,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
