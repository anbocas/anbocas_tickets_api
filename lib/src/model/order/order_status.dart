class OrderStatus {
  int? all;
  int? completed;
  int? pending;
  int? failed;
  int? cancelled;

  OrderStatus(
      {this.all, this.completed, this.pending, this.failed, this.cancelled});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    if (json["ALL"] is int) {
      all = json["ALL"];
    }
    if (json["COMPLETED"] is int) {
      completed = json["COMPLETED"];
    }
    if (json["PENDING"] is int) {
      pending = json["PENDING"];
    }
    if (json["FAILED"] is int) {
      failed = json["FAILED"];
    }
    if (json["CANCELLED"] is int) {
      cancelled = json["CANCELLED"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["ALL"] = all;
    data["COMPLETED"] = completed;
    data["PENDING"] = pending;
    data["FAILED"] = failed;
    data["CANCELLED"] = cancelled;
    return data;
  }
}
