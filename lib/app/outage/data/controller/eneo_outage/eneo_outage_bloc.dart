import 'package:bloc/bloc.dart';
import 'package:eneo_fails/app/location/data/model/location_model/location_model.dart';
import 'package:eneo_fails/app/location/data/repositories/location_repository.dart';
import 'package:eneo_fails/app/outage/data/models/eneo_outage_model/eneo_outage_model.dart';
import 'package:eneo_fails/app/outage/data/models/eneo_outage_regions/eneo_outage_regions.dart';
import 'package:eneo_fails/app/outage/data/repositories/outage_repository.dart';
import 'package:eneo_fails/shared/data/models/user_outage_model.dart';
import 'package:flutter/material.dart';

part 'eneo_outage_event.dart';
part 'eneo_outage_state.dart';

class EneoOutageBloc extends Bloc<EneoOutageEvent, EneoOutageState> {
  final OutageRepository _outageRepository;
  final LocationRepository _locationRepository;
  List<EneoOutageModel> outages = [];
  List<EneoOutageModel> searchOutages = [];
  UserOutage? userOutage;
  List<EneoOutageRegion> eneoOutageRegion = [
    EneoOutageRegion(id: "X-1", name: "Yaoundé"),
    EneoOutageRegion(id: "X-22", name: "Douala"),
    EneoOutageRegion(id: "10", name: "Sud-Ouest"),
    EneoOutageRegion(id: "9", name: "Sud"),
    EneoOutageRegion(id: "8", name: "Nord-Ouest"),
    EneoOutageRegion(id: "7", name: "Nord"),
    EneoOutageRegion(id: "6", name: "Ouest"),
    EneoOutageRegion(id: "5", name: "Littoral"),
    EneoOutageRegion(id: "4", name: "Extreme-Nord"),
    EneoOutageRegion(id: "3", name: "Est"),
    EneoOutageRegion(id: "2", name: "Centre"),
    EneoOutageRegion(id: "1", name: "Adamaoua"),
  ];

  EneoOutageRegion? selectedRegion;

  EneoOutageBloc(this._outageRepository, this._locationRepository) : super(EneoOutageInitial()) {
    on<EneoOutageEvent>((event, emit) {});

    on<GetOutEneoOutageEvent>((event, emit) async {
      emit(EneoOutageFetchLoading());
      try {
        List<EneoOutageModel> new_outages = await _outageRepository.getOutages(data: {"region": event.regionId});
        outages = new_outages;
        searchOutages = new_outages;
        emit(EneoOutageFetchLoaded(outages: new_outages));
      } catch (e) {
        emit(EneoOutageFetchError(message: e.toString()));
      }
    });
    on<SearchEneoOutageByCityEvent>((event, emit) async {
      emit(EneoOutageSearchLoading());
      try {
        List<EneoOutageModel> new_outages = await _outageRepository.getOutages(data: {"localite": event.localite});
        searchOutages = new_outages;
        emit(EneoOutageSearchLoaded(outages: new_outages));
      } catch (e) {
        emit(EneoOutageSearchError(message: e.toString()));
      }
    });

    on<SearchEneoOutageByRegionEvent>((event, emit) async {
      emit(EneoOutageSearchLoading());
      try {
        selectedRegion = event.region;
        List<EneoOutageModel> new_outages = await _outageRepository.getOutages(data: {"region": event.region.id});
        searchOutages = new_outages;
        emit(EneoOutageSearchLoaded(outages: new_outages));
      } catch (e) {
        emit(EneoOutageSearchError(message: e.toString()));
      }
    });
    on<GetOutUserEneoOutageEvent>((event, emit) async {
      emit(EneoOutageGetUserLoading());
      try {
        LocationModel? location = await _locationRepository.getUserLocation(event.context);
        if (location == null) {
          emit(EneoOutageGetUserError(message: "Location not found!"));
          return;
        }
        List<EneoOutageModel> new_outages = await _outageRepository.getOutages(data: {"localite": location.name});
        bool hasElectricity = new_outages.length == 0;
        userOutage = UserOutage(hasElectricity: hasElectricity, userLocation: location);
        emit(EneoOutageGetUserLoaded(userOutage: userOutage!));
      } catch (e) {
        emit(EneoOutageGetUserError(message: e.toString()));
      }
    });
  }
}
