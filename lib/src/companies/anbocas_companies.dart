import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/companies/company_model.dart';
import 'package:anbocas_tickets_api/src/companies/company_request.dart';
import 'package:anbocas_tickets_api/src/companies/constants.dart';

class AnbocasCompanies {
  Future<List<AnbocasCompanyModel>?> getCompanies({
    int page = 1,
    required bool paginate,
    String? search,
    int pageLength = 10,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        CompanyRoutes.getCompanies,
        queryParameters: {
          'page': page,
          'paginate': paginate,
          'search': search,
          'page_length': pageLength,
        },
      );

      return (response.data['data'] as List)
          .map((e) => AnbocasCompanyModel.fromJson(e))
          .toList();
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<AnbocasCompanyModel?> details({
    required String companyId,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        CompanyRoutes.getCompanyDetails(companyId),
      );

      if (response.statusCode == 200) {
        return AnbocasCompanyModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to get company: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<AnbocasCompanyModel?> createCompany(CreateCompanyRequest req) async {
    try {
      var formData = await req.toJson();
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.post(
        CompanyRoutes.createCompany,
        data: formData,
      );

      if (response.statusCode == 200) {
        return AnbocasCompanyModel.fromJson(response.data['data']);
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
        CompanyRoutes.deleteCompany(companyId),
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

  Future<AnbocasCompanyModel?> updateCompany(UpdateCompanyRequest req) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;
      var formData = await req.toJson();
      final response = await dio.put(
        CompanyRoutes.updateCompany(req.companyId),
        data: formData,
      );

      if (response.statusCode == 200) {
        return AnbocasCompanyModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to update company: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }
}
