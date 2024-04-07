import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  String? name;
  double? latitude;
  double? longitude;

  LocationModel({this.name, this.latitude, this.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return _$LocationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  LocationModel copyWith({
    String? name,
    double? latitude,
    double? longitude,
  }) {
    return LocationModel(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
