import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/signup_state.dart';
import 'package:flutter/foundation.dart';
import 'package:blushstore_project/app/constants/app_constants.dart';

class SignupNotifier extends StateNotifier<SignupState> {
  SignupNotifier() : super(SignupState());

  void updateEmail(String email) {
    state = state.copyWith(
      email: email.toLowerCase().trim(),
      errorMessage: '',
    );
    _validateForm(); // Validate on each change
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, errorMessage: '');
    _validateForm(); // Validate on each change
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword, errorMessage: '');
    _validateForm(); // Validate on each change
  }

  void updateUsername(String username) {
    state = state.copyWith(
      username: username.toLowerCase().trim(),
      errorMessage: '',
    );
    _validateForm(); // Validate on each change
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    );
  }

  bool _validateForm() {
    if (state.username.isEmpty || state.email.isEmpty ||
        state.password.isEmpty || state.confirmPassword.isEmpty) {
      state = state.copyWith(errorMessage: AppConstants.requiredFieldsError);
      return false;
    }

    if (state.username.length < 1 || state.username.length > 10) {
      state = state.copyWith(errorMessage: AppConstants.usernameError);
      return false;
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(state.username)) {
      state = state.copyWith(
          errorMessage: 'Username can only contain letters, numbers, and underscores'
      );
      return false;
    }

    if (!RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$')
        .hasMatch(state.email)) {
      state = state.copyWith(errorMessage: AppConstants.invalidEmailError);
      return false;
    }

    if (state.password.length < 6) {
      state = state.copyWith(errorMessage: AppConstants.passwordLengthError);
      return false;
    }

    if (state.password != state.confirmPassword) {
      state = state.copyWith(errorMessage: AppConstants.passwordMismatchError);
      return false;
    }

    state = state.copyWith(errorMessage: ''); // Clear error if validation passes
    return true;
  }

  Future<bool> signup() async {
    if (!_validateForm()) {
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      debugPrint('Attempting signup with data:');
      debugPrint('Username: ${state.username}');
      debugPrint('Email: ${state.email}');
      debugPrint('Password length: ${state.password.length}');
      debugPrint('Timestamp: ${AppConstants.currentTimestamp}');
      debugPrint('API URL: ${AppConstants.signupUrl}');

      final response = await http.post(
        Uri.parse(AppConstants.signupUrl),
        headers: AppConstants.headers,
        body: json.encode({
          'username': state.username.toLowerCase().trim(),
          'email': state.email.toLowerCase().trim(),
          'password': state.password,
          'confirmPassword': state.confirmPassword,
          'timestamp': AppConstants.currentTimestamp,
          'currentUser': AppConstants.currentUser
        }),
      ).timeout(
        Duration(milliseconds: AppConstants.apiTimeout),
        onTimeout: () {
          throw TimeoutException('Connection timed out');
        },
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 201) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '',
        );
        return true;
      } else {
        final responseData = json.decode(response.body);
        final errorMessage = responseData['message'] ??
            responseData['error'] ??
            AppConstants.signupFailed;

        state = state.copyWith(
          isLoading: false,
          errorMessage: errorMessage,
        );
        return false;
      }
    } on SocketException catch (e) {
      debugPrint('Socket Exception: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: AppConstants.connectionError,
      );
      return false;
    } on TimeoutException catch (e) {
      debugPrint('Timeout Exception: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Request timed out. Please try again.',
      );
      return false;
    } on http.ClientException catch (e) {
      debugPrint('HTTP Client Exception: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Cannot connect to server. Is the backend running?',
      );
      return false;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: AppConstants.serverError,
      );
      return false;
    }
  }
}

final signupProvider = StateNotifierProvider<SignupNotifier, SignupState>((ref) {
  return SignupNotifier();
});