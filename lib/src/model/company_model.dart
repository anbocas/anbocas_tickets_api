import 'package:anbocas_tickets_api/src/model/currency_model.dart';

class AnbocasCompanyModel {
  String? id;
  String? userId;
  String? name;
  String? slug;
  String? currencyId;
  String? brandColor;
  String? logo;
  dynamic parentId;
  String? parentCommission;
  Currency? currency;

  AnbocasCompanyModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["user_id"] is String) {
      userId = json["user_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["slug"] is String) {
      slug = json["slug"];
    }
    if (json["currency_id"] is String) {
      currencyId = json["currency_id"];
    }
    if (json["brand_color"] is String) {
      brandColor = json["brand_color"];
    }
    if (json["logo"] is String) {
      logo = json["logo"];
    }
    parentId = json["parent_id"];
    if (json["parent_commission"] is String) {
      parentCommission = json["parent_commission"];
    }
    if (json["currency"] is Map) {
      currency =
          json["currency"] == null ? null : Currency.fromJson(json["currency"]);
    }
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
}
