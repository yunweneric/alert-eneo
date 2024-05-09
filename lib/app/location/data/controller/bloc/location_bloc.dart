import 'package:bloc/bloc.dart';
import 'package:eneo_fails/app/location/data/model/location_model/location_model.dart';
import 'package:eneo_fails/app/location/data/repositories/location_repository.dart';
import 'package:permission_handler/permission_handler.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository;
  LocationBloc(this._locationRepository) : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {});
    on<InitializeAndAllowLocationEvent>((event, emit) async {
      bool hasPermission = await Permission.location.isGranted;
      if (!hasPermission) Permission.location.request();
      // bool hasPermission2 = await Permission.locationAlways.isGranted;
      // if (!hasPermission2) Permission.locationAlways.request();
      // LocationModel? location = await _locationRepository.getUserLocation();

      emit(LocationPermissionComplete());
    });
  }
}
