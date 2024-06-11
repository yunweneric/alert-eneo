import 'package:eneo_fails/app/payment/data/service/payment_service.dart';

class PaymentRepository {
  final PaymentService _paymentService;

  PaymentRepository({required PaymentService paymentService})
      : _paymentService = paymentService;
}
