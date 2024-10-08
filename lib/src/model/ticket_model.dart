class TicketModel {
  String? id;
  String? eventId;
  String? name;
  String? description;
  int? price;
  int? capacity;
  int? available;
  dynamic availableFrom;
  dynamic availableTo;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? formattedPrice;

  TicketModel(
      {this.id,
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
      this.formattedPrice});

  TicketModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["event_id"] is String) {
      eventId = json["event_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["price"] is int) {
      price = json["price"];
    }
    if (json["capacity"] is int) {
      capacity = json["capacity"];
    }
    if (json["available"] is int) {
      available = json["available"];
    }
    availableFrom = json["available_from"];
    availableTo = json["available_to"];
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["formatted_price"] is String) {
      formattedPrice = json["formatted_price"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["event_id"] = eventId;
    data["name"] = name;
    data["description"] = description;
    data["price"] = price;
    data["capacity"] = capacity;
    data["available"] = available;
    data["available_from"] = availableFrom;
    data["available_to"] = availableTo;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["formatted_price"] = formattedPrice;
    return data;
  }
}
