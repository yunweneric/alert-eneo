part of 'donation_bloc.dart';

class DonationEvent {}

class DonationDonateEvent extends DonationEvent {
  final Flutterwave flutterwave;

  DonationDonateEvent({required this.flutterwave});
}
