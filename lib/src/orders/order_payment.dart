class OrderPayment {
  String? id;
  String? gatewayProvider;
  String? gatewayTransactionId;
  String? eventId;
  String? orderId;
  String? method;
  String? email;
  String? phone;
  String? amount;
  String? payerName;
  double? fee;
  double? tax;
  String? createdAt;
  String? updatedAt;

  OrderPayment(
      {this.id,
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
      this.updatedAt});

  OrderPayment.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["gateway_provider"] is String) {
      gatewayProvider = json["gateway_provider"];
    }
    if (json["gateway_transaction_id"] is String) {
      gatewayTransactionId = json["gateway_transaction_id"];
    }
    if (json["event_id"] is String) {
      eventId = json["event_id"];
    }
    if (json["order_id"] is String) {
      orderId = json["order_id"];
    }
    if (json["method"] is String) {
      method = json["method"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["phone"] is String) {
      phone = json["phone"];
    }
    if (json["amount"] is String) {
      amount = json["amount"];
    }
    if (json["payer_name"] is String) {
      payerName = json["payer_name"];
    }
    if (json["fee"] is double) {
      fee = json["fee"];
    }
    if (json["tax"] is double) {
      tax = json["tax"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["gateway_provider"] = gatewayProvider;
    _data["gateway_transaction_id"] = gatewayTransactionId;
    _data["event_id"] = eventId;
    _data["order_id"] = orderId;
    _data["method"] = method;
    _data["email"] = email;
    _data["phone"] = phone;
    _data["amount"] = amount;
    _data["payer_name"] = payerName;
    _data["fee"] = fee;
    _data["tax"] = tax;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}
