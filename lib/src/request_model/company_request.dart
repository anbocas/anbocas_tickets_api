import 'package:dio/dio.dart';

abstract class CompanyRequest {
  dynamic toJson();
  bool validate();
}

class CompanyGetRequest extends CompanyRequest {
  final int page;
  final bool paginate;
  final String? search;
  final int pageLength;

  CompanyGetRequest({
    this.page = 1,
    this.paginate = true,
    this.search,
    this.pageLength = 10,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'paginate': paginate,
      'search': search,
      'page_length': pageLength,
    };
  }

  @override
  bool validate() {
    return true;
  }
}

class CreateCompanyRequest extends CompanyRequest {
  final String name;
  final String currencyId;
  final String brandColor;
  final String? website;
  final String? location;
  final String? phone;
  final String? taxId;
  final String? supportPhone;
  final String? supportEmail;
  final String? parentCommission;
  final String? parentId;
  final String? bannerFilePath;
  final String? logoFilePath;
  final String? description;

  CreateCompanyRequest({
    required this.name,
    this.location,
    this.phone,
    this.taxId,
    required this.currencyId,
    this.supportPhone,
    this.parentCommission,
    this.bannerFilePath,
    this.logoFilePath,
    this.parentId,
    this.supportEmail,
    this.brandColor = '#000000',
    this.website,
    this.description,
  });

  @override
  Future<FormData> toJson() async {
    MultipartFile? logo;
    if (logoFilePath != null) {
      logo = await MultipartFile.fromFile(logoFilePath!,
          filename: bannerFilePath?.split('/').last);
    }
    MultipartFile? banner;
    if (bannerFilePath != null) {
      banner = await MultipartFile.fromFile(bannerFilePath!,
          filename: bannerFilePath?.split('/').last);
    }

    var formData = FormData.fromMap({
      'logo': logo,
      'banner': banner,
      'name': name,
      'website': website,
      'location': location,
      'phone': phone,
      'tax_id': taxId,
      'currency_id': currencyId,
      'brand_color': brandColor,
      'support_phone': supportPhone,
      'support_email': supportEmail,
      'parent_comission': parentCommission,
      'parent_id': parentId,
    });

    return formData;
  }

  @override
  bool validate() {
    // Add validation logic here if needed
    return true;
  }
}

class UpdateCompanyRequest extends CompanyRequest {
  final String companyId;
  final String? name;
  final String? description;
  final String? website;
  final String? location;
  final String? latitude;
  final String? longitude;
  final String? startDate;
  final String? endDate;
  final String? bannerFilePath;

  UpdateCompanyRequest({
    required this.companyId,
    this.name,
    this.description,
    this.website,
    this.location,
    this.latitude,
    this.longitude,
    this.startDate,
    this.endDate,
    this.bannerFilePath,
  });

  @override
  Future<FormData> toJson() async {
    MultipartFile? banner;
    if (bannerFilePath != null) {
      banner = await MultipartFile.fromFile(bannerFilePath!,
          filename: bannerFilePath?.split('/').last);
    }
    var formData = FormData();

    if (name != null) formData.fields.add(MapEntry('name', name!));
    if (description != null) {
      formData.fields.add(MapEntry('description', description!));
    }
    if (website != null) formData.fields.add(MapEntry('website', website!));
    if (location != null) formData.fields.add(MapEntry('location', location!));
    if (latitude != null) formData.fields.add(MapEntry('latitude', latitude!));
    if (longitude != null) {
      formData.fields.add(MapEntry('longitude', longitude!));
    }
    if (startDate != null) {
      formData.fields.add(MapEntry('start_date', startDate!));
    }
    if (endDate != null) formData.fields.add(MapEntry('end_date', endDate!));
    if (banner != null) formData.files.add(MapEntry('banner', banner));

    return formData;
  }

  @override
  bool validate() {
    return true;
  }
}
