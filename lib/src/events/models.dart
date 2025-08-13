import 'dart:convert';

import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/events/constants.dart';
import 'package:anbocas_tickets_api/src/shared/ticket_model.dart';
import 'package:equatable/equatable.dart';

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
  final String? locationType;
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
  final List<TicketModel> tickets;
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
      locationType: json["location_type"],
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
                (e) => TicketModel.fromJson(e),
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

  AnbocasEventLocationType getLocationType() {
    if (locationType == "VIRTUAL") {
      return AnbocasEventLocationType.virtual;
    } else {
      return AnbocasEventLocationType.inPerson;
    }
  }
}

class AnbocasEventStatusModel extends AnbocasStatusModel {
  final int all;
  final int published;
  final int draft;
  final int cancelled;
  final int deleted;

  const AnbocasEventStatusModel({
    required this.all,
    required this.published,
    required this.draft,
    required this.cancelled,
    required this.deleted,
  });

  AnbocasEventStatusModel copyWith({
    int? all,
    int? published,
    int? draft,
    int? cancelled,
    int? deleted,
  }) {
    return AnbocasEventStatusModel(
      all: all ?? this.all,
      published: published ?? this.published,
      draft: draft ?? this.draft,
      cancelled: cancelled ?? this.cancelled,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ALL': all,
      'PUBLISHED': published,
      'DRAFT': draft,
      'CANCELLED': cancelled,
      'DELETED': deleted,
    };
  }

  factory AnbocasEventStatusModel.fromMap(Map<String, dynamic> map) {
    return AnbocasEventStatusModel(
      all: map['ALL'] as int,
      published: map['PUBLISHED'] as int,
      draft: map['DRAFT'] as int,
      cancelled: map['CANCELLED'] as int,
      deleted: map['DELETED'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnbocasEventStatusModel.fromJson(String source) =>
      AnbocasEventStatusModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      all,
      published,
      draft,
      cancelled,
      deleted,
    ];
  }
}

class AnbocasEventStatsModel extends Equatable {
  final String? title;
  final int? value;
  final bool? isAmount;

  const AnbocasEventStatsModel({
    this.title,
    this.value,
    this.isAmount,
  });

  @override
  List<Object?> get props => [];

  factory AnbocasEventStatsModel.fromJson(Map<String, dynamic> json) {
    return AnbocasEventStatsModel(
      title: json["title"],
      value: json["value"],
      isAmount: json["is_amount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "value": value,
      "is_amount": isAmount,
    };
  }
}
