abstract final class AnbocasOrderRoutes {
  static String getOrders = '/v1/orders';
  static String getOrderDetails(String id) => '/v1/orders/$id';
  static String cancelOrder = '/v1/order/cancel';
  static String verifyOrderPayment = '/v1/verifyOrderPayment';
}
