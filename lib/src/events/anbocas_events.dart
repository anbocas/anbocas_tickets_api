import 'dart:io';

import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/events/constants.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class AnbocasEvents {
  Future<List<AnbocasEventModel>?> getEvents({
    int page = 1,
    bool paginate = true,
    String? search,
    int pageLength = 10,
    String? status,
    required String companyId,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

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
      final response = await dio.get(
        EventRoutes.getEvents,
        queryParameters: queryParameters,
      );

      if (response.data['data']?["data"] != null) {
        final events = (response.data['data']["data"] as List)
            .map((e) => AnbocasEventModel.fromJson(e))
            .toList();
        return events;
      } else {
        return [];
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<EventGuestsResponse?> getGuests({
    required String eventId,
    int page = 1,
    bool paginate = false,
    String? search,
    int pageLength = 10,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      // Set up query parameters
      Map<String, dynamic> queryParameters = {
        'page': page,
        'search': search,
        'paginate': paginate,
        'page_length': pageLength,
      };

      // Make the API request using RequestClient
      final response = await dio.get(
        EventRoutes.getEventGuests(eventId),
        queryParameters: queryParameters,
      );

      // Return the response data
      return EventGuestsResponse.fromJson(response.data);
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<EventSummaryResponse?> getEventSummary({
    required String eventId,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      // Make the API request using RequestClient
      final response = await dio.get(
        EventRoutes.getEventSummary(eventId),
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
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<AnbocasEventModel?> getEventDetails({
    required String eventId,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      // Make the API request using RequestClient
      final response = await dio.get(
        EventRoutes.getEventDetails(eventId),
      );

      if (response.data['data'] != null) {
        return AnbocasEventModel.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<bool> bulkCheckIn({
    required String eventId,
    required List<String> codes,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      // Make the API request using RequestClient
      final response = await dio.post(
        EventRoutes.checkInBulkEvent,
        data: {
          "event_id": eventId,
          "codes": codes,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<CheckInResponse?> checkIn({
    required String eventId,
    required String code,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      // Make the API request using RequestClient
      final response = await dio.post(
        EventRoutes.checkInEvent,
        data: {
          "event_id": eventId,
          "code": code,
        },
      );

      var data = CheckInResponse.fromJson(response.data);
      data.statusCode = response.statusCode!;

      return data;
    } on DioException catch (error) {
      // Handle errors
      var data = CheckInResponse.fromJson(error.response?.data);
      data.statusCode = 400;

      return data;
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
    required EventLocationType locationType,
    String? meetingLink,
    bool isPublic = true,
    bool isFree = false,
    bool groupTicketingAllowed = true,
    bool createOrganiserForVenue = false,
    bool isBookingOpen = true,
    String? referenceId,
    String? bannerPath,
  }) async {
    try {
      if (locationType == EventLocationType.virtual && meetingLink == null) {
        throw AnbocasFieldException(
            "Meeting link is required for virtual events");
      }

      // Prepare the file for upload
      dynamic banner;

      if (bannerPath != null && bannerPath != '') {
        if (bannerPath.startsWith('http')) {
          banner = bannerPath;
        } else {
          if (File(bannerPath).existsSync()) {
            banner = await MultipartFile.fromFile(bannerPath,
                filename: bannerPath.split('/').last);
          }
        }
      }

      final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

      // Prepare form data
      var formData = FormData.fromMap({
        'reference_id': referenceId,
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
        'create_organiser_for_venue': createOrganiserForVenue ? '1' : '0',
      });

      final dio = AnbocasTicketsConfig.instance.dio;

      // Make the API request
      final response = await dio.post(
        EventRoutes.createEvent,
        data: formData,
      );

      if (response.statusCode == 200) {
        return AnbocasEventModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to create event: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<bool> delete({
    required String eventId,
    required String eventName,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.delete(
        EventRoutes.deleteEvent(eventId),
        data: {"name": eventName},
      );

      if (response.statusCode == 200) {
        return true;
      }

      throw Exception("Failed to create event: ${response.statusMessage}");
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<AnbocasEventModel?> updateEvent({
    required String eventId,
    String? categoryId,
    String? companyId,
    String? name,
    String? description,
    String? website,
    String? venue,
    String? location,
    String? latitude,
    String? longitude,
    DateTime? startDateTime,
    DateTime? endDateTime,
    bool? isPublic,
    bool? isFree,
    EventLocationType? locationType,
    String? meetingLink,
    bool? groupTicketingAllowed,
    String? commission,
    bool? isBookingOpen,
    String? bannerPath,
  }) async {
    try {
      if (locationType == EventLocationType.virtual &&
          (meetingLink == null || meetingLink.isEmpty)) {
        throw AnbocasFieldException(
          "Meeting link is required for virtual events",
        );
      }

      final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

      // Prepare the file for upload
      dynamic banner;

      if (bannerPath != null && bannerPath != '') {
        if (bannerPath.startsWith('http')) {
          banner = bannerPath;
        } else {
          if (File(bannerPath).existsSync()) {
            banner = await MultipartFile.fromFile(bannerPath,
                filename: bannerPath.split('/').last);
          }
        }
      }

      // Prepare form data
      var formData = FormData();

      if (banner is MultipartFile) {
        formData.files.add(MapEntry('banner', banner));
      } else {
        formData.fields.add(MapEntry('banner', banner));
      }
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
      if (venue != null) formData.fields.add(MapEntry('venue', venue));
      if (location != null) formData.fields.add(MapEntry('location', location));
      if (latitude != null) formData.fields.add(MapEntry('latitude', latitude));
      if (longitude != null) {
        formData.fields.add(MapEntry('longitude', longitude));
      }
      if (startDateTime != null) {
        formData.fields
            .add(MapEntry('start_date', dateFormat.format(startDateTime)));
      }
      if (endDateTime != null) {
        formData.fields
            .add(MapEntry('end_date', dateFormat.format(endDateTime)));
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

      final dio = AnbocasTicketsConfig.instance.dio;

      // Make the API request
      final response = await dio.post(
        EventRoutes.updateEvent(eventId),
        data: formData,
      );

      if (response.statusCode == 200) {
        return AnbocasEventModel.fromJson(response.data['data']);
      }
      throw Exception("Failed to update event: ${response.statusMessage}");
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }
}
