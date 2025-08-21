import 'package:equatable/equatable.dart';

import 'package:anbocas_tickets_api/src/companies/constants/anbocas_company_status.dart';
import 'package:anbocas_tickets_api/src/shared/models/anbocas_currency_model.dart';
import 'package:anbocas_tickets_api/src/shared/utils/data_serializer.dart';

class AnbocasCompanyModel extends Equatable {
  final String? id;
  final String? name;
  final String? slug;
  final String? parentId;
  final String? logo;
  final String? parentCommission;
  final AnbocasCompanyStatus? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? phoneNumber;
  final String? ifscCode;
  final String? accountNumber;
  final String? location;
  final String? taxId;
  final String? supportEmail;
  final int? totalTicketSold;
  final int? eventCount;
  final double? totalSales;
  final String? currencyId;
  final String? brandColor;
  final AnbocasCurrencyModel? currency;

  const AnbocasCompanyModel({
    this.status,
    this.createdAt,
    this.updatedAt,
    this.phoneNumber,
    this.ifscCode,
    this.accountNumber,
    this.location,
    this.taxId,
    this.supportEmail,
    this.totalTicketSold,
    this.eventCount,
    this.totalSales,
    this.id,
    this.name,
    this.slug,
    this.currencyId,
    this.brandColor,
    this.logo,
    this.parentId,
    this.parentCommission,
    this.currency,
  });

  @override
  List<Object?> get props => [
        status,
        createdAt,
        updatedAt,
        phoneNumber,
        ifscCode,
        accountNumber,
        location,
        taxId,
        supportEmail,
        totalTicketSold,
        eventCount,
        totalSales,
        id,
        name,
        slug,
        currencyId,
        brandColor,
        logo,
        parentId,
        parentCommission,
        currency,
      ];

  factory AnbocasCompanyModel.fromMap(Map<String, dynamic> map) {
    return AnbocasCompanyModel(
      id: map["id"],
      name: map["name"],
      slug: map["slug"],
      currencyId: map["currency_id"],
      brandColor: map["brand_color"],
      logo: map["logo"],
      parentId: map["parent_id"],
      parentCommission: map["parent_commission"],
      currency: map["currency"] != null
          ? AnbocasCurrencyModel.fromMap(map["currency"])
          : null,
      status: map['status'] != null
          ? AnbocasCompanyStatus.fromValue(map['status'])
          : null,
      createdAt: DateTime.tryParse(map['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ''),
      phoneNumber: map['phone'],
      ifscCode: map['ifsc_code'],
      accountNumber: map['account_number'],
      location: map['location'],
      taxId: map['tax_id'],
      supportEmail: map['support_email'],
      totalTicketSold: DataSerializer.toInt(map['total_ticket_sold']),
      eventCount: DataSerializer.toInt(map['event_count']),
      totalSales: DataSerializer.toDouble(map['total_sales']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "status": status,
      "created_at": createdAt.toString(),
      "phone": phoneNumber,
      "updated_at": updatedAt.toString(),
      "logo": logo,
      "parent_id": parentId,
      "parent_commission": parentCommission,
      "ifsc_code": ifscCode,
      "account_number": accountNumber,
      "location": location,
      "tax_id": taxId,
      "support_email": supportEmail,
      "total_ticket_sold": totalTicketSold,
      "total_sales": totalSales,
      "event_count": eventCount,
    };
  }

  AnbocasCompanyModel copyWith({
    String? id,
    String? name,
    String? slug,
    String? parentId,
    String? logo,
    String? parentCommission,
    AnbocasCompanyStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? phoneNumber,
    String? ifscCode,
    String? accountNumber,
    String? location,
    String? taxId,
    String? supportEmail,
    int? totalTicketSold,
    int? eventCount,
    double? totalSales,
    String? currencyId,
    String? brandColor,
    AnbocasCurrencyModel? currency,
  }) {
    return AnbocasCompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      parentId: parentId ?? this.parentId,
      logo: logo ?? this.logo,
      parentCommission: parentCommission ?? this.parentCommission,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      accountNumber: accountNumber ?? this.accountNumber,
      location: location ?? this.location,
      taxId: taxId ?? this.taxId,
      supportEmail: supportEmail ?? this.supportEmail,
      totalTicketSold: totalTicketSold ?? this.totalTicketSold,
      eventCount: eventCount ?? this.eventCount,
      totalSales: totalSales ?? this.totalSales,
      currencyId: currencyId ?? this.currencyId,
      brandColor: brandColor ?? this.brandColor,
      currency: currency ?? this.currency,
    );
  }
}
