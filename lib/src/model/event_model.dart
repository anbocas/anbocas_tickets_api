import 'package:anbocas_tickets_api/src/model/company_model.dart';
import 'package:anbocas_tickets_api/src/model/ticket_model.dart';

enum EventLocationType {
  virtual("VIRTUAL"),
  inPerson("IN_PERSON");

  const EventLocationType(this.value);
  final String value;
}

class AnbocasEventModel {
  String? id;
  String? categoryId;
  String? companyId;
  String? name;
  String? slug;
  String? imageUrl;
  String? description;
  dynamic website;
  String? venue;
  String? location;
  double? latitude;
  double? longitude;
  String? locationType;
  String? meetingLink;
  String? startDate;
  String? endDate;
  int? isBookingOpen;
  int? isFree;
  int? isPublic;
  int? absorbPlatformFee;
  int? groupTicketingAllowed;
  String? status;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  bool? isExpired;
  List<TicketModel> tickets = []; // only available view the events
  AnbocasCompanyModel? company; // only available view the events
  String? referenceId;

  EventLocationType getLocationType() {
    if (locationType == "VIRTUAL") {
      return EventLocationType.virtual;
    } else {
      return EventLocationType.inPerson;
    }
  }

  AnbocasEventModel({
    this.id,
    this.categoryId,
    this.companyId,
    this.name,
    this.slug,
    this.imageUrl,
    this.description,
    this.website,
    this.location,
    this.venue,
    this.latitude,
    this.longitude,
    this.locationType,
    this.meetingLink,
    this.startDate,
    this.endDate,
    this.isBookingOpen,
    this.isFree,
    this.isPublic,
    this.absorbPlatformFee,
    this.groupTicketingAllowed,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.isExpired,
    required this.tickets,
    this.company,
    this.referenceId,
  });

  AnbocasEventModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["category_id"] is String) {
      categoryId = json["category_id"];
    }
    if (json["company_id"] is String) {
      companyId = json["company_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["slug"] is String) {
      slug = json["slug"];
    }
    if (json["image_url"] is String) {
      imageUrl = json["image_url"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    website = json["website"];
    if (json["location"] is String) {
      location = json["location"];
    }
    if (json["venue"] is String) {
      venue = json["venue"];
    }
    if (json["latitude"] is double) {
      latitude = json["latitude"];
    }
    if (json["longitude"] is double) {
      longitude = json["longitude"];
    }
    if (json["location_type"] is String) {
      locationType = json["location_type"];
    }
    if (json["meeting_link"] is String) {
      meetingLink = json["meeting_link"];
    }
    if (json["start_date"] is String) {
      startDate = json["start_date"];
    }
    if (json["end_date"] is String) {
      endDate = json["end_date"];
    }
    if (json["is_booking_open"] is int) {
      isBookingOpen = json["is_booking_open"];
    }
    if (json["is_free"] is int) {
      isFree = json["is_free"];
    }
    if (json["is_public"] is int) {
      isPublic = json["is_public"];
    }
    if (json["absorb_platform_fee"] is int) {
      absorbPlatformFee = json["absorb_platform_fee"];
    }
    if (json["group_ticketing_allowed"] is int) {
      groupTicketingAllowed = json["group_ticketing_allowed"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["created_by"] is String) {
      createdBy = json["created_by"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    if (json["reference_id"] is String) {
      referenceId = json["reference_id"];
    }
    if (json["is_expired"] is bool) {
      isExpired = json["is_expired"];
    }
    if (json["tickets"] is List) {
      tickets = (json["tickets"] as List)
          .map((e) => TicketModel.fromJson(e))
          .toList();
    }
    if (json["company"] is Map) {
      company = json["company"] == null
          ? null
          : AnbocasCompanyModel.fromJson(json["company"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["category_id"] = categoryId;
    data["company_id"] = companyId;
    data["name"] = name;
    data["slug"] = slug;
    data["imageUrl"] = imageUrl;
    data["description"] = description;
    data["website"] = website;
    data["venue"] = venue;
    data["location"] = location;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["location_type"] = locationType;
    data["meeting_link"] = meetingLink;
    data["start_date"] = startDate;
    data["end_date"] = endDate;
    data["is_booking_open"] = isBookingOpen;
    data["is_free"] = isFree;
    data["is_public"] = isPublic;
    data["absorb_platform_fee"] = absorbPlatformFee;
    data["group_ticketing_allowed"] = groupTicketingAllowed;
    data["status"] = status;
    data["created_by"] = createdBy;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["is_expired"] = isExpired;
    data["tickets"] = tickets;
    data["company"] = company;

    return data;
  }
}
