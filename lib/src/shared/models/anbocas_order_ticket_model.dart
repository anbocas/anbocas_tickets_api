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

  factory AnbocasOrderTicketModel.fromMap(Map<String, dynamic> map) {
    return AnbocasOrderTicketModel(
      id: map["id"],
      orderId: map["order_id"],
      ticketId: map["ticket_id"],
      price: double.parse(map["price"]),
      total: double.parse(map["total"]),
      ticket: map["ticket"] != null
          ? AnbocasTicketModel.fromMap(map["ticket"])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["order_id"] = orderId;
    data["ticket_id"] = ticketId;
    data["price"] = price;
    data["total"] = total;

    if (ticket != null) {
      data["ticket"] = ticket?.toMap();
    }

    return data;
  }
}
