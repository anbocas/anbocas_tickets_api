class EventSummaryResponse {
  List<EventStats> stats = [];
  List<EventOrders> orders = [];
  String? message;

  EventSummaryResponse(
      {required this.stats, required this.orders, this.message});

  EventSummaryResponse.fromJson(Map<String, dynamic> json) {
    if (json["stats"] is List) {
      stats =
          (json["stats"] as List).map((e) => EventStats.fromJson(e)).toList();
    }
    if (json["orders"] is List) {
      orders =
          (json["orders"] as List).map((e) => EventOrders.fromJson(e)).toList();
    }
    if (json["message"] is String) {
      message = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["stats"] = stats.map((e) => e.toJson()).toList();
    _data["orders"] = orders.map((e) => e.toJson()).toList();
    _data["message"] = message;
    return _data;
  }
}

class EventOrders {
  String? orderNumber;
  String? name;
  String? id;
  String? createdAt;
  String? status;
  String? eventId;
  String? totalPayable;
  String? totalConvenienceFee;
  String? parentOrganiserCommission;
  String? pgFee;
  List<Tickets>? tickets;

  EventOrders(
      {this.orderNumber,
      this.name,
      this.id,
      this.createdAt,
      this.status,
      this.eventId,
      this.totalPayable,
      this.totalConvenienceFee,
      this.parentOrganiserCommission,
      this.pgFee,
      this.tickets});

  EventOrders.fromJson(Map<String, dynamic> json) {
    if (json["order_number"] is String) {
      orderNumber = json["order_number"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["event_id"] is String) {
      eventId = json["event_id"];
    }
    if (json["total_payable"] is String) {
      totalPayable = json["total_payable"];
    }
    if (json["total_convenience_fee"] is String) {
      totalConvenienceFee = json["total_convenience_fee"];
    }
    if (json["parent_organiser_commission"] is String) {
      parentOrganiserCommission = json["parent_organiser_commission"];
    }
    if (json["pg_fee"] is String) {
      pgFee = json["pg_fee"];
    }
    if (json["tickets"] is List) {
      tickets = json["tickets"] == null
          ? null
          : (json["tickets"] as List).map((e) => Tickets.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["order_number"] = orderNumber;
    _data["name"] = name;
    _data["id"] = id;
    _data["created_at"] = createdAt;
    _data["status"] = status;
    _data["event_id"] = eventId;
    _data["total_payable"] = totalPayable;
    _data["total_convenience_fee"] = totalConvenienceFee;
    _data["parent_organiser_commission"] = parentOrganiserCommission;
    _data["pg_fee"] = pgFee;
    if (tickets != null) {
      _data["tickets"] = tickets?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Tickets {
  String? id;
  String? orderId;
  String? ticketId;
  String? price;
  int? quantity;
  int? total;
  String? createdAt;
  String? updatedAt;

  Tickets(
      {this.id,
      this.orderId,
      this.ticketId,
      this.price,
      this.quantity,
      this.total,
      this.createdAt,
      this.updatedAt});

  Tickets.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["order_id"] is String) {
      orderId = json["order_id"];
    }
    if (json["ticket_id"] is String) {
      ticketId = json["ticket_id"];
    }
    if (json["price"] is String) {
      price = json["price"];
    }
    if (json["quantity"] is int) {
      quantity = json["quantity"];
    }
    if (json["total"] is int) {
      total = json["total"];
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
    _data["order_id"] = orderId;
    _data["ticket_id"] = ticketId;
    _data["price"] = price;
    _data["quantity"] = quantity;
    _data["total"] = total;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}

class EventStats {
  String? title;
  int? value;
  bool? isAmount;

  EventStats({this.title, this.value, this.isAmount});

  EventStats.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["value"] is int) {
      value = json["value"];
    }
    if (json["is_amount"] is bool) {
      isAmount = json["is_amount"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["value"] = value;
    _data["is_amount"] = isAmount;
    return _data;
  }
}
