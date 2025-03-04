class AppConstants {
  AppConstants._();

  // Current Time and User
  static const String currentTimestamp = '2025-03-04 13:16:20';
  static const String currentUser = '2025raj';

  // Hive Box Names
  static const String userBox = 'userBox';
  static const String productBox = 'productBox';
  static const String cartBox = 'cartBox';
  static const String orderBox = 'orderBox';

  // API Constants
  static const String baseUrl = 'http://10.0.2.2:5000'; // For Android Emulator
  // static const String baseUrl = 'http://localhost:5000'; // For iOS Simulator
  static const String apiUrl = '$baseUrl/api';
  static const String authUrl = '$apiUrl/users';
  static const String signupUrl = '$authUrl/signup';
  static const String loginUrl = '$authUrl/login';
  static const int apiTimeout = 30000; // 30 seconds

  // Auth Constants
  static const String tokenKey = 'auth_token';
  static const String userKey = 'current_user';

  // HTTP Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Validation Messages
  static const String requiredFieldsError = 'All fields are required';
  static const String invalidEmailError = 'Please enter a valid email';
  static const String passwordMismatchError = 'Passwords do not match';
  static const String usernameError = 'Username must be between 1 and 10 characters';
  static const String passwordLengthError = 'Password must be at least 6 characters';

  // Response Messages
  static const String connectionError = 'Cannot connect to server. Please check your internet connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String signupSuccess = 'Account created successfully! Please login.';
  static const String signupFailed = 'Registration failed. Please try again.';
  static const String loginSuccess = 'Login successful!';
  static const String loginFailed = 'Login failed. Please try again.';
}