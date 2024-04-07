part of 'eneo_outage_bloc.dart';

@immutable
class EneoOutageEvent {}

class GetOutEneoOutageEvent extends EneoOutageEvent {
  final String? regionId;

  GetOutEneoOutageEvent({this.regionId});
}

class SearchEneoOutageEvent extends EneoOutageEvent {
  final String? localite;

  SearchEneoOutageEvent({this.localite});
}
