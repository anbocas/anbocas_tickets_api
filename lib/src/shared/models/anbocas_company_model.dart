import 'package:equatable/equatable.dart';

import 'package:anbocas_tickets_api/src/shared/models/anbocas_currency_model.dart';

class AnbocasCompanyModel extends Equatable {
  final String? id;
  final String? userId;
  final String? name;
  final String? slug;
  final String? currencyId;
  final String? brandColor;
  final String? logo;
  final String? parentId;
  final String? parentCommission;
  final AnbocasCurrencyModel? currency;

  const AnbocasCompanyModel({
    this.id,
    this.userId,
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
        id,
        userId,
        name,
        slug,
        currencyId,
        brandColor,
        logo,
        parentId,
        parentCommission,
        currency,
      ];

  factory AnbocasCompanyModel.fromJson(Map<String, dynamic> json) {
    return AnbocasCompanyModel(
      id: json["id"],
      userId: json["user_id"],
      name: json["name"],
      slug: json["slug"],
      currencyId: json["currency_id"],
      brandColor: json["brand_color"],
      logo: json["logo"],
      parentId: json["parent_id"],
      parentCommission: json["parent_commission"],
      currency: json["currency"] != null
          ? AnbocasCurrencyModel.fromJson(json["currency"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["user_id"] = userId;
    data["name"] = name;
    data["slug"] = slug;
    data["currency_id"] = currencyId;
    data["brand_color"] = brandColor;
    data["logo"] = logo;
    data["parent_id"] = parentId;
    data["parent_commission"] = parentCommission;
    if (currency != null) {
      data["currency"] = currency?.toJson();
    }
    return data;
  }

  AnbocasCompanyModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? slug,
    String? currencyId,
    String? brandColor,
    String? logo,
    String? parentId,
    String? parentCommission,
    AnbocasCurrencyModel? currency,
  }) {
    return AnbocasCompanyModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      currencyId: currencyId ?? this.currencyId,
      brandColor: brandColor ?? this.brandColor,
      logo: logo ?? this.logo,
      parentId: parentId ?? this.parentId,
      parentCommission: parentCommission ?? this.parentCommission,
      currency: currency ?? this.currency,
    );
  }
}
