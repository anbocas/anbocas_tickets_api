import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/tickets/constants/anbocas_ticket_routes.dart';
import 'package:dio/dio.dart';

class AnbocasTickets {
  Future<AnbocasPaginatedResponse<List<AnbocasTicketModel>>> getTickets({
    required String eventId,
    int page = 1,
    bool paginate = true,
    String? search,
    int pageLength = 10,
    String? status,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        AnbocasTicketRoutes.getTicketByEventId(eventId),
        queryParameters: {
          'page': page,
          'paginate': paginate,
          'search': search,
          'page_length': pageLength,
          'status': status,
        },
      );

      final data = response.data['data'];
      final statusResponse = response.data['status'];

      if (data["data"] != null && statusResponse != null) {
        final tickets = (data["data"] as List)
            .map((e) => AnbocasTicketModel.fromMap(e))
            .toList();

        return AnbocasPaginatedResponse(
          data: tickets,
          currentPage: data['current_page'],
          lastPage: data['last_page'],
          perPage: data['per_page'],
          status: AnbocasStatusModel.fromMap(statusResponse),
        );
      }

      throw Exception();
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<dynamic> createTicket({
    required String eventId,
    required String name,
    String? description,
    required String capacity,
    required String price,
    required String availableFrom,
    required String availableTo,
    required AnbocasTicketStatus status,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      var data = FormData.fromMap({
        'event_id': eventId,
        'name': name,
        'description': description,
        'capacity': capacity,
        'price': price,
        'available_from': availableFrom,
        'available_to': availableTo,
        'status': status.value,
      });

      final response = await dio.post(
        AnbocasTicketRoutes.createTicket,
        data: data,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to create ticket: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<bool> deleteTicket(String ticketId) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;
      final response = await dio.delete(
        AnbocasTicketRoutes.deleteTicket(ticketId),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to delete ticket: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<dynamic> getTicketById(String ticketId) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;
      final response = await dio.get(
        AnbocasTicketRoutes.getTicketById(ticketId),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to get ticket: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<dynamic> updateTicket({
    required String ticketId,
    String? eventId,
    String? name,
    String? description,
    String? capacity,
    String? price,
    String? availableFrom,
    String? availableTo,
    AnbocasTicketStatus? status,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;
      Map<String, dynamic> data = {};

      if (eventId != null) data['event_id'] = eventId;
      if (name != null) data['name'] = name;
      if (description != null) data['description'] = description;
      if (capacity != null) data['capacity'] = capacity;
      if (price != null) data['price'] = price;
      if (availableFrom != null) data['available_from'] = availableFrom;
      if (availableTo != null) data['available_to'] = availableTo;
      if (status != null) data['status'] = status.value;

      final response = await dio.put(
        AnbocasTicketRoutes.updateTicket(ticketId),
        data: data,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to update ticket: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }
}
