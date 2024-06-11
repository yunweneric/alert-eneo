import 'package:bloc/bloc.dart';
import 'package:eneo_fails/app/payment/data/model/initialize_payment_request_model/initialize_payment_request_model.dart';
import 'package:eneo_fails/app/payment/data/repositories/payment_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;
  PaymentBloc(this.paymentRepository) : super(PaymentInitial()) {
    on<PaymentEvent>((event, emit) {});
  }
}
