abstract final class AnbocasTicketRoutes {
  static String getTicketByEventId(String eventId) =>
      "/v1/event/$eventId/tickets";
  static String createTicket = "/v1/tickets";
  static String deleteTicket(String id) => "/v1/tickets/$id";
  static String getTicketById(String id) => "/v1/tickets/$id";
  static String updateTicket(String id) => "/v1/tickets/$id";
}
