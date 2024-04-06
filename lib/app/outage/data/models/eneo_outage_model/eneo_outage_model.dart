import 'package:json_annotation/json_annotation.dart';

part 'eneo_outage_model.g.dart';

@JsonSerializable()
class EneoOutageModel {
  String? observations;
  @JsonKey(name: 'prog_date')
  DateTime? progDate;
  @JsonKey(name: 'prog_heure_debut')
  String? progHeureDebut;
  @JsonKey(name: 'prog_heure_fin')
  String? progHeureFin;
  String? region;
  String? ville;
  String? quartier;

  EneoOutageModel({
    this.observations,
    this.progDate,
    this.progHeureDebut,
    this.progHeureFin,
    this.region,
    this.ville,
    this.quartier,
  });

  factory EneoOutageModel.fromJson(Map<String, dynamic> json) {
    return _$EneoOutageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EneoOutageModelToJson(this);

  EneoOutageModel copyWith({
    String? observations,
    DateTime? progDate,
    String? progHeureDebut,
    String? progHeureFin,
    String? region,
    String? ville,
    String? quartier,
  }) {
    return EneoOutageModel(
      observations: observations ?? this.observations,
      progDate: progDate ?? this.progDate,
      progHeureDebut: progHeureDebut ?? this.progHeureDebut,
      progHeureFin: progHeureFin ?? this.progHeureFin,
      region: region ?? this.region,
      ville: ville ?? this.ville,
      quartier: quartier ?? this.quartier,
    );
  }
}
