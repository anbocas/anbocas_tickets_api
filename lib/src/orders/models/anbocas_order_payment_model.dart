import 'package:equatable/equatable.dart';

class AnbocasOrderPaymentModel extends Equatable {
  final String? id;
  final String? gatewayProvider;
  final String? gatewayTransactionId;
  final String? eventId;
  final String? orderId;
  final String? method;
  final String? email;
  final String? phone;
  final String? amount;
  final String? payerName;
  final double? fee;
  final double? tax;
  final String? createdAt;
  final String? updatedAt;

  const AnbocasOrderPaymentModel({
    this.id,
    this.gatewayProvider,
    this.gatewayTransactionId,
    this.eventId,
    this.orderId,
    this.method,
    this.email,
    this.phone,
    this.amount,
    this.payerName,
    this.fee,
    this.tax,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        gatewayProvider,
        gatewayTransactionId,
        eventId,
        orderId,
        method,
        email,
        phone,
        amount,
        payerName,
        fee,
        tax,
        createdAt,
        updatedAt,
      ];

  factory AnbocasOrderPaymentModel.fromJson(Map<String, dynamic> json) {
    return AnbocasOrderPaymentModel(
      id: json["id"],
      gatewayProvider: json["gateway_provider"],
      gatewayTransactionId: json["gateway_transaction_id"],
      eventId: json["event_id"],
      orderId: json["order_id"],
      method: json["method"],
      email: json["email"],
      phone: json["phone"],
      amount: json["amount"],
      payerName: json["payer_name"],
      fee: json["fee"],
      tax: json["tax"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "gateway_provider": gatewayProvider,
      "gateway_transaction_id": gatewayTransactionId,
      "event_id": eventId,
      "order_id": orderId,
      "method": method,
      "email": email,
      "phone": phone,
      "amount": amount,
      "payer_name": payerName,
      "fee": fee,
      "tax": tax,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
