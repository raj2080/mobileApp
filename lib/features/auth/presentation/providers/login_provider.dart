import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/login_state.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:blushstore_project/app/constants/app_constants.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  void updateEmail(String email) {
    state = state.copyWith(
      email: email.toLowerCase().trim(),
      errorMessage: '',
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, errorMessage: '');
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  Future<bool> login() async {
    if (!state.isValid) {
      state = state.copyWith(
        errorMessage: 'Please enter both email and password',
      );
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      final response = await http.post(
        Uri.parse(AppConstants.loginUrl),
        headers: AppConstants.headers,
        body: json.encode({
          'email': state.email,
          'password': state.password,
        }),
      ).timeout(
        Duration(milliseconds: AppConstants.apiTimeout),
        onTimeout: () {
          throw TimeoutException('Connection timed out');
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // Store user data in Hive after successful login
        final userBox = Hive.box(AppConstants.userBox);
        await userBox.put('lastLoginTime', AppConstants.currentTimestamp);
        await userBox.put('currentUser', AppConstants.currentUser);

        // Store the token if your backend sends one
        if (responseData['token'] != null) {
          await userBox.put('token', responseData['token']);
        }

        state = state.copyWith(
          isLoading: false,
          errorMessage: '',
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: responseData['message'] ?? 'Invalid email or password',
        );
        return false;
      }
    } on SocketException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: AppConstants.connectionError,
      );
      return false;
    } on TimeoutException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Request timed out. Please try again.',
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: AppConstants.serverError,
      );
      return false;
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});