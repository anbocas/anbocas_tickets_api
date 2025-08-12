import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:anbocas_tickets_api/src/orders/constants.dart';
import 'package:anbocas_tickets_api/src/orders/order_response.dart';
import 'package:anbocas_tickets_api/src/orders/single_order_data.dart';

class AnbocasOrders {
  // Fetch orders
  Future<OrderResponse?> getOrders({
    required String companyId,
    int page = 1,
    bool paginate = true,
    int pageLength = 5,
  }) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      var queryParameters = {
        'company_id': companyId,
        'paginate': paginate,
        'page': page,
        'page_length': pageLength,
      };

      final response = await dio.get(
        OrderRoutes.getOrders,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return OrderResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch orders: ${response.statusMessage}");
      }
    } catch (e, st) {
      throw AnbocasApiException.fromException(e, st);
    }
  }

  // Get specific order
  Future<SingleOrderData?> getOrderDetails(String orderId) async {
    try {
      final dio = AnbocasTicketsConfig.instance.dio;

      final response = await dio.get(
        OrderRoutes.getOrderDetails(orderId),
      );

      if (response.statusCode == 200) {
        return SingleOrderData.fromJson(response.data['data']);
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
        OrderRoutes.cancelOrder,
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
        OrderRoutes.verifyOrderPayment,
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
