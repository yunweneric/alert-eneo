import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';

class DonationRepository {
  Future<ChargeResponse> donate(Flutterwave flutterwave) async {
    final ChargeResponse response = await flutterwave.charge();
    return response;
  }
}
