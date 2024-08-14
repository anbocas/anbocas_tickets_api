import 'package:anbocas_tickets_api/src/api/constant.dart';
import 'package:anbocas_tickets_api/src/api/exception/handle_exception.dart';
import 'package:anbocas_tickets_api/src/request_model/company_request.dart';
import 'package:anbocas_tickets_api/src/model/company_model.dart';
import 'package:anbocas_tickets_api/src/request_client.dart';

class CompanyApi {
  final RequestClient _client;

  CompanyApi({required RequestClient client}) : _client = client;

  Future<List<AnbocasCompanyModel>?> get(CompanyGetRequest req) async {
    try {
      final response = await _client.dio.get(
        ApiConstant.COMPANY_END_POINT,
        queryParameters: req.toJson(),
      );
      return (response.data['data'] as List)
          .map((e) => AnbocasCompanyModel.fromJson(e))
          .toList();
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  Future<AnbocasCompanyModel?> details({
    required String companyId,
  }) async {
    try {
      final response = await _client.dio.get(
        '${ApiConstant.COMPANY_END_POINT}/$companyId',
      );

      if (response.statusCode == 200) {
        return AnbocasCompanyModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to get company: ${response.statusMessage}");
      }
    } catch (error) {
      handleError(error);
      return null;
    }
  }

  Future<AnbocasCompanyModel?> createCompany(CreateCompanyRequest req) async {
    try {
      var formData = await req.toJson();

      final response = await _client.dio.post(
        '${ApiConstant.COMPANY_END_POINT}/create',
        data: formData,
      );

      if (response.statusCode == 200) {
        return AnbocasCompanyModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to create company: ${response.statusMessage}");
      }
    } catch (error) {
      handleError(error);
      return null;
    }
  }

  Future<bool> deleteCompany({
    required String companyId,
  }) async {
    try {
      final response = await _client.dio.delete(
        '${ApiConstant.COMPANY_END_POINT}/$companyId',
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to delete company: ${response.statusMessage}");
      }
    } catch (error) {
      handleError(error);
      return false;
    }
  }

  Future<AnbocasCompanyModel?> updateCompany(UpdateCompanyRequest req) async {
    try {
      var formData = await req.toJson();
      final response = await _client.dio.put(
        '${ApiConstant.COMPANY_END_POINT}/${req.companyId}',
        data: formData,
      );

      if (response.statusCode == 200) {
        return AnbocasCompanyModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to update company: ${response.statusMessage}");
      }
    } catch (error) {
      handleError(error);
      return null;
    }
  }
}
