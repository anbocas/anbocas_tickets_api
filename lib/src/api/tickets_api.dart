import 'package:anbocas_tickets_api/src/api/constant.dart';
import 'package:anbocas_tickets_api/src/api/exception/handle_exception.dart';
import 'package:anbocas_tickets_api/src/request_client.dart';
import 'package:dio/dio.dart';

class TicketsApi {
  final RequestClient _client;

  TicketsApi({required RequestClient client}) : _client = client;

  Future<dynamic> get({
    required String eventId,
    int page = 1,
    bool paginate = true,
    String? search,
    int pageLength = 10,
    String? status,
  }) async {
    try {
      // Set up query parameters
      Map<String, dynamic> queryParameters = {
        'page': page,
        'paginate': paginate,
        'search': search,
        'page_length': pageLength,
        'status': status,
      };

      // Make the API request using RequestClient
      final response = await _client.dio.get(
        '${ApiConstant.GET_TICKET_BY_EVENT}$eventId',
        queryParameters: queryParameters,
      );

      // Return the response data
      return response.data;
    } catch (e) {
      handleError(e);
    }
  }

  Future<dynamic> createTicket(
      {required String eventId,
      required String name,
      String? description,
      required String capacity,
      required String price,
      required String availableFrom,
      required String availableTo,
      required String status}) async {
    try {
      var data = FormData.fromMap({
        'event_id': eventId,
        'name': name,
        'description': description,
        'capacity': capacity,
        'price': price,
        'available_from': availableFrom,
        'available_to': availableTo,
        'status': status
      });

      final response = await _client.dio.post(
        ApiConstant.TICKET_END_POINT,
        data: data,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to create ticket: ${response.statusMessage}");
      }
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  Future<bool> deleteTicket({
    required String ticketId,
  }) async {
    try {
      final response = await _client.dio.delete(
        '${ApiConstant.TICKET_END_POINT}/$ticketId',
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to delete ticket: ${response.statusMessage}");
      }
    } catch (e) {
      handleError(e);
      return false;
    }
  }

  Future<dynamic> getTicketById({
    required String ticketId,
  }) async {
    try {
      final response = await _client.dio.get(
        '${ApiConstant.TICKET_END_POINT}/$ticketId',
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to get ticket: ${response.statusMessage}");
      }
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  Future<dynamic> updateTicket(
      {required String ticketId,
      String? eventId,
      String? name,
      String? description,
      String? capacity,
      String? price,
      String? availableFrom,
      String? availableTo,
      String? status}) async {
    try {
      Map<String, dynamic> data = {};

      if (eventId != null) data['event_id'] = eventId;
      if (name != null) data['name'] = name;
      if (description != null) data['description'] = description;
      if (capacity != null) data['capacity'] = capacity;
      if (price != null) data['price'] = price;
      if (availableFrom != null) data['available_from'] = availableFrom;
      if (availableTo != null) data['available_to'] = availableTo;
      if (status != null) data['status'] = status;

      final response = await _client.dio.put(
        '${ApiConstant.TICKET_END_POINT}/$ticketId',
        data: data,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to update ticket: ${response.statusMessage}");
      }
    } catch (e) {
      handleError(e);
      return null;
    }
  }
}
