import 'package:anbocas_tickets_api/src/model/order/order_status.dart';
import 'package:anbocas_tickets_api/src/model/order/single_order_data.dart';

class OrderResponse {
  OrderData? data;
  OrderStatus? status;

  OrderResponse({this.data, this.status});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    if (json["data"] is Map) {
      data = json["data"] == null ? null : OrderData.fromJson(json["data"]);
    }
    if (json["status"] is Map) {
      status =
          json["status"] == null ? null : OrderStatus.fromJson(json["status"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    if (status != null) {
      _data["status"] = status?.toJson();
    }
    return _data;
  }
}

class OrderData {
  int? currentPage;
  List<SingleOrderData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  OrderData(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  OrderData.fromJson(Map<String, dynamic> json) {
    if (json["current_page"] is int) {
      currentPage = json["current_page"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List)
              .map((e) => SingleOrderData.fromJson(e))
              .toList();
    }
    if (json["first_page_url"] is String) {
      firstPageUrl = json["first_page_url"];
    }
    if (json["from"] is int) {
      from = json["from"];
    }
    if (json["last_page"] is int) {
      lastPage = json["last_page"];
    }
    if (json["last_page_url"] is String) {
      lastPageUrl = json["last_page_url"];
    }
    nextPageUrl = json["next_page_url"];
    if (json["path"] is String) {
      path = json["path"];
    }
    if (json["per_page"] is int) {
      perPage = json["per_page"];
    }
    prevPageUrl = json["prev_page_url"];
    if (json["to"] is int) {
      to = json["to"];
    }
    if (json["total"] is int) {
      total = json["total"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["current_page"] = currentPage;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["first_page_url"] = firstPageUrl;
    _data["from"] = from;
    _data["last_page"] = lastPage;
    _data["last_page_url"] = lastPageUrl;
    _data["next_page_url"] = nextPageUrl;
    _data["path"] = path;
    _data["per_page"] = perPage;
    _data["prev_page_url"] = prevPageUrl;
    _data["to"] = to;
    _data["total"] = total;
    return _data;
  }
}
