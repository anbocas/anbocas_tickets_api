import 'package:equatable/equatable.dart';

class AnbocasTicketModel extends Equatable {
  final String? id;
  final String? eventId;
  final String? name;
  final String? description;
  final double? price;
  final int? capacity;
  final int? available;
  final dynamic availableFrom;
  final dynamic availableTo;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? formattedPrice;

  const AnbocasTicketModel({
    this.id,
    this.eventId,
    this.name,
    this.description,
    this.price,
    this.capacity,
    this.available,
    this.availableFrom,
    this.availableTo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.formattedPrice,
  });

  @override
  List<Object?> get props => [
        id,
        eventId,
        name,
        description,
        price,
        capacity,
        available,
        availableFrom,
        availableTo,
        status,
        createdAt,
        updatedAt,
        formattedPrice,
      ];

  factory AnbocasTicketModel.fromJson(Map<String, dynamic> json) {
    return AnbocasTicketModel(
      id: json["id"],
      eventId: json["event_id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      capacity: json["capacity"],
      available: json["available"],
      availableFrom: json["available_from"],
      availableTo: json["available_to"],
      status: json["status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      formattedPrice: json["formatted_price"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "event_id": eventId,
      "name": name,
      "description": description,
      "price": price,
      "capacity": capacity,
      "available": available,
      "available_from": availableFrom,
      "available_to": availableTo,
      "status": status,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "formatted_price": formattedPrice,
    };
  }

  AnbocasTicketModel copyWith({
    String? id,
    String? eventId,
    String? name,
    String? description,
    double? price,
    int? capacity,
    int? available,
    dynamic availableFrom,
    dynamic availableTo,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? formattedPrice,
  }) {
    return AnbocasTicketModel(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      capacity: capacity ?? this.capacity,
      available: available ?? this.available,
      availableFrom: availableFrom ?? this.availableFrom,
      availableTo: availableTo ?? this.availableTo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      formattedPrice: formattedPrice ?? this.formattedPrice,
    );
  }
}
