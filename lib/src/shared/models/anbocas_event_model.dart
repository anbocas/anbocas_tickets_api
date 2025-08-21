import 'package:equatable/equatable.dart';

import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/shared/utils/data_serializer.dart';

class AnbocasEventModel extends Equatable {
  final String? id;
  final String? categoryId;
  final String? companyId;
  final String? name;
  final String? slug;
  final String? imageUrl;
  final String? description;
  final String? website;
  final String? venue;
  final String? location;
  final double? latitude;
  final double? longitude;
  final AnbocasEventLocationType? locationType;
  final String? meetingLink;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isBookingOpen;

  /// 1 = True And 0 = False
  final bool? isFree;

  /// 1 = True And 0 = False
  final bool? isPublic;

  /// 1 = True And 0 = False
  final bool? absorbPlatformFee;

  /// 1 = True And 0 = False
  final bool? groupTicketingAllowed;
  final AnbocasEventStatus? status;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// 1 = True And 0 = False
  final bool? isExpired;
  final String? referenceId;

  /// This field is only available for model to get view the event details
  final List<AnbocasTicketModel> tickets;

  /// This field is only available for model to get view the event details
  final AnbocasCompanyModel? company;

  const AnbocasEventModel({
    this.id,
    this.categoryId,
    this.tickets = const [],
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
    this.company,
    this.referenceId,
  });

  @override
  List<Object?> get props => [
        id,
        categoryId,
        tickets,
        companyId,
        name,
        slug,
        imageUrl,
        description,
        website,
        location,
        venue,
        latitude,
        longitude,
        locationType,
        meetingLink,
        startDate,
        endDate,
        isBookingOpen,
        isFree,
        isPublic,
        absorbPlatformFee,
        groupTicketingAllowed,
        status,
        createdBy,
        createdAt,
        updatedAt,
        isExpired,
        company,
        referenceId,
      ];

  factory AnbocasEventModel.fromMap(Map<String, dynamic> map) {
    return AnbocasEventModel(
      id: map["id"],
      categoryId: map["category_id"],
      companyId: map["company_id"],
      name: map["name"],
      slug: map["slug"],
      imageUrl: map["image_url"],
      description: map["description"],
      location: map["location"],
      website: map["website"],
      venue: map["venue"],
      latitude: DataSerializer.toDouble(map["latitude"]),
      longitude: DataSerializer.toDouble(map["longitude"]),
      locationType: AnbocasEventLocationType.fromValue(map["location_type"]),
      meetingLink: map["meeting_link"],
      startDate: DateTime.tryParse(map["start_date"] ?? ''),
      endDate: DateTime.tryParse(map["end_date"] ?? ''),
      isBookingOpen: DataSerializer.toBool(map["is_booking_open"]),
      isFree: DataSerializer.toBool(map["is_free"]),
      isPublic: DataSerializer.toBool(map["is_public"]),
      absorbPlatformFee: DataSerializer.toBool(map["absorb_platform_fee"]),
      groupTicketingAllowed:
          DataSerializer.toBool(map["group_ticketing_allowed"]),
      status: AnbocasEventStatus.fromValue(map["status"]),
      createdBy: map["created_by"],
      createdAt: DateTime.tryParse(map["created_at"] ?? ''),
      updatedAt: DateTime.tryParse(map["updated_at"] ?? ''),
      referenceId: map["reference_id"],
      isExpired: map["is_expired"],
      company: map["company"] != null
          ? AnbocasCompanyModel.fromMap(map["company"])
          : null,
      tickets: map["tickets"] != null
          ? (map["tickets"] as List)
              .map(
                (e) => AnbocasTicketModel.fromMap(e),
              )
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "category_id": categoryId,
      "company_id": companyId,
      "name": name,
      "slug": slug,
      "imageUrl": imageUrl,
      "description": description,
      "website": website,
      "venue": venue,
      "location": location,
      "latitude": latitude,
      "longitude": longitude,
      "location_type": locationType?.value,
      "meeting_link": meetingLink,
      "start_date": startDate?.toString(),
      "end_date": endDate?.toString(),
      "is_booking_open": (isBookingOpen ?? false) ? 1 : 0,
      "is_free": (isFree ?? false) ? 1 : 0,
      "is_public": (isPublic ?? false) ? 1 : 0,
      "absorb_platform_fee": (absorbPlatformFee ?? false) ? 1 : 0,
      "group_ticketing_allowed": (groupTicketingAllowed ?? false) ? 1 : 0,
      "status": status?.value,
      "created_by": createdBy,
      "created_at": createdAt?.toString(),
      "updated_at": updatedAt?.toString(),
      "is_expired": (isExpired ?? false) ? 1 : 0,
      "company": company?.toMap(),
      "tickets": tickets.map((e) => e.toMap()).toList(),
    };
  }

  AnbocasEventModel copyWith({
    String? id,
    String? categoryId,
    String? companyId,
    String? name,
    String? slug,
    String? imageUrl,
    String? description,
    String? website,
    String? venue,
    String? location,
    double? latitude,
    double? longitude,
    AnbocasEventLocationType? locationType,
    String? meetingLink,
    DateTime? startDate,
    DateTime? endDate,
    bool? isBookingOpen,
    bool? isFree,
    bool? isPublic,
    bool? absorbPlatformFee,
    bool? groupTicketingAllowed,
    AnbocasEventStatus? status,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isExpired,
    String? referenceId,
    List<AnbocasTicketModel>? tickets,
    AnbocasCompanyModel? company,
  }) {
    return AnbocasEventModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      website: website ?? this.website,
      venue: venue ?? this.venue,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationType: locationType ?? this.locationType,
      meetingLink: meetingLink ?? this.meetingLink,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isBookingOpen: isBookingOpen ?? this.isBookingOpen,
      isFree: isFree ?? this.isFree,
      isPublic: isPublic ?? this.isPublic,
      absorbPlatformFee: absorbPlatformFee ?? this.absorbPlatformFee,
      groupTicketingAllowed:
          groupTicketingAllowed ?? this.groupTicketingAllowed,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isExpired: isExpired ?? this.isExpired,
      referenceId: referenceId ?? this.referenceId,
      tickets: tickets ?? this.tickets,
      company: company ?? this.company,
    );
  }
}
