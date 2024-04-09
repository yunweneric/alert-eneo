import 'package:bloc/bloc.dart';
import 'package:eneo_fails/app/location/data/model/location_model/location_model.dart';
import 'package:eneo_fails/app/location/data/repositories/location_repository.dart';
import 'package:eneo_fails/app/outage/data/models/eneo_outage_model/eneo_outage_model.dart';
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
    on<SearchEneoOutageEvent>((event, emit) async {
      emit(EneoOutageSearchLoading());
      try {
        List<EneoOutageModel> new_outages = await _outageRepository.getOutages(data: {"localite": event.localite});
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
