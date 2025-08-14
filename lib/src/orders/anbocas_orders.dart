import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/orders/constants/anbocas_order_routes.dart';
import 'package:anbocas_tickets_api/src/orders/models/anbocas_order_model.dart';

class AnbocasOrders {
  Future<AnbocasPaginatedResponse<List<AnbocasOrderModel>>> getOrders({
    required String companyId,
    int page = 1,
    bool paginate = true,
    int pageLength = 5,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        AnbocasOrderRoutes.getOrders,
        queryParameters: {
          'company_id': companyId,
          'paginate': paginate,
          'page': page,
          'page_length': pageLength,
        },
      );

      final data = response.data['data'];
      final statusResponse = response.data['status'];

      if (data["data"] != null && statusResponse != null) {
        final orders = (data["data"] as List)
            .map((e) => AnbocasOrderModel.fromJson(e))
            .toList();

        return AnbocasPaginatedResponse(
          data: orders,
          currentPage: data['current_page'],
          lastPage: data['last_page'],
          perPage: data['per_page'],
          status: AnbocasStatusModel.fromMap(statusResponse),
        );
      }

      throw Exception();
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<AnbocasOrderModel?> getOrder(String orderId) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        AnbocasOrderRoutes.getOrderDetails(orderId),
      );

      if (response.statusCode == 200) {
        return AnbocasOrderModel.fromJson(response.data['data']);
      } else {
        throw Exception("Failed to fetch order: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<bool> cancelOrder(String orderId) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;
      final response = await dio.post(
        AnbocasOrderRoutes.cancelOrder,
        data: {
          'order_id': orderId,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to fetch order: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  Future<bool> verifyOrderPayment(String razorpayPaymentId) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;
      final response = await dio.post(
        AnbocasOrderRoutes.verifyOrderPayment,
        data: {
          'razorpay_payment_id': razorpayPaymentId,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to fetch order: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }
}
