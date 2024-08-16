import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/api/constant.dart';
import 'package:anbocas_tickets_api/src/api/exception/handle_exception.dart';
import 'package:anbocas_tickets_api/src/request_client.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class EventApi {
  final RequestClient _client;

  EventApi({required RequestClient client}) : _client = client;

  Future<List<AnbocasEventModel>?> get({
    int page = 1,
    bool paginate = true,
    String? search,
    int pageLength = 10,
    String? status,
    required String companyId,
  }) async {
    try {
      // Set up query parameters
      Map<String, dynamic> queryParameters = {
        'page': page,
        'paginate': paginate,
        'search': search,
        'page_length': pageLength,
        'company_id': companyId,
        'status': status,
      };

      // Make the API request using RequestClient
      final response = await _client.dio.get(
        ApiConstant.EVENT_END_POINT,
        queryParameters: queryParameters,
      );

      if (response.data['data'] != null) {
        return (response.data['data'] as List)
            .map((e) => AnbocasEventModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      // Handle errors
      handleError(e);
      return null;
    }
  }

  Future<EventGuestsResponse?> guests({
    required String eventId,
    int page = 1,
    String? search,
    int pageLength = 10,
  }) async {
    try {
      // Set up query parameters
      Map<String, dynamic> queryParameters = {
        'page': page,
        'search': search,
        'page_length': pageLength,
      };

      // Make the API request using RequestClient
      final response = await _client.dio.get(
        ApiConstant.EVENT_GUESTS(eventId),
        queryParameters: queryParameters,
      );

      // Return the response data
      return EventGuestsResponse.fromJson(response.data);
    } catch (error) {
      // Handle errors
      handleError(error);
      return null;
    }
  }

  Future<EventSummaryResponse?> summary({
    required String eventId,
  }) async {
    try {
      // Make the API request using RequestClient
      final response = await _client.dio.get(
        ApiConstant.EVENT_SUMMARY(eventId),
      );

      if (response.data['data'] != null) {
        var eventStats = <EventStats>[];
        if (response.data['data']['stats'] != null) {
          eventStats = (response.data['data']['stats'] as List)
              .map((e) => EventStats.fromJson(e))
              .toList();
        }

        var eventOrders = <EventOrders>[];
        if (response.data['data']['orders'] != null) {
          eventOrders = (response.data['data']['orders'] as List)
              .map((e) => EventOrders.fromJson(e))
              .toList();
        }

        return EventSummaryResponse(
            stats: eventStats,
            orders: eventOrders,
            message: response.data['message']);
      } else {
        return EventSummaryResponse(
            stats: [], orders: [], message: response.data['message']);
      }
    } catch (error) {
      // Handle errors
      handleError(error);
      return null;
    }
  }

  Future<AnbocasEventModel?> eventDetails({
    required String eventId,
  }) async {
    try {
      // Make the API request using RequestClient
      final response = await _client.dio.get(
        '${ApiConstant.EVENT_END_POINT}/$eventId',
      );

      if (response.data['data'] != null) {
        return AnbocasEventModel.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (error) {
      // Handle errors
      handleError(error);
      return null;
    }
  }

  Future<bool> bulkCheckIn({
    required String eventId,
    required List<String> codes,
  }) async {
    try {
      // Make the API request using RequestClient
      final response = await _client.dio.post(ApiConstant.EVENT_CHECK_IN_BULK,
          data: {"event_id": eventId, "codes": codes});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      // Handle errors
      handleError(error);
      return false;
    }
  }

  Future<bool> checkIn({
    required String eventId,
    required String code,
  }) async {
    try {
      // Make the API request using RequestClient
      final response = await _client.dio.post(ApiConstant.EVENT_CHECK_IN,
          data: {"event_id": eventId, "code": code});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      // Handle errors
      handleError(error);
      return false;
    }
  }

  Future<AnbocasEventModel?> createEvent({
    required String categoryId,
    required String companyId,
    required String name,
    required String description,
    String? website,
    String? venue,
    required String location,
    required String latitude,
    required String longitude,
    required DateTime startDateTime,
    required DateTime endDateTime,
    bool isPublic = true,
    bool isFree = false,
    required EventLocationType locationType,
    String? meetingLink,
    bool groupTicketingAllowed = false,
    bool isBookingOpen = true,
    required String bannerFilePath,
  }) async {
    try {
      if (locationType == EventLocationType.virtual && meetingLink == null) {
        throw AnbocasFieldException(
            "Meeting link is required for virtual events");
      }

      // Prepare the file for upload
      MultipartFile? banner;
      if (bannerFilePath != '') {
        banner = await MultipartFile.fromFile(bannerFilePath,
            filename: bannerFilePath.split('/').last);
      }

      final dateFormat = DateFormat('yyyy-MM-dd hh:mm');

      // Prepare form data
      var formData = FormData.fromMap({
        'banner': banner,
        'category_id': categoryId,
        'company_id': companyId,
        'name': name,
        'description': description,
        'website': website,
        'venue': venue,
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
        'start_date': dateFormat.format(startDateTime),
        'end_date': dateFormat.format(endDateTime),
        'is_public': isPublic ? '1' : '0',
        'is_free': isFree ? '1' : '0',
        'location_type': locationType.value,
        'meeting_link': meetingLink,
        'group_ticketing_allowed': groupTicketingAllowed ? '1' : '0',
        'is_booking_open': isBookingOpen ? '1' : '0',
      });

      // Make the API request
      final response = await _client.dio.post(
        ApiConstant.EVENT_END_POINT,
        data: formData,
      );

      if (response.statusCode == 200) {
        return AnbocasEventModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to create event: ${response.statusMessage}");
      }
    } catch (error) {
      // Handle errors
      handleError(error);
      return null;
    }
  }

  Future<bool> delete({
    required String eventId,
    required String eventName,
  }) async {
    try {
      final response = await _client.dio.delete(
        '${ApiConstant.EVENT_END_POINT}/$eventId',
        data: {"name": eventName},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to create event: ${response.statusMessage}");
      }
    } catch (error) {
      // Handle errors
      handleError(error);
      return false;
    }
  }

  Future<AnbocasEventModel?> updateEvent({
    required String eventId,
    String? categoryId,
    String? companyId,
    String? name,
    String? description,
    String? website,
    String? location,
    String? latitude,
    String? longitude,
    String? startDate,
    String? endDate,
    String? bookingStartDate,
    bool? isPublic,
    bool? isFree,
    EventLocationType? locationType,
    String? meetingLink,
    bool? groupTicketingAllowed,
    String? commission,
    bool? isBookingOpen,
    String? filePath,
  }) async {
    try {
      // YYYY-MM-DD HH:MM
      String dateFormat = r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$';
      RegExp regExp = RegExp(dateFormat);

      if (startDate != null && !regExp.hasMatch(startDate)) {
        throw AnbocasFieldException(
            "Invalid start date format. Expected format: 2024-08-04 10:08");
      }
      if (endDate != null && !regExp.hasMatch(endDate)) {
        throw AnbocasFieldException(
            "Invalid end date format. Expected format: 2024-08-04 10:08");
      }
      if (bookingStartDate != null && !regExp.hasMatch(bookingStartDate)) {
        throw AnbocasFieldException(
            "Invalid booking start date format. Expected format: 2024-08-04 10:08");
      }

      if (locationType == EventLocationType.virtual &&
          (meetingLink == null || meetingLink.isEmpty)) {
        throw AnbocasFieldException(
            "Meeting link is required for virtual events");
      }

      // Prepare the file for upload if provided
      MultipartFile? file;
      if (filePath != null) {
        file = await MultipartFile.fromFile(filePath,
            filename: filePath.split('/').last);
      }

      // Prepare form data
      var formData = FormData();

      if (file != null) formData.files.add(MapEntry('banner', file));
      if (categoryId != null) {
        formData.fields.add(MapEntry('category_id', categoryId));
      }
      if (companyId != null) {
        formData.fields.add(MapEntry('company_id', companyId));
      }
      if (name != null) formData.fields.add(MapEntry('name', name));
      if (description != null) {
        formData.fields.add(MapEntry('description', description));
      }
      if (website != null) formData.fields.add(MapEntry('website', website));
      if (location != null) formData.fields.add(MapEntry('location', location));
      if (latitude != null) formData.fields.add(MapEntry('latitude', latitude));
      if (longitude != null) {
        formData.fields.add(MapEntry('longitude', longitude));
      }
      if (startDate != null) {
        formData.fields.add(MapEntry('start_date', startDate));
      }
      if (endDate != null) formData.fields.add(MapEntry('end_date', endDate));
      if (bookingStartDate != null) {
        formData.fields.add(MapEntry('booking_start_date', bookingStartDate));
      }
      if (isPublic != null) {
        formData.fields.add(MapEntry('is_public', isPublic ? '1' : '0'));
      }
      if (isFree != null) {
        formData.fields.add(MapEntry('is_free', isFree ? '1' : '0'));
      }
      if (locationType != null) {
        formData.fields.add(MapEntry('location_type', locationType.value));
      }
      if (meetingLink != null) {
        formData.fields.add(MapEntry('meeting_link', meetingLink));
      }
      if (groupTicketingAllowed != null) {
        formData.fields.add(MapEntry(
            'group_ticketing_allowed', groupTicketingAllowed ? '1' : '0'));
      }
      if (commission != null) {
        formData.fields.add(MapEntry('commission', commission));
      }
      if (isBookingOpen != null) {
        formData.fields
            .add(MapEntry('is_booking_open', isBookingOpen ? '1' : '0'));
      }

      // Make the API request
      final response = await _client.dio.post(
        '${ApiConstant.EVENT_END_POINT}/$eventId',
        data: formData,
      );

      if (response.statusCode == 200) {
        return AnbocasEventModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to update event: ${response.statusMessage}");
      }
    } catch (error) {
      // Handle errors
      handleError(error);
      return null;
    }
  }
}
