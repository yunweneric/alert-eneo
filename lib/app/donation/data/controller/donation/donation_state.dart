part of 'donation_bloc.dart';

class DonationState {}

class DonationInitial extends DonationState {}

class DonationDonateInitial extends DonationState {}

class DonationDonateError extends DonationState {
  final String message;

  DonationDonateError({required this.message});
}

class DonationDonateSuccess extends DonationState {
  final ChargeResponse response;

  DonationDonateSuccess({required this.response});
}
