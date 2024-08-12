class ApiConstant {
  static String GET_ORDER = '/v1/orders';
  static String GET_TICKET_BY_EVENT = "/v1/ticketsByEvent/";
  static String TICKET_END_POINT = "/v1/tickets";
  static String EVENT_END_POINT = "/v1/events";
  static String EVENT_CHECK_IN = "/v1/event/checkin";
  static String EVENT_CHECK_IN_BULK = "/v1/event/checkin/bulk";
  static String EVENT_GUESTS(String id) => "/v1/event/$id/guests";
  static String EVENT_SUMMARY(String id) => "/v1/event/$id/summary";
  static String COMPANY_END_POINT = "/v1/companies";
}
