
import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/api/constant.dart';
import 'package:anbocas_tickets_api/src/api/exception/handle_exception.dart';
import 'package:anbocas_tickets_api/src/request_client.dart';

class OrderApi {
  final RequestClient _client;

  OrderApi({required RequestClient client}) : _client = client;

  // Fetch orders
  Future<OrderResponse?> get({
    required String companyId,
    int page = 1,
    bool paginate = true,
    int pageLength = 5,
  }) async {
    try {
      var queryParameters = {
        'company_id': companyId,
        'paginate': paginate,
        'page': page,
        'page_length': pageLength,
      };

      final response = await _client.dio.get(
        ApiConstant.GET_ORDER,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return OrderResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch orders: ${response.statusMessage}");
      }
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  // Get specific order
  Future<SingleOrderData?> details({required String orderId}) async {
    try {
      final response = await _client.dio.get(
        '${ApiConstant.GET_ORDER}/$orderId',
      );

      if (response.statusCode == 200) {
        return SingleOrderData.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to fetch order: ${response.statusMessage}");
      }
    } catch (e) {
      handleError(e);
      return null;
    }
  }
}
