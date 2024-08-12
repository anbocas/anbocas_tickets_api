import 'package:anbocas_tickets_api/src/model/company_model.dart';
import 'package:anbocas_tickets_api/src/model/event_model.dart';
import 'package:anbocas_tickets_api/src/model/order/order_logs.dart';
import 'package:anbocas_tickets_api/src/model/order/order_payment.dart';
import 'package:anbocas_tickets_api/src/model/ticket_model.dart';

class SingleOrderData {
  String? id;
  String? companyId;
  String? currencyId;
  String? eventId;
  String? userId;
  String? orderNumber;
  String? subTotal;
  dynamic coupon;
  String? discountAmount;
  String? convenienceFee;
  String? convenienceTax;
  String? totalConvenienceFee;
  String? pgFee;
  String? organiserPgFee;
  String? parentOrganiserCommission;
  String? totalPayable;
  String? name;
  String? email;
  String? phone;
  int? isGuestCheckout;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<TicketModel> tickets = []; // only available view the order
  EventModel? event; // only available view the order
  CompanyModel? company; // only available view the order
  OrderPayment? payment; // only available view the order
  List<OrderLogs> logs = []; // only available view the order

  SingleOrderData(
      {this.id,
      this.companyId,
      this.currencyId,
      this.eventId,
      this.userId,
      this.orderNumber,
      this.subTotal,
      this.coupon,
      this.discountAmount,
      this.convenienceFee,
      this.convenienceTax,
      this.totalConvenienceFee,
      this.pgFee,
      this.organiserPgFee,
      this.parentOrganiserCommission,
      this.totalPayable,
      this.name,
      this.email,
      this.phone,
      this.isGuestCheckout,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.tickets = const [],
      this.event,
      this.company,
      this.payment,
      this.logs = const []});

  SingleOrderData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["company_id"] is String) {
      companyId = json["company_id"];
    }
    if (json["currency_id"] is String) {
      currencyId = json["currency_id"];
    }
    if (json["event_id"] is String) {
      eventId = json["event_id"];
    }
    if (json["user_id"] is String) {
      userId = json["user_id"];
    }
    if (json["order_number"] is String) {
      orderNumber = json["order_number"];
    }
    if (json["sub_total"] is String) {
      subTotal = json["sub_total"];
    }
    coupon = json["coupon"];
    if (json["discount_amount"] is String) {
      discountAmount = json["discount_amount"];
    }
    if (json["convenience_fee"] is String) {
      convenienceFee = json["convenience_fee"];
    }
    if (json["convenience_tax"] is String) {
      convenienceTax = json["convenience_tax"];
    }
    if (json["total_convenience_fee"] is String) {
      totalConvenienceFee = json["total_convenience_fee"];
    }
    if (json["pg_fee"] is String) {
      pgFee = json["pg_fee"];
    }
    if (json["organiser_pg_fee"] is String) {
      organiserPgFee = json["organiser_pg_fee"];
    }
    if (json["parent_organiser_commission"] is String) {
      parentOrganiserCommission = json["parent_organiser_commission"];
    }
    if (json["total_payable"] is String) {
      totalPayable = json["total_payable"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["phone"] is String) {
      phone = json["phone"];
    }
    if (json["is_guest_checkout"] is int) {
      isGuestCheckout = json["is_guest_checkout"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["tickets"] is List) {
      tickets = (json["tickets"] as List)
          .map((e) => TicketModel.fromJson(e))
          .toList();
    }
    if (json["event"] is Map) {
      event = json["event"] == null ? null : EventModel.fromJson(json["event"]);
    }
    if (json["company"] is Map) {
      company = json["company"] == null
          ? null
          : CompanyModel.fromJson(json["company"]);
    }
    if (json["payment"] is Map) {
      payment = json["payment"] == null
          ? null
          : OrderPayment.fromJson(json["payment"]);
    }
    if (json["logs"] is List) {
      logs = (json["logs"] as List).map((e) => OrderLogs.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["company_id"] = companyId;
    _data["currency_id"] = currencyId;
    _data["event_id"] = eventId;
    _data["user_id"] = userId;
    _data["order_number"] = orderNumber;
    _data["sub_total"] = subTotal;
    _data["coupon"] = coupon;
    _data["discount_amount"] = discountAmount;
    _data["convenience_fee"] = convenienceFee;
    _data["convenience_tax"] = convenienceTax;
    _data["total_convenience_fee"] = totalConvenienceFee;
    _data["pg_fee"] = pgFee;
    _data["organiser_pg_fee"] = organiserPgFee;
    _data["parent_organiser_commission"] = parentOrganiserCommission;
    _data["total_payable"] = totalPayable;
    _data["name"] = name;
    _data["email"] = email;
    _data["phone"] = phone;
    _data["is_guest_checkout"] = isGuestCheckout;
    _data["status"] = status;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["tickets"] = tickets.map((e) => e.toJson()).toList();
    if (event != null) {
      _data["event"] = event?.toJson();
    }
    if (company != null) {
      _data["company"] = company?.toJson();
    }
    if (payment != null) {
      _data["payment"] = payment?.toJson();
    }
    _data["logs"] = logs.map((e) => e.toJson()).toList();
    return _data;
  }
}
