import 'package:anbocas_tickets_api/src/model/currency_model.dart';

class CompanyModel {
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

  CompanyModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["name"] = name;
    _data["slug"] = slug;
    _data["currency_id"] = currencyId;
    _data["brand_color"] = brandColor;
    _data["logo"] = logo;
    _data["parent_id"] = parentId;
    _data["parent_commission"] = parentCommission;
    if (currency != null) {
      _data["currency"] = currency?.toJson();
    }
    return _data;
  }
}
