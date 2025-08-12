abstract final class EventRoutes {
  static String getEvents = "/v1/events";
  static String createEvent = "/v1/events";
  static String getEventDetails(String id) => "/v1/events/$id";
  static String deleteEvent(String id) => "/v1/events/$id";
  static String updateEvent(String id) => "/v1/events/$id";
  static String getEventGuests(String id) => "/v1/event/$id/guests";
  static String getEventSummary(String id) => "/v1/event/$id/summary";
  static String checkInEvent = "/v1/event/checkin";
  static String checkInBulkEvent = "/v1/event/checkin/bulk";
}
