part of 'eneo_outage_bloc.dart';

@immutable
class EneoOutageEvent {}

class GetOutEneoOutageEvent extends EneoOutageEvent {
  final String? regionId;

  GetOutEneoOutageEvent({this.regionId});
}

class SearchEneoOutageByCityEvent extends EneoOutageEvent {
  final String? localite;

  SearchEneoOutageByCityEvent({this.localite});
}

class SearchEneoOutageByRegionEvent extends EneoOutageEvent {
  final EneoOutageRegion region;

  SearchEneoOutageByRegionEvent({required this.region});
}

class GetOutUserEneoOutageEvent extends EneoOutageEvent {
  final BuildContext context;

  GetOutUserEneoOutageEvent(this.context);
}
