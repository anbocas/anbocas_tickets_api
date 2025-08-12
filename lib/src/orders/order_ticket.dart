import 'package:anbocas_tickets_api/src/shared/ticket_model.dart';

class OrderTicket {
  String? id;
  String? orderId;
  String? ticketId;
  double price = 0;
  int quantity = 1;
  double total = 0;
  TicketModel? ticket;

  OrderTicket({
    this.id,
    this.orderId,
    this.ticketId,
    this.price = 0,
    this.quantity = 1,
    this.total = 0,
    this.ticket,
  });

  OrderTicket.fromJson(Map<String, dynamic> json) {
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
      price = double.parse(json["price"]);
    }
    if (json["total"] is String) {
      total = double.parse(json["total"]);
    }
    if (json["ticket_id"] is String) {
      ticketId = json["ticket_id"];
    }

    if (json["ticket"] is Map) {
      ticket =
          json["ticket"] == null ? null : TicketModel.fromJson(json["ticket"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["order_id"] = orderId;
    data["ticket_id"] = ticketId;
    data["price"] = price;
    data["total"] = total;

    if (ticket != null) {
      data["ticket"] = ticket?.toJson();
    }

    return data;
  }
}
