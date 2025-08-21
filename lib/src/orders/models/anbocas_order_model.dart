import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/orders/models/anbocas_order_log_model.dart';
import 'package:anbocas_tickets_api/src/orders/models/anbocas_order_payment_model.dart';
import 'package:equatable/equatable.dart';

class AnbocasOrderModel extends Equatable {
  final String? id;
  final String? companyId;
  final String? currencyId;
  final String? eventId;
  final String? userId;
  final String? orderNumber;
  final String? subTotal;
  final dynamic coupon;
  final String? discountAmount;
  final String? convenienceFee;
  final String? convenienceTax;
  final String? totalConvenienceFee;
  final String? pgFee;
  final String? organiserPgFee;
  final String? parentOrganiserCommission;
  final String? totalPayable;
  final String? name;
  final String? email;
  final String? phone;
  final int? isGuestCheckout;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  // only available view the order
  final List<AnbocasTicketModel> tickets;
  final AnbocasEventModel? event;
  final AnbocasCompanyModel? company;
  final AnbocasOrderPaymentModel? payment;
  final List<AnbocasOrderLogModel> logs;

  const AnbocasOrderModel({
    this.id,
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
    this.logs = const [],
  });

  @override
  List<Object?> get props => [];

  factory AnbocasOrderModel.fromJson(Map<String, dynamic> json) {
    return AnbocasOrderModel(
      id: json["id"],
      companyId: json["company_id"],
      currencyId: json["currency_id"],
      eventId: json["event_id"],
      userId: json["user_id"],
      orderNumber: json["order_number"],
      subTotal: json["sub_total"],
      coupon: json["coupon"],
      discountAmount: json["discount_amount"],
      convenienceFee: json["convenience_fee"],
      convenienceTax: json["convenience_tax"],
      totalConvenienceFee: json["total_convenience_fee"],
      pgFee: json["pg_fee"],
      organiserPgFee: json["organiser_pg_fee"],
      parentOrganiserCommission: json["parent_organiser_commission"],
      totalPayable: json["total_payable"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      isGuestCheckout: json["is_guest_checkout"],
      status: json["status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      tickets: (json["tickets"] as List)
          .map((e) => AnbocasTicketModel.fromMap(e))
          .toList(),
      event: json["event"] != null
          ? AnbocasEventModel.fromMap(json["event"])
          : null,
      company: json["company"] != null
          ? AnbocasCompanyModel.fromMap(json["company"])
          : null,
      payment: json["payment"] != null
          ? AnbocasOrderPaymentModel.fromMap(json["payment"])
          : null,
      logs: (json["logs"] as List)
          .map((e) => AnbocasOrderLogModel.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "company_id": companyId,
      "currency_id": currencyId,
      "event_id": eventId,
      "user_id": userId,
      "order_number": orderNumber,
      "sub_total": subTotal,
      "coupon": coupon,
      "discount_amount": discountAmount,
      "convenience_fee": convenienceFee,
      "convenience_tax": convenienceTax,
      "total_convenience_fee": totalConvenienceFee,
      "pg_fee": pgFee,
      "organiser_pg_fee": organiserPgFee,
      "parent_organiser_commission": parentOrganiserCommission,
      "total_payable": totalPayable,
      "name": name,
      "email": email,
      "phone": phone,
      "is_guest_checkout": isGuestCheckout,
      "status": status,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "tickets": tickets.map((e) => e.toMap()).toList(),
    };

    if (event != null) {
      data["event"] = event?.toMap();
    }
    if (company != null) {
      data["company"] = company?.toMap();
    }
    if (payment != null) {
      data["payment"] = payment?.toJson();
    }
    data["logs"] = logs.map((e) => e.toMap()).toList();
    return data;
  }
}
