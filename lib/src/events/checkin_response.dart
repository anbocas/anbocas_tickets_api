import 'package:anbocas_tickets_api/src/shared/ticket_model.dart';

class CheckInResponse {
  String? message;
  late int statusCode;
  String? name;
  TicketModel? ticketModel;

  CheckInResponse({this.statusCode = 200});

  CheckInResponse.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["ticket"] is Map) {
      ticketModel =
          json["ticket"] == null ? null : TicketModel.fromJson(json["ticket"]);
    }
  }
}
