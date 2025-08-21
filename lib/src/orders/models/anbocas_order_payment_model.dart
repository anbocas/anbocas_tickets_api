// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anbocas_tickets_api/src/shared/utils/data_serializer.dart';
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
  final double? amount;
  final String? payerName;
  final double? fee;
  final double? tax;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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

  factory AnbocasOrderPaymentModel.fromMap(Map<String, dynamic> map) {
    return AnbocasOrderPaymentModel(
      id: map["id"],
      gatewayProvider: map["gateway_provider"],
      gatewayTransactionId: map["gateway_transaction_id"],
      eventId: map["event_id"],
      orderId: map["order_id"],
      method: map["method"],
      email: map["email"],
      phone: map["phone"],
      amount: map["amount"],
      payerName: map["payer_name"],
      fee: DataSerializer.toDouble(map["fee"]),
      tax: DataSerializer.toDouble(map["tax"]),
      createdAt: DateTime.tryParse(map["created_at"] ?? ''),
      updatedAt: DateTime.tryParse(map["updated_at"] ?? ''),
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

  AnbocasOrderPaymentModel copyWith({
    String? id,
    String? gatewayProvider,
    String? gatewayTransactionId,
    String? eventId,
    String? orderId,
    String? method,
    String? email,
    String? phone,
    double? amount,
    String? payerName,
    double? fee,
    double? tax,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AnbocasOrderPaymentModel(
      id: id ?? this.id,
      gatewayProvider: gatewayProvider ?? this.gatewayProvider,
      gatewayTransactionId: gatewayTransactionId ?? this.gatewayTransactionId,
      eventId: eventId ?? this.eventId,
      orderId: orderId ?? this.orderId,
      method: method ?? this.method,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      amount: amount ?? this.amount,
      payerName: payerName ?? this.payerName,
      fee: fee ?? this.fee,
      tax: tax ?? this.tax,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
