// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initialize_payment_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitializePaymentRequestModel _$InitializePaymentRequestModelFromJson(
        Map<String, dynamic> json) =>
    InitializePaymentRequestModel(
      totalAmount: json['total_amount'] as int,
      currency: json['currency'] as String,
      transactionId: json['transaction_id'] as String,
      returnUrl: json['return_url'] as String,
      notifyUrl: json['notify_url'] as String,
      paymentCountry: json['payment_country'] as String,
    );

Map<String, dynamic> _$InitializePaymentRequestModelToJson(
        InitializePaymentRequestModel instance) =>
    <String, dynamic>{
      'total_amount': instance.totalAmount,
      'currency': instance.currency,
      'transaction_id': instance.transactionId,
      'return_url': instance.returnUrl,
      'notify_url': instance.notifyUrl,
      'payment_country': instance.paymentCountry,
    };
