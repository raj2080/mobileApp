import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  // Use your actual backend URL
  static const String _baseUrl = 'http://10.0.2.2:5000/api'; // For Android Emulator
  // static const String _baseUrl = 'http://localhost:5000/api'; // For iOS Simulator

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Connection timeout. Please check your internet connection.');
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Failed to login. Please try again.');
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        throw Exception('Unable to connect to server. Please check your internet connection or try again later.');
      }
      throw Exception('Failed to connect to server: ${e.toString()}');
    }
  }
}