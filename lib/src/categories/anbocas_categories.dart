import 'dart:io';

import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/categories/constants/anbocas_category_routes.dart';

class AnbocasCategories {
  Future<AnbocasPaginatedResponse<List<AnbocasCategoryModel>>> getCategories({
    int page = 1,
    required bool paginate,
    String? search,
    int pageLength = 10,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        AnbocasCategoryRoutes.getCategories,
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

        final categories = ((paginate ? data["data"] : data) as List)
            .map((e) => AnbocasCategoryModel.fromJson(e))
            .toList();

        return AnbocasPaginatedResponse(
          data: categories,
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

  Future<AnbocasCategoryModel> getCategory(String categoryId) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        AnbocasCategoryRoutes.getCategoryDetails(categoryId),
      );

      if (response.statusCode == 200) {
        return AnbocasCategoryModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to get company: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  // Future<AnbocasCompanyModel> createCompany({
  //   required String name,
  //   required String currencyId,
  //   String brandColor = "#000000",
  //   String? website,
  //   String? location,
  //   String? phone,
  //   String? taxId,
  //   String? supportPhone,
  //   String? supportEmail,
  //   String? parentCommission,
  //   String? parentId,
  //   String? bannerFilePath,
  //   String? logoFilePath,
  //   String? description,
  // }) async {
  //   try {
  //     MultipartFile? logo;
  //     MultipartFile? banner;

  //     if (logoFilePath != null) {
  //       logo = await MultipartFile.fromFile(
  //         logoFilePath,
  //         filename: bannerFilePath?.split('/').last,
  //       );
  //     }
  //     if (bannerFilePath != null) {
  //       banner = await MultipartFile.fromFile(bannerFilePath,
  //           filename: bannerFilePath.split('/').last);
  //     }

  //     final formData = FormData.fromMap({
  //       'logo': logo,
  //       'banner': banner,
  //       'name': name,
  //       'website': website,
  //       'location': location,
  //       'phone': phone,
  //       'tax_id': taxId,
  //       'currency_id': currencyId,
  //       'brand_color': brandColor,
  //       'support_phone': supportPhone,
  //       'support_email': supportEmail,
  //       'parent_comission': parentCommission,
  //       'parent_id': parentId,
  //     });

  //     final dio = AnbocasTicketsConfig.instance.dio;

  //     final response = await dio.post(
  //       AnbocasCompanyRoutes.createCompany,
  //       data: formData,
  //     );

  //     if (response.statusCode == 200) {
  //       return AnbocasCompanyModel.fromJson(response.data['data']);
  //     } else {
  //       throw Exception("Failed to create company: ${response.statusMessage}");
  //     }
  //   } catch (e, st) {
  //     throw AnbocasApiException.fromException(e, st);
  //   }
  // }

  // Future<bool> deleteCompany({
  //   required String companyId,
  // }) async {
  //   try {
  //     final dio = AnbocasTicketsConfig.instance.dio;

  //     final response = await dio.delete(
  //       AnbocasCompanyRoutes.deleteCompany(companyId),
  //     );

  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       throw Exception("Failed to delete company: ${response.statusMessage}");
  //     }
  //   } catch (e, st) {
  //     throw AnbocasApiException.fromException(e, st);
  //   }
  // }

  // Future<AnbocasCompanyModel?> updateCompany({
  //   required String companyId,
  //   String? name,
  //   String? description,
  //   String? website,
  //   String? location,
  //   String? latitude,
  //   String? longitude,
  //   String? startDate,
  //   String? endDate,
  //   String? bannerFilePath,
  // }) async {
  //   try {
  //     final dio = AnbocasTicketsConfig.instance.dio;

  //     MultipartFile? banner;
  //     if (bannerFilePath != null) {
  //       banner = await MultipartFile.fromFile(bannerFilePath,
  //           filename: bannerFilePath.split('/').last);
  //     }
  //     var formData = FormData();

  //     if (name != null) formData.fields.add(MapEntry('name', name));
  //     if (description != null) {
  //       formData.fields.add(MapEntry('description', description));
  //     }
  //     if (website != null) formData.fields.add(MapEntry('website', website));
  //     if (location != null) formData.fields.add(MapEntry('location', location));
  //     if (latitude != null) formData.fields.add(MapEntry('latitude', latitude));
  //     if (longitude != null) {
  //       formData.fields.add(MapEntry('longitude', longitude));
  //     }
  //     if (startDate != null) {
  //       formData.fields.add(MapEntry('start_date', startDate));
  //     }
  //     if (endDate != null) formData.fields.add(MapEntry('end_date', endDate));
  //     if (banner != null) formData.files.add(MapEntry('banner', banner));

  //     final response = await dio.put(
  //       AnbocasCompanyRoutes.updateCompany(companyId),
  //       data: formData,
  //     );

  //     if (response.statusCode == 200) {
  //       return AnbocasCompanyModel.fromJson(response.data['data']);
  //     } else {
  //       throw Exception("Failed to update company: ${response.statusMessage}");
  //     }
  //   } catch (e, st) {
  //     throw AnbocasApiException.fromException(e, st);
  //   }
  // }
}
