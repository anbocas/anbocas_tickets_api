import 'dart:io';

import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/events/models/anbocas_checkin_response_model.dart';
import 'package:anbocas_tickets_api/src/events/models/anbocas_event_guests_model.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class AnbocasEvents {
  Future<AnbocasPaginatedResponse<List<AnbocasEventModel>>> getEvents({
    int page = 1,
    bool paginate = true,
    String? search,
    int pageLength = 10,
    AnbocasStatus? status,
    required String companyId,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        AnbocasEventRoutes.getEvents,
        queryParameters: {
          'page': page,
          'paginate': paginate,
          'search': search,
          'page_length': pageLength,
          'company_id': companyId,
          'status': status?.value,
        },
      );

      final data = response.data['data'];
      final statusResponse = response.data['status'];

      if (data["data"] != null && statusResponse != null) {
        final events = (data["data"] as List)
            .map((e) => AnbocasEventModel.fromJson(e))
            .toList();

        return AnbocasPaginatedResponse(
          data: events,
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

  Future<AnbocasEventModel?> getEvent(String eventId) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      // Make the API request using RequestClient
      final response = await dio.get(
        AnbocasEventRoutes.getEventDetails(eventId),
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

  Future<AnbocasPaginatedResponse<List<AnbocasEventGuestsModel>>> getGuests({
    required String eventId,
    int page = 1,
    bool paginate = false,
    String? search,
    int pageLength = 10,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        AnbocasEventRoutes.getEventGuests(eventId),
        queryParameters: {
          'page': page,
          'search': search,
          'paginate': paginate,
          'page_length': pageLength,
        },
      );

      final data = response.data['data'];
      final statusResponse = response.data['status'];

      if (data["data"] != null && statusResponse != null) {
        final eventGuests = (data["data"] as List)
            .map((e) => AnbocasEventGuestsModel.fromJson(e))
            .toList();

        return AnbocasPaginatedResponse(
          data: eventGuests,
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

  Future<List<AnbocasEventStatsModel>> getEventSummary(String eventId) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        AnbocasEventRoutes.getEventSummary(eventId),
      );

      if (response.data['data']?['stats'] != null) {
        return (response.data['data']['stats'] as List)
            .map((e) => AnbocasEventStatsModel.fromJson(e))
            .toList();
      }

      return [];
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

      final response = await dio.post(
        AnbocasEventRoutes.checkInBulkEvent,
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

  Future<AnbocasCheckinResponseModel> checkInEvent({
    required String eventId,
    required String code,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.post(
        AnbocasEventRoutes.checkInEvent,
        data: {
          "event_id": eventId,
          "code": code,
        },
      );

      return AnbocasCheckinResponseModel(
        message: response.data["message"],
        name: response.data["name"],
        statusCode: response.statusCode!,
        ticketModel: response.data["ticket"] != null
            ? AnbocasTicketModel.fromJson(response.data["ticket"])
            : null,
      );
    } on DioException catch (error) {
      // Handle errors
      return AnbocasCheckinResponseModel(
        message: error.response?.data["message"],
        name: error.response?.data["name"],
        statusCode: 400,
        ticketModel: error.response?.data["ticket"] != null
            ? AnbocasTicketModel.fromJson(error.response?.data["ticket"])
            : null,
      );
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
    required AnbocasEventLocationType locationType,
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
      if (locationType == AnbocasEventLocationType.virtual &&
          meetingLink == null) {
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
        AnbocasEventRoutes.createEvent,
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

  Future<bool> deleteEvent({
    required String eventId,
    required String eventName,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.delete(
        AnbocasEventRoutes.deleteEvent(eventId),
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
    AnbocasEventLocationType? locationType,
    String? meetingLink,
    bool? groupTicketingAllowed,
    String? commission,
    bool? isBookingOpen,
    String? bannerPath,
  }) async {
    try {
      if (locationType == AnbocasEventLocationType.virtual &&
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
        AnbocasEventRoutes.updateEvent(eventId),
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
