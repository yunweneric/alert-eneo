// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eneo_outage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EneoOutageModel _$EneoOutageModelFromJson(Map<String, dynamic> json) => EneoOutageModel(
      observations: json['observations'] as String?,
      progDate: DateTime.tryParse(json['prog_date']) as DateTime?,
      progHeureDebut: json['prog_heure_debut'] as String?,
      progHeureFin: json['prog_heure_fin'] as String?,
      region: json['region'] as String?,
      ville: json['ville'] as String?,
      quartier: json['quartier'] as String?,
    );

Map<String, dynamic> _$EneoOutageModelToJson(EneoOutageModel instance) => <String, dynamic>{
      'observations': instance.observations,
      'prog_date': instance.progDate?.toIso8601String(),
      'prog_heure_debut': instance.progHeureDebut,
      'prog_heure_fin': instance.progHeureFin,
      'region': instance.region,
      'ville': instance.ville,
      'quartier': instance.quartier,
    };
