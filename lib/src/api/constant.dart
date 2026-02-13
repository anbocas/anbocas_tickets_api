class ApiConstant {
  static const String getOrder = '/v1/orders';
  static const String getTicketByEvent = "/v1/ticketsByEvent/";
  static const String ticketEndPoint = "/v1/tickets";
  static const String eventEndPoint = "/v1/events";
  static const String eventCheckIn = "/v1/event/checkin";
  static const String eventCheckInBulk = "/v1/event/checkin/bulk";
  static String eventGuests(String id) => "/v1/event/$id/guests";
  static String eventSummary(String id) => "/v1/event/$id/summary";
  static const String companyEndPoint = "/v1/companies";
  static const String cancelOrder = '/v1/order/cancel';
  static const String verifyOrderPayment = '/v1/verifyOrderPayment';
}
