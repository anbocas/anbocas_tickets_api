import 'package:equatable/equatable.dart';

import 'package:anbocas_tickets_api/src/events/constants/anbocas_check_in_status.dart';
import 'package:anbocas_tickets_api/src/shared/models/anbocas_order_ticket_model.dart';

class AnbocasEventGuestsModel extends Equatable {
  final String? name;
  final String? email;
  final dynamic phone;
  final String? code;
  final String? checkInTime;
  final AnbocasCheckInStatus status;
  final AnbocasOrderTicketModel? orderTicket;

  const AnbocasEventGuestsModel({
    this.orderTicket,
    this.name,
    this.email,
    this.phone,
    this.code,
    this.checkInTime,
    this.status = AnbocasCheckInStatus.notCheckedIn,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        code,
        checkInTime,
        status,
        orderTicket,
      ];

  factory AnbocasEventGuestsModel.fromJson(Map<String, dynamic> json) {
    return AnbocasEventGuestsModel(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      code: json["code"],
      checkInTime: json["check_in_time"],
      status: AnbocasCheckInStatus.fromValue(json["status"]),
      orderTicket: AnbocasOrderTicketModel.fromJson(json['order_ticket']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "code": code,
      "check_in_time": checkInTime,
      "status": status,
    };
  }

  AnbocasEventGuestsModel copyWith({
    String? name,
    String? email,
    dynamic phone,
    String? code,
    String? checkInTime,
    AnbocasCheckInStatus? status,
    AnbocasOrderTicketModel? orderTicket,
  }) {
    return AnbocasEventGuestsModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      code: code ?? this.code,
      checkInTime: checkInTime ?? this.checkInTime,
      status: status ?? this.status,
      orderTicket: orderTicket ?? this.orderTicket,
    );
  }
}
