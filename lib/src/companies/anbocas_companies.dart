import 'dart:io';

import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/companies/constants/anbocas_company_routes.dart';
import 'package:dio/dio.dart';

class AnbocasCompanies {
  Future<AnbocasPaginatedResponse<List<AnbocasCompanyModel>>> getCompanies({
    int page = 1,
    required bool paginate,
    String? search,
    int pageLength = 10,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        AnbocasCompanyRoutes.getCompanies,
        queryParameters: {
          'page': page,
          'paginate': paginate,
          'search': search,
          'page_length': pageLength,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data['data'];
        final statusResponse = response.data['status'];

        final companies = ((paginate ? data["data"] : data) as List)
            .map((e) => AnbocasCompanyModel.fromMap(e))
            .toList();

        return AnbocasPaginatedResponse(
          data: companies,
          currentPage: paginate ? data['current_page'] : null,
          lastPage: paginate ? data['last_page'] : null,
          perPage: paginate ? data['per_page'] : null,
          status: AnbocasStatusModel.fromMap(statusResponse),
        );
      }

      throw Exception();
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<AnbocasCompanyModel> getCompany(String companyId) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        AnbocasCompanyRoutes.getCompanyDetails(companyId),
      );

      if (response.statusCode == 200) {
        return AnbocasCompanyModel.fromMap(response.data['data']);
      } else {
        throw Exception("Failed to get company: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<AnbocasCompanyModel> createCompany({
    required String name,
    required String currencyId,
    String brandColor = "#000000",
    String? website,
    String? location,
    String? phone,
    String? taxId,
    String? supportPhone,
    String? supportEmail,
    String? parentCommission,
    String? parentId,
    String? logoFilePath,
  }) async {
    try {
      MultipartFile? logo;

      if (logoFilePath != null && logoFilePath.isNotEmpty) {
        logo = await MultipartFile.fromFile(
          logoFilePath,
          filename: logoFilePath.split('/').last,
        );
      }

      final formData = FormData.fromMap({
        'logo': logo,
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

      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.post(
        AnbocasCompanyRoutes.createCompany,
        data: formData,
      );

      if (response.statusCode == 200) {
        return AnbocasCompanyModel.fromMap(response.data['data']);
      } else {
        throw Exception("Failed to create company: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<bool> deleteCompany({
    required String companyId,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.delete(
        AnbocasCompanyRoutes.deleteCompany(companyId),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to delete company: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<AnbocasCompanyModel> updateCompany({
    required String companyId,
    String? name,
    String? currencyId,
    String brandColor = "#000000",
    String? website,
    String? location,
    String? phone,
    String? taxId,
    String? supportPhone,
    String? supportEmail,
    String? parentCommission,
    String? parentId,
    String? logoFilePath,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;
      MultipartFile? logo;

      if (logoFilePath != null && logoFilePath.isNotEmpty) {
        logo = await MultipartFile.fromFile(
          logoFilePath,
          filename: logoFilePath.split('/').last,
        );
      }
      final data = <String, dynamic>{};
      data['logo'] = logo;
      data['name'] = name;
      data['website'] = website;
      data['location'] = location;
      data['phone'] = phone;
      data['tax_id'] = taxId;
      data['currency_id'] = currencyId;
      data['brand_color'] = brandColor;
      data['support_phone'] = supportPhone;
      data['support_email'] = supportEmail;
      data['parent_comission'] = parentCommission;
      data['parent_id'] = parentId;

      final formData = FormData.fromMap(data);
      final response = await dio.post(
        AnbocasCompanyRoutes.updateCompany(companyId),
        data: formData,
      );

      if (response.statusCode == 200) {
        return AnbocasCompanyModel.fromMap(response.data['data']);
      } else {
        throw Exception("Failed to update company: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }
}
