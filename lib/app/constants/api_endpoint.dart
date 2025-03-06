class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3001/api";
  // static const String baseUrl = "http://localhost:5500/api/";
  static const limit = 10;
  // Optionally, adjust the baseUrl to match your network setup or deployment environment

  // ====================== User Routes ======================
  static const String login = "$baseUrl/user/login"; // Endpoint for user login
  static const String getuser = "$baseUrl/user/me"; // Endpoint for user login
  static const String register = "$baseUrl/user/create"; // Endpoint for user registration
  static const String changePassword = "$baseUrl/user/change-password";

  static const String getProducts = '$baseUrl/product/pagination';
  static String getReviewUrl(String productId) {
    return "$baseUrl/review/$productId";
  }

  // static const String getReview="$baseUrl/api/review/$productId";
  static const String submitReview = "$baseUrl/review";

  static const String productImage = 'http://10.0.2.2:5500/products/';

  // ====================== Order Routes ======================
  static const String createOrder = "$baseUrl/order/create-Order";
  static const String getUserOrders = "$baseUrl/order/get-user-orders";
  static const String getSingleOrder = "$baseUrl/order/single-order";
  static const String getAllOrders = "$baseUrl/order/all-orders";
  static const String updateOrderStatus = "$baseUrl/order/update-orderStatus";
  static const String deleteOrder = "$baseUrl/order/delete-order";
  static const String getSingleOrderAdmin = "$baseUrl/order/single-order-admin";
}
