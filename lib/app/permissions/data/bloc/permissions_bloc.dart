import 'package:bloc/bloc.dart';
import 'package:eneo_fails/app/location/data/controller/bloc/location_bloc.dart';
import 'package:eneo_fails/app/notification/data/controller/notification/notification_bloc.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  final LocationBloc _locationBloc;
  final NotificationBloc _notificationBloc;
  PermissionsBloc(this._notificationBloc, this._locationBloc) : super(PermissionsInitial()) {
    on<PermissionsEvent>((event, emit) {});
    on<AllowLocationPermissionsEvent>((event, emit) {
      _notificationBloc.add(InitializeNotificationEvent());
    });
    on<AllowNotificationPermissionsEvent>((event, emit) {
      _locationBloc.add(InitializeAndAllowLocationEvent());
    });
  }
}
