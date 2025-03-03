class AppConstants {
  AppConstants._();

  // Hive Box Names
  static const String userBox = 'userBox';
  static const String productBox = 'productBox';
  static const String cartBox = 'cartBox';
  static const String orderBox = 'orderBox';

  // API Constants
  static const String baseUrl = 'https://api.yourdomain.com'; // Will be used later
  static const int apiTimeout = 30000; // 30 seconds

  // Auth Constants
  static const String tokenKey = 'auth_token';
  static const String userKey = 'current_user';
}