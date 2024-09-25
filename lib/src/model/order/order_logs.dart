class OrderLogs {
  String? id;
  String? orderId;
  String? text;
  String? createdAt;

  OrderLogs({this.id, this.orderId, this.text, this.createdAt});

  OrderLogs.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["order_id"] is String) {
      orderId = json["order_id"];
    }
    if (json["text"] is String) {
      text = json["text"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["order_id"] = orderId;
    data["text"] = text;
    data["created_at"] = createdAt;
    return data;
  }
}
