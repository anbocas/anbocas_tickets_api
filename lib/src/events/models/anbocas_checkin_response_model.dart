import 'package:equatable/equatable.dart';

import 'package:anbocas_tickets_api/src/shared/models/anbocas_ticket_model.dart';

class AnbocasCheckinResponseModel extends Equatable {
  final String? message;
  final int statusCode;
  final String? name;
  final AnbocasTicketModel? ticketModel;

  const AnbocasCheckinResponseModel({
    this.message,
    this.statusCode = 200,
    this.name,
    this.ticketModel,
  });

  @override
  List<Object?> get props => [
        message,
        statusCode,
        name,
        ticketModel,
      ];

  AnbocasCheckinResponseModel copyWith({
    String? message,
    int? statusCode,
    String? name,
    AnbocasTicketModel? ticketModel,
  }) {
    return AnbocasCheckinResponseModel(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      name: name ?? this.name,
      ticketModel: ticketModel ?? this.ticketModel,
    );
  }
}
