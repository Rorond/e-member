// To parse required this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  PaymentModel({
    required this.statusCode,
    required this.statusMessage,
    required this.bank,
    required this.transactionId,
    required this.orderId,
    required this.redirectUrl,
    required this.merchantId,
    required this.grossAmount,
    required this.currency,
    required this.paymentType,
    required this.transactionTime,
    required this.transactionStatus,
    required this.fraudStatus,
    required this.maskedCard,
    required this.cardType,
    required this.validationMessage,
  });

  String statusCode;
  String statusMessage;
  String bank;
  String transactionId;
  String orderId;
  String redirectUrl;
  String merchantId;
  String grossAmount;
  String currency;
  String paymentType;
  DateTime transactionTime;
  String transactionStatus;
  String fraudStatus;
  String maskedCard;
  String cardType;
  dynamic validationMessage;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        bank: json["bank"],
        transactionId: json["transaction_id"],
        orderId: json["order_id"],
        redirectUrl: json["redirect_url"],
        merchantId: json["merchant_id"],
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        paymentType: json["payment_type"],
        transactionTime: DateTime.parse(json["transaction_time"]),
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        maskedCard: json["masked_card"],
        cardType: json["card_type"],
        validationMessage: json["validation_message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "bank": bank,
        "transaction_id": transactionId,
        "order_id": orderId,
        "redirect_url": redirectUrl,
        "merchant_id": merchantId,
        "gross_amount": grossAmount,
        "currency": currency,
        "payment_type": paymentType,
        "transaction_time": transactionTime.toIso8601String(),
        "transaction_status": transactionStatus,
        "fraud_status": fraudStatus,
        "masked_card": maskedCard,
        "card_type": cardType,
        "validation_message": validationMessage,
      };
}
