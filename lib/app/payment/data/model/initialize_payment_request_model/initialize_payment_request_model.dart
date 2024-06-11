import 'package:json_annotation/json_annotation.dart';

part 'initialize_payment_request_model.g.dart';

@JsonSerializable()
class InitializePaymentRequestModel {
  @JsonKey(name: 'total_amount')
  int totalAmount;
  String currency;
  @JsonKey(name: 'transaction_id')
  String transactionId;
  @JsonKey(name: 'return_url')
  String returnUrl;
  @JsonKey(name: 'notify_url')
  String notifyUrl;
  @JsonKey(name: 'payment_country')
  String paymentCountry;

  InitializePaymentRequestModel({
    required this.totalAmount,
    required this.currency,
    required this.transactionId,
    required this.returnUrl,
    required this.notifyUrl,
    required this.paymentCountry,
  });

  factory InitializePaymentRequestModel.fromJson(Map<String, dynamic> json) {
    return _$InitializePaymentRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InitializePaymentRequestModelToJson(this);

  InitializePaymentRequestModel copyWith({
    required int totalAmount,
    required String currency,
    required String transactionId,
    required String returnUrl,
    required String notifyUrl,
    required String paymentCountry,
  }) {
    return InitializePaymentRequestModel(
      totalAmount: totalAmount,
      currency: currency,
      transactionId: transactionId,
      returnUrl: returnUrl,
      notifyUrl: notifyUrl,
      paymentCountry: paymentCountry,
    );
  }
}
