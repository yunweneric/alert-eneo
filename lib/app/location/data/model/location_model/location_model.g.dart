// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) => LocationModel(
      name: json['name'] as String?,
      latitude: json['latitude'] as double?,
      longitude: (json['longitude'] as double?)?.toDouble(),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) => <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
