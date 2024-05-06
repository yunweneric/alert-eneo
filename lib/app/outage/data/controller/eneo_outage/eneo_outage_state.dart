part of 'eneo_outage_bloc.dart';

@immutable
class EneoOutageState {}

class EneoOutageInitial extends EneoOutageState {}

class EneoOutageFetchLoading extends EneoOutageState {}

class EneoOutageFetchError extends EneoOutageState {
  final String message;

  EneoOutageFetchError({required this.message});
}

class EneoOutageFetchLoaded extends EneoOutageState {
  final List<EneoOutageModel> outages;

  EneoOutageFetchLoaded({required this.outages});
}

class EneoOutageSearchLoading extends EneoOutageState {}

class EneoOutageSearchError extends EneoOutageState {
  final String message;

  EneoOutageSearchError({required this.message});
}

class EneoOutageSearchLoaded extends EneoOutageState {
  final List<EneoOutageModel> outages;

  EneoOutageSearchLoaded({required this.outages});
}

class EneoOutageGetUserLoading extends EneoOutageState {}

class EneoOutageGetUserError extends EneoOutageState {
  final String message;

  EneoOutageGetUserError({required this.message});
}

class EneoOutageGetUserLoaded extends EneoOutageState {
  final UserOutage userOutage;

  EneoOutageGetUserLoaded({required this.userOutage});
}

class CheckBackGroundUserEneoOutageLoading extends EneoOutageState {}

class CheckBackGroundUserEneoOutageError extends EneoOutageState {}

class CheckBackGroundUserEneoOutageSuccuss extends EneoOutageState {}
