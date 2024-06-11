import 'package:dio/dio.dart';

class PaymentService {
  final Dio _client;

  PaymentService({required Dio client}) : _client = client;
}
