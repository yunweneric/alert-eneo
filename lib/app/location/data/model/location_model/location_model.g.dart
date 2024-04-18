// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) => LocationModel(
      // placemark: json['placemark'] as Placemark?,
      placemark: Placemark.fromMap(json['placemark']) as Placemark?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) => <String, dynamic>{
      'placemark': instance.placemark?.toJson(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
