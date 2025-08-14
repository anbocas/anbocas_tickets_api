import 'package:equatable/equatable.dart';

import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';

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
  final String? startDate;
  final String? endDate;
  final int? isBookingOpen;
  final int? isFree;
  final int? isPublic;
  final int? absorbPlatformFee;
  final int? groupTicketingAllowed;
  final String? status;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final bool? isExpired;
  final String? referenceId;

  // only available or get when call or view the event details
  final List<AnbocasTicketModel> tickets;
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

  factory AnbocasEventModel.fromJson(Map<String, dynamic> json) {
    return AnbocasEventModel(
      id: json["id"],
      categoryId: json["category_id"],
      companyId: json["company_id"],
      name: json["name"],
      slug: json["slug"],
      imageUrl: json["image_url"],
      description: json["description"],
      location: json["location"],
      website: json["website"],
      venue: json["venue"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      locationType: AnbocasEventLocationType.fromValue(json["location_type"]),
      meetingLink: json["meeting_link"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      isBookingOpen: json["is_booking_open"],
      isFree: json["is_free"],
      isPublic: json["is_public"],
      absorbPlatformFee: json["absorb_platform_fee"],
      groupTicketingAllowed: json["group_ticketing_allowed"],
      status: json["status"],
      createdBy: json["created_by"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      referenceId: json["reference_id"],
      isExpired: json["is_expired"],
      company: json["company"] != null
          ? AnbocasCompanyModel.fromJson(json["company"])
          : null,
      tickets: json["tickets"] != null
          ? (json["tickets"] as List)
              .map(
                (e) => AnbocasTicketModel.fromJson(e),
              )
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
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
      "location_type": locationType,
      "meeting_link": meetingLink,
      "start_date": startDate,
      "end_date": endDate,
      "is_booking_open": isBookingOpen,
      "is_free": isFree,
      "is_public": isPublic,
      "absorb_platform_fee": absorbPlatformFee,
      "group_ticketing_allowed": groupTicketingAllowed,
      "status": status,
      "created_by": createdBy,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "is_expired": isExpired,
      "company": company,
      "tickets": tickets.map((e) => e.toJson()).toList(),
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
    String? startDate,
    String? endDate,
    int? isBookingOpen,
    int? isFree,
    int? isPublic,
    int? absorbPlatformFee,
    int? groupTicketingAllowed,
    String? status,
    String? createdBy,
    String? createdAt,
    String? updatedAt,
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
