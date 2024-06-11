part of 'payment_bloc.dart';

class PaymentEvent {}

class PaymentInitializeEvent extends PaymentEvent {
  final InitializePaymentRequestModel model;

  PaymentInitializeEvent({required this.model});
}
