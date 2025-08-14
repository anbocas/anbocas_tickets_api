import 'package:anbocas_tickets_api/src/shared/models/anbocas_ticket_model.dart';
import 'package:equatable/equatable.dart';

class AnbocasOrderTicketModel extends Equatable {
  final String? id;
  final String? orderId;
  final String? ticketId;
  final double price;
  final int quantity;
  final double total;
  final AnbocasTicketModel? ticket;

  const AnbocasOrderTicketModel({
    this.id,
    this.orderId,
    this.ticketId,
    this.price = 0,
    this.quantity = 1,
    this.total = 0,
    this.ticket,
  });

  @override
  List<Object?> get props => [
        id,
        orderId,
        ticketId,
        price,
        quantity,
        total,
        ticket,
      ];

  factory AnbocasOrderTicketModel.fromJson(Map<String, dynamic> json) {
    return AnbocasOrderTicketModel(
      id: json["id"],
      orderId: json["order_id"],
      ticketId: json["ticket_id"],
      price: double.parse(json["price"]),
      total: double.parse(json["total"]),
      ticket: json["ticket"] != null
          ? AnbocasTicketModel.fromJson(json["ticket"])
          : null,
    );
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
